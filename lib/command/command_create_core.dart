import 'dart:io';

import 'package:aac_command_line_support/aa_support/core/core_support.dart';
import 'package:aac_command_line_support/aa_support/core/core_support_implement.dart';
import 'package:aac_command_line_support/command/command_create.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:args/command_runner.dart';

class CreateCoreCommand extends Command {
  @override
  String get description => "Support create core package for application";

  @override
  String get name => "core";

  CreateCoreCommand() {
    addSubcommand(
      CreateCommand(
        [
          CoreDomainLayerCommand(),
          CorePresentationLayerCommand(),
        ],
      ),
    );
  }

  @override
  Future<void> run() async {
    // CoreDomainLayerCommand().run();
    // CorePresentationLayerCommand().run();
  }
}

class CorePresentationLayerCommand extends Command {
  @override
  String get description => "Create core presentation layer command";

  @override
  String get name => "presentation_layer";

  @override
  Future<void> run() async {
    CoreAACSupport coreAACSupport = CoreSupportImplement();
    final presentationPath = coreAACSupport.genListPresentationPath();
    final mapFileAndContent = Map<String, String?>();
    final contentSample = await coreAACSupport.getSamplePresentationCore();
    mapFileAndContent[presentationPath] = contentSample;
    mapFileAndContent.forEach((key, value) {
      createFile(path: key, content: value);
    });
  }
}

class CoreDomainLayerCommand extends Command {
  @override
  String get description => "Create core domain layer command";

  @override
  String get name => "domain_layer";

  @override
  Future<void> run() async {
    CoreAACSupport coreAACSupport = CoreSupportImplement();
    final domainPath = coreAACSupport.genListDomainPath();
    final mapFileAndContent = Map<String, String?>();
    final contentSample = await coreAACSupport.getSampleDomainCore();
    mapFileAndContent[domainPath] = contentSample;
    mapFileAndContent.forEach((key, value) {
      createFile(path: key, content: value);
    });
  }
}
