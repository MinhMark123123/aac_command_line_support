import 'package:aac_command_line_support/command/command_create.dart';
import 'package:aac_command_line_support/command/command_create_data_feature.dart';
import 'package:aac_command_line_support/command/command_create_models_post_man.dart';
import 'package:aac_command_line_support/command/command_generate.dart';
import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';

final console = Console();

void main(List<String> arguments) async {
  var runner = CommandRunner('m', 'CLI arc supporter')
    ..addCommand(CreateDataFeatureCommand())
    ..addCommand(CreateModelFromPostManCommand())
    ..addCommand(CommandGenerate())
    ..addCommand(CommandCreate())
    ..argParser.addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Noisy logging, including all shell commands executed.',
    );
  ;
  await runner.run(arguments);
  //print('Thank you for using the M CLI Application!');
}
