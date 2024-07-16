import 'package:args/command_runner.dart';
import 'package:aac_command_line_support/command/command_create_data_feature.dart';

void main(List<String> arguments) async {
  arguments.forEach((element) {print(element);});
  var runner = CommandRunner('maac', 'CLI arc supporter')
    ..addCommand(CreateDataFeatureCommand())
    ..argParser.addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Noisy logging, including all shell commands executed.',
    );
  ;
  await runner.run(arguments);
}
