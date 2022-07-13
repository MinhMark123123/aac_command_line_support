import 'package:args/command_runner.dart';
import 'package:aac_command_line_support/aa_support/domain_layer/domain_layer_support.dart';
import 'package:aac_command_line_support/aa_support/domain_layer/riverpod/domain_layer_riverpod.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';

import '../utils/get_args.dart';

class CreateDomainFeatureCommand extends Command {
  @override
  String get description => 'Support create domain layer with command line';

  @override
  String get name => "domain_layer";

  CreateDomainFeatureCommand() {
    argParser..addOption('feature');
    addSubcommand(AutoInjectDomainUseCaseCommand());
  }

  @override
  Future<void> run() async {
    String featureName =
        getArg<String>("feature", argResults, isMandatory: true);
    DomainLayerAACSupport aacSupport = DomainLayerAACSupportRiverPod();
    final String useCaseSamplePath = aacSupport.genUseCasePathFromFeature(
      useCaseName: featureName,
      featureName: featureName,
    );
    final contentUseCase =
        await aacSupport.getSampleUseCase(featureName: featureName);
    await createFile(path: useCaseSamplePath, content: contentUseCase);
    aacSupport.autoInjectorDomain(featureName: featureName);
  }
}

class AutoInjectDomainUseCaseCommand extends Command {
  @override
  String get description =>
      'Support auto injector domain layer use-case with command line';

  @override
  String get name => "inject";

  AutoInjectDomainUseCaseCommand() {
    argParser
      ..addOption('feature')
      ..addOption('with');
  }

  @override
  Future<void> run() async {
    String featureName =
        getArg<String>("feature", argResults, isMandatory: true);
    String withFrameWork =
        getArg<String>("with", argResults, isMandatory: true);
    if (withFrameWork.toLowerCase().contains("riverpod")) {
      DomainLayerAACSupport aacSupport = DomainLayerAACSupportRiverPod();
      aacSupport.autoInjectorDomain(featureName: featureName);
    }
  }
}
