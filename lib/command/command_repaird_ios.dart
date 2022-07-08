import 'package:args/command_runner.dart';

class CreateCoreCommand extends Command {
  @override
  String get description => "Support create core package for application";

  @override
  String get name => "core";

  @override
  Future<void> run() async {}
}
