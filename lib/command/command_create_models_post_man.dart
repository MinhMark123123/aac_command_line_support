import 'package:aac_command_line_support/aa_support/models/model_generator.dart';
import 'package:aac_command_line_support/utils/get_args.dart';
import 'package:args/command_runner.dart';

class CreateModelFromPostManCommand extends Command {
  @override
  String get description => "Support create data layer feature with command line";

  @override
  String get name => "generate";

  final postManPathOption = "post_man_path";

  CreateModelFromPostManCommand() {
    argParser..addOption(postManPathOption);
  }

  @override
  Future<void> run() async {
    String postmanJsonPath = getArg<String>(postManPathOption, argResults);
    if (postmanJsonPath.isEmpty) {
      print('Usage: dart model_generator.dart <postman_json_file>');
      return;
    }
    final generator = ModelGenerator(postmanJsonPath);
    generator.generateModels();
  }
}
