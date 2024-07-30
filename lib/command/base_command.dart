import 'package:args/command_runner.dart';

abstract class BaseCommand extends Command {
  String get descriptionEnding;

  Future<void> onCommandExecuted();

  Future<void> run() async {
    print("Run command $runtimeType");
    await onCommandExecuted();
    print(descriptionEnding);
    print("Thanks for using to get more information please type : m --help");
  }
}
