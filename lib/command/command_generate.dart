import 'dart:io';

import 'package:aac_command_line_support/utils/communicate.dart';
import 'package:args/command_runner.dart';

class CommandGenerate extends Command {
  @override
  String get description => "Support create data layer feature with command line";

  @override
  String get name => "gen";

  CreateModelFromPostManCommand() {}

  @override
  Future<void> run() async {
    final userConfirm = echoAndRead(messageOut: "You want to generate model with mac CLI: (y/n)");
    if (userConfirm == "y" || userConfirm == "yes") {
      print("\n");
      final listOption = echoListOption(
        message: "Please choice which tool you exported to input generator",
        options: ["swagger", "postman"],
        isMultipleChoice: false,
      );
      print("verified option list : $listOption");
    }
  }
}
