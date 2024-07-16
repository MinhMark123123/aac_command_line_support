import 'dart:io';
import '../data_layer_support.dart';
import 'package:resource_portable/resource.dart';

class DataLayerAACSupportRiverPodRetrofit extends DataLayerAACSupport {
  String genDataLayerPathFromFeature({required String featureName}) {
    return "$folderData${Platform.pathSeparator}$featureName";
  }

  List<String> genListDataSourcePathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  }) {
    final dataLayer = genDataLayerPathFromFeature(featureName: featureName);
    return [
      "$dataLayer${Platform.pathSeparator}$folderDataSource${Platform.pathSeparator}${featureName}_retrofit.dart",
      "$dataLayer${Platform.pathSeparator}$folderDataSource${Platform.pathSeparator}${featureName}_remote_data_source.dart",
      "$dataLayer${Platform.pathSeparator}$folderDataSource${Platform.pathSeparator}${featureName}_local_data_source.dart"
    ];
  }

  List<String> genModelsPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  }) {
    final dataLayer = genDataLayerPathFromFeature(featureName: featureName);
    return [
      "$dataLayer${Platform.pathSeparator}$folderModels${Platform.pathSeparator}${folderModelsEntity}${Platform.pathSeparator}${featureName}_entity.dart",
      "$dataLayer${Platform.pathSeparator}$folderModels${Platform.pathSeparator}${folderModelsResponse}${Platform.pathSeparator}${featureName}_response_model.dart",
    ];
  }

  List<String> genRepositoryPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  }) {
    final dataLayer = genDataLayerPathFromFeature(featureName: featureName);
    return [
      "$dataLayer${Platform.pathSeparator}$repositories${Platform.pathSeparator}${featureName}_repository.dart",
    ];
  }

  List<String> genInjectorPathFromFeature({
    required String featureName,
    bool isSupportRetrofit = true,
  }) {
    final dataLayer = genDataLayerPathFromFeature(featureName: featureName);
    return [
      "$dataLayer${Platform.pathSeparator}${featureName}_data_injector.dart",
    ];
  }

  @override
  Future<String> getSampleDataClassEntity({required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_entity.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleDataClassLocalSource(
      {required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_local_data_source.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleDataClassRemoteSource(
      {required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_remote_data_source.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleDataClassRepository(
      {required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_repository.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleInjector({required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_injector.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  Future<String> getSampleDataClassResponse(
      {required String featureName}) async {
    /*final pathEntityTemplate =
        ".${Platform.pathSeparator}template${Platform.pathSeparator}template_entity.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);*/
    return "";
  }

  @override
  Future<String> getSampleDataClassRetrofit(
      {required String featureName}) async {
    final pathEntityTemplate = "$pathTemplate/template_retrofit.dart";
    var content = await getStringFromPath(path: pathEntityTemplate);
    return formatContent(content: content, featureName: featureName);
  }

  @override
  // TODO: implement pathTemplate
  String get pathTemplate =>
      "package:aac_command_line_support/aa_support/data_layer/riverpod_retrofit/template";
}
