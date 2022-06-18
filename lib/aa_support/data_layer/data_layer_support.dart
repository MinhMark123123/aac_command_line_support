import 'package:aac_command_line_support/aa_support/class_template_base.dart';
import 'package:resource_portable/resource.dart';

final String folderData = "data";
final String folderDataSource = "data_sources";
final String folderModels = "models";
final String folderModelsEntity = "entities";
final String folderModelsResponse = "response";
final String repositories = "repository";

abstract class DataLayerAACSupport extends ClassTemplateBase {
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



  Future<String> getSampleDataClassRetrofit({required String featureName});

  String get pathTemplate;
}
