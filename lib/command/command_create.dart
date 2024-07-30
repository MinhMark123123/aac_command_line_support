import 'dart:io';

import 'package:aac_command_line_support/executor/creator/project_creator.dart';
import 'package:aac_command_line_support/utils/communicate.dart';

import 'base_command.dart';

enum CreateOption {
  MelosAppProject,
  PackagesProject,
  Flutter,
  DartServer,
  none;

  static CreateOption of(String valueName) {
    return CreateOption.values.firstWhere(
      (e) => e.name == valueName,
      orElse: () => CreateOption.none,
    );
  }
}

class CommandCreate extends BaseCommand {
  CommandCreate() {}

  @override
  String get description => "M create support to fast create some things";

  @override
  String get name => "create";

  String get descriptionEnding => "Exit create command";

  @override
  Future<void> onCommandExecuted() async {
    final userChoiceOptions = echoListOption(
      message: "Hi, please choice which option you want to create",
      options: CreateOption.values.map((e) => e.name).toList(),
      isMultipleChoice: false,
    );
    if (userChoiceOptions.isEmpty) {
      return;
    }
    final userChoice = CreateOption.of(userChoiceOptions.first);
    if (userChoice != CreateOption.none) {
      final userConfirmGen = userConfirmSelection(
        message: "Please confirm you want to create $userChoice: (y/n)",
      );
      if (!userConfirmGen) return;
    }
    final projectName = echoAndRead(messageOut: "Please naming your project: ");
    if (projectName == null) return;
    final pathTemplate = "${Platform.pathSeparator}template.zip";
    switch (userChoice) {
      case CreateOption.MelosAppProject:
        await ProjectCreator.melosProject(
          projectName: projectName,
          templatePath: pathTemplate,
        ).create();
        break;
      case CreateOption.PackagesProject:
        await ProjectCreator.package(
          projectName: projectName,
          templatePath: pathTemplate,
        ).create();
        break;
      case CreateOption.Flutter:
        break;
      case CreateOption.DartServer:
        break;
      case CreateOption.none:
        break;
    }
  }
}
