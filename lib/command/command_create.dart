import 'package:args/command_runner.dart';

class CreateCommand extends Command {
  @override
  String get description => "Execute create command";

  @override
  String get name => "create";

  CreateCommand(List<Command> listSubCommand) {
    listSubCommand.forEach((element) {
      addSubcommand(element);
    });
    addSubcommand(CreateAllCommand(listSubCommand));
  }
}

class CreateAllCommand extends Command {
  CreateAllCommand(this.listCommand);

  @override
  String get description => "Execute all sub command";

  @override
  String get name => "all";
  final List<Command> listCommand;

  @override
  Future run() async {
    listCommand.forEach((element) {
      element.run();
    });
  }
}
