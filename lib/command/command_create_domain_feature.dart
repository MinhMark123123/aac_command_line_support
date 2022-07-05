import 'package:args/command_runner.dart';

class CreateDomainFeatureCommand extends Command {
  @override
  // TODO: implement description
  String get description => 'Support create domain layer with command line';

  @override
  // TODO: implement name
  String get name => "domain_layer";

  CreateDomainFeatureCommand() {
    argParser..addOption('feature');
  }

  @override
  Future<void> run() async {

  }
}
