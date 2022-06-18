import 'dart:io';
import 'package:aac_command_line_support/aa_support/domain_layer/domain_layer_support.dart';

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
  Future<String> getSampleUseCase({required String featureName}) {
    // TODO: implement getSampleUseCase
    throw UnimplementedError();
  }

  @override
  Future<String> getSampleInjector({required String featureName}) {
    // TODO: implement getSampleInjector
    throw UnimplementedError();
  }

  @override
  Future<String> getSampleUseCaseFuture({required String featureName}) {
    // TODO: implement getSampleUseCaseFuture
    throw UnimplementedError();
  }

  @override
  Future<String> getSampleUseCaseStream({required String featureName}) {
    // TODO: implement getSampleUseCaseStream
    throw UnimplementedError();
  }

  @override
  Future<void> autoInjectorDomain({required String featureName}) {
    // TODO: implement autoInjectorDomain
    throw UnimplementedError();
  }
}
