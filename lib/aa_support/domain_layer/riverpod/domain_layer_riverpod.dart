import 'dart:io';
import 'package:aac_command_line_support/utils/output_utils.dart' as output;
import 'package:aac_command_line_support/aa_support/domain_layer/domain_layer_support.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:aac_command_line_support/utils/string_extension.dart';

class DomainLayerAACSupportRiverPod extends DomainLayerAACSupport {
  @override
  String genDomainLayerPathFromFeature({required String featureName}) {
    return "$folderDomain${Platform.pathSeparator}$featureName";
  }

  @override
  List<String> genInjectorPathFromFeature({required String featureName}) {
    final domainPath = genDomainLayerPathFromFeature(featureName: featureName);
    return [
      "$domainPath${Platform.pathSeparator}${featureName}_domain_injector.dart",
    ];
  }

  @override
  String genUseCasePathFromFeature({
    required String useCaseName,
    required String featureName,
  }) {
    final domainPath = genDomainLayerPathFromFeature(featureName: featureName);
    return "$domainPath${Platform.pathSeparator}use_cases${Platform.pathSeparator}${useCaseName}_use_case.dart";
  }

  @override
  Future<String> getSampleUseCase({required String featureName}) async {
    final pathSampleUseCase =
        "$pathTemplate${Platform.pathSeparator}template_sample_future_use_case.dart";
    var content = await getStringFromPath(path: pathSampleUseCase);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleUseCaseStream({required String featureName}) async {
    final pathStreamUseCase =
        "$pathTemplate${Platform.pathSeparator}template_sample_stream_use_case.dart";
    var content = await getStringFromPath(path: pathStreamUseCase);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<MapEntry<String, String>> autoInjectorDomain(
      {required String featureName}) async {
    final pathInjector = genInjectorPathFromFeature(featureName: featureName);
    final pathUseCaseFolder =
        "${genDomainLayerPathFromFeature(featureName: featureName)}${Platform.pathSeparator}use_cases";
    final useCaseDir =
        Directory("lib${Platform.pathSeparator}$pathUseCaseFolder");
    final listUseCaseFiles = await useCaseDir.list().toList();
    var injectorContent = "";
    try {
      injectorContent =
          await getStringFromPath(path: libPath(pathInjector.first));
    } catch (e) {
      print(e);
    }
    listUseCaseFiles.where((element) => element.path.contains(".dart")).forEach(
      (element) async {
        final injectedContent = await _injectElement(
          element: element,
          pathInjector: pathInjector,
        );
        if (injectedContent != null && injectedContent.value.isNotEmpty) {
          if (!injectorContent.contains(injectedContent.value)) {
            injectorContent = "$injectorContent \n ${injectedContent.value}";
          }
        }
      },
    );
    return MapEntry(pathInjector.first, injectorContent);
  }

  @override
  // TODO: implement pathTemplate
  String get pathTemplate =>
      "package:aac_command_line_support/aa_support/domain_layer/riverpod/template";

  Future<MapEntry<String, String>?> _injectElement({
    required FileSystemEntity element,
    required List<String> pathInjector,
  }) async {
    //do something
    var classContent = await getStringFromPath(path: element.path);
    String _patternClassName = r'(?<=class )(.*)(?= extends)';
    final className = firstMatchPattern(
      input: classContent,
      pattern: _patternClassName,
    );
    if (className == null) return null;
    final patternFiled = r'(?<=\{)[\s\S]*?(?=' + className + ')';
    final filedProps = firstMatchPattern(
      input: classContent,
      pattern: patternFiled,
    );
    final pathTemplateInjector =
        "$pathTemplate${Platform.pathSeparator}auto_inject_template.dart";
    String autoInjectTemplate =
        await getStringFromPath(path: pathTemplateInjector);
    final preContent =
        formatContent(content: autoInjectTemplate, featureName: className);
    final String patternInject = "#fieldName#: ref.watch(#providerRef#)";
    final propsSplitter = filedProps?.split(";").map((e) => e.trim());
    output.msg("propsSplitter : ${propsSplitter?.join(",")}");
    final fieldInjected = propsSplitter?.map((element) {
      final splitter = element.split(" ");
      final fieldName = splitter.last.trim();
      final className = splitter[splitter.length - 2].trim();
      final result1 = patternInject.replaceAll("#fieldName#", fieldName);
      final result2 = result1.replaceAll(
        "#providerRef#",
        "provider${className.toFeatureCamel()}",
      );
      //
      return result2;
    }).join(",");
    //
    final content = preContent.replaceAll(preContent, fieldInjected ?? "");
    return MapEntry(element.path, content);
  }

  String? firstMatchPattern({required String input, required String pattern}) {
    final regexp = RegExp(pattern);
    // find the first match though you could also do `allMatches`
    final match = regexp.firstMatch(input);
    return match?.group(0)?.toString();
  }
}
