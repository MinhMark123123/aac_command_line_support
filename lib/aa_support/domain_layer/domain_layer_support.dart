import 'package:aac_command_line_support/aa_support/class_template_base.dart';

final String folderDomain = "domain";
final String folderUseCase = "use_cases";
final String folderModels = "models";

abstract class DomainLayerAACSupport extends ClassTemplateBase {
  String genDomainLayerPathFromFeature({required String featureName});

  String genUseCasePathFromFeature({
    required String useCaseName,
    required String featureName,
  });

  List<String> genInjectorPathFromFeature({
    required String featureName,
  });

  Future<String> getSampleUseCase({
    required String featureName,
  });

  Future<String> getSampleUseCaseStream({
    required String featureName,
  });

  Future<MapEntry<String,String>> autoInjectorDomain({
    required String featureName,
  });

  String get pathTemplate;
}
