import 'dart:convert';
import 'package:aac_command_line_support/utils/string_extension.dart';
import 'package:resource_portable/resource.dart';

final String folderData = "data";
final String folderDataSource = "data_sources";
final String folderModels = "models";
final String folderModelsEntity = "entity";
final String folderModelsResponse = "response";
final String repositories = "repository";

abstract class DataLayerAACSupport {
  String genDataLayerPathFromFeature({required String featureName});

  List<String> genListDataSourcePathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  });

  List<String> genModelsPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  });

  List<String> genRepositoryPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  });

  List<String> genInjectorPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  });

  Future<String> getSampleDataClassRepository({
    required String featureName,
  });

  Future<String> getSampleDataClassRemoteSource({
    required String featureName,
  });

  Future<String> getSampleDataClassLocalSource({
    required String featureName,
  });

  Future<String> getSampleDataClassEntity({
    required String featureName,
  });

  Future<String> getSampleDataClassResponse({
    required String featureName,
  });

  Future<String> getSampleInjector({
    required String featureName,
  });

  Future<String> getStringFromPath({required String path}) async {
    /*final String templateContent = await File(path).readAsStringSync();
    return templateContent;*/
    var resource = new Resource(path);
    var string = await resource.readAsString(encoding: utf8);
    return string;
  }

  String formatContent({required String content, required String featureName}) {
    content = content.replaceAll("/*", "");
    content = content.replaceAll("*/", "");
    content = content.replaceAll("#YOURFEATURE#", featureName);
    content = content.replaceAll(
      "#YOURFEATURENAME#",
      featureName.toFeatureName(),
    );
    content = content.replaceAll(
      "#YOURFEATURECAMEL#",
      featureName.toFeatureCamel(),
    );
    return content.trim();
  }

  Future<String> getSampleDataClassRetrofit({required String featureName});

  String get pathTemplate;
}
