import 'dart:convert';
import 'dart:io';
import 'package:aac_command_line_support/aa_support/data_layer/data_model/gen_class_from_json.dart';
import 'package:aac_command_line_support/aa_support/data_layer/post_man/gen_config.dart';
import 'package:aac_command_line_support/aa_support/data_layer/post_man/generator_contract.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:recase/recase.dart';

class PostManGenConfig extends GenConfig {
  final String _modelsPath;

  final String _dtoPath;
  final String _responseModelsPath;
  final String _requestModelsPath;
  final String _repositoriesPath;

  PostManGenConfig({
    String modelsPath = "models",
    String dtoPath = "dto",
    String responseModelsPath = "response",
    String requestModelsPath = "request",
    String repositoriesPath = "repositories",
  })  : _modelsPath = modelsPath,
        _dtoPath = dtoPath,
        _responseModelsPath = responseModelsPath,
        _requestModelsPath = requestModelsPath,
        _repositoriesPath = repositoriesPath,
        super('data');

  String get requestModelsPath => "$rootSource${Platform.pathSeparator}$_dtoPath${Platform.pathSeparator}$_requestModelsPath";

  String get responseModelsPath => "$rootSource${Platform.pathSeparator}$_dtoPath${Platform.pathSeparator}$_responseModelsPath";

  String get dtoPath => "$rootSource${Platform.pathSeparator}$_dtoPath";

  String get modelsPath => "$rootSource${Platform.pathSeparator}$_modelsPath";

  String get repositoriesPath => "$rootSource${Platform.pathSeparator}$_repositoriesPath";
}

class PostManGenerator extends GeneratorContract<PostManGenConfig> {
  PostManGenerator() : super(genConfig: PostManGenConfig());

  Future<void> executed({String fileJson = "/Users/minhnguyen/Desktop/Inabe\ InabInabe.postman_collection.json"}) async {
    final file = File(fileJson);
    final retrofitTemplatePath = "package:aac_command_line_support/aa_support/data_layer/template/template_retrofit.dart";
    final requestTemplatePath = "package:aac_command_line_support/aa_support/data_layer/template/template_request.dart";
    var retrofitTemplate = await getStringFromPath(path: retrofitTemplatePath);
    var requestTemplate = await getStringFromPath(path: requestTemplatePath);
    //read json
    final jsonString = await file.readAsString();
    final data = json.decode(jsonString);

    final items = data['item'] as List<dynamic>;

    final serviceMap = <String, List<String>>{};
    final listRawRequest = <RawRequest>[];
    for (final item in items) {
      final requestName = item['name'] as String;
      final request = item['request'] as Map<String, dynamic>;
      final requestUrl = request['url'] as Map<String, dynamic>;
      final rawUrl = requestUrl["raw"];
      final path = List<String>.from(requestUrl['path']);
      final firstPath = path.first;

      final requestMethod = request['method'] as String;

      final requestHeaders = <String, String>{};
      final headers = request['header'] as List<dynamic>;
      for (final header in headers) {
        final key = header['key'] as String;
        final value = header['value'] as String;
        requestHeaders[key] = value;
      }

      final requestBody = request['body'] as Map<String, dynamic>?;
      final requestParams = requestUrl['query'] as List<dynamic>?;
      final requestParamMap = <String, String>{};
      if (requestParams != null) {
        for (final param in requestParams) {
          final key = param['key'] as String;
          final value = param['value'] as String;
          requestParamMap[key] = value;
        }
      }
      final rawData = RawRequest(
        requestName: requestName,
        rawUrl: rawUrl,
        firstPath: firstPath,
        paths: path,
        requestBody: requestBody,
        requestParams: requestParams,
        requestMethod: requestMethod,
        requestParamMap: requestParamMap,
      );
      listRawRequest.add(rawData);
    }
    final baseUrl = getBaseUrl(listRawRequest.map((e) => e.rawUrl).toList());
    final listRetrofitDataGenerate = <RetrofitDataGenerate>[];
    listRawRequest.forEach((element) {
      var retrofitDataGenerate = RetrofitDataGenerate();
      if (element.requestBody != null && element.requestBody!["mode"] == "raw") {
        final featureName = element.requestName;
        final nameClass = "${ReCase(element.requestName).pascalCase}Request";
        final bodyClassRequest = DataClassGenerator.genClassBody(
          nameClass,
          jsonDecode(element.requestBody!["raw"]),
        );
        final classContent = formatContent(content: requestTemplate, featureName: featureName, body: bodyClassRequest);
        retrofitDataGenerate.bodyRequestClass = classContent;

      }
      listRetrofitDataGenerate.add(retrofitDataGenerate);
    });
    print("stop");
  }

  List<String> getBaseUrl(List<String> urls) {
    final resultList = <String>[];
    String baseUrl = urls.reduce((value, element) {
      int i = 0;
      while (i < value.length && i < element.length && value[i] == element[i]) {
        i++;
      }
      return value.substring(0, i);
    });
    resultList.add(baseUrl);
    return resultList;
  }
}

class RawRequest {
  String requestName;
  String rawUrl;
  String firstPath;
  List<String> paths;
  String requestMethod;
  Map<String, dynamic>? requestBody;
  List<dynamic>? requestParams;
  Map<String, String> requestParamMap;

  RawRequest({
    required this.requestName,
    required this.rawUrl,
    required this.firstPath,
    required this.paths,
    required this.requestMethod,
    this.requestBody,
    this.requestParams,
    required this.requestParamMap,
  });
}

class RetrofitDataGenerate {
  String? bodyRequestClass;
  String? function;
  String? methodNotate;

  RetrofitDataGenerate({
    this.bodyRequestClass,
    this.function,
    this.methodNotate,
  });
}

extension on String {
  String capitalize() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
