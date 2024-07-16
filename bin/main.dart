import 'package:aac_command_line_support/aa_support/data_layer/post_man/post_man_generator.dart';
import 'package:aac_command_line_support/command/command_create_data_feature.dart';
import 'package:aac_command_line_support/command/command_create_models_post_man.dart';
import 'package:aac_command_line_support/command/command_generate.dart';
import 'package:args/command_runner.dart';
import 'package:dart_console/dart_console.dart';

final console = Console();

void main(List<String> arguments) async {
  await PostManGenerator().executed();
  /*arguments.forEach((element) {
    print(element);
  });
  var runner = CommandRunner('maac', 'CLI arc supporter')
    ..addCommand(CreateDataFeatureCommand())
    ..addCommand(CreateModelFromPostManCommand())
    ..addCommand(CommandGenerate())
    ..argParser.addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Noisy logging, including all shell commands executed.',
    );
  ;
  await runner.run(arguments);*/
  print('Thank you for using the MAAC CLI Application!');
}
