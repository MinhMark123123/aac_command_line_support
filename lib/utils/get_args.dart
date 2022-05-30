import 'package:args/args.dart';
import 'package:args/command_runner.dart';

T getArg<T>(String name, ArgResults? argResults,
    {bool isMandatory = false, usage}) {
  if (argResults == null) {
    throw UsageException('The `$name` have no argResults', usage);
  }
  if (argResults.wasParsed(name)) {
    print(name);
    final T arg = argResults[name] as T;
    if (arg == null && isMandatory) {
      throw UsageException('The `$name` is mandatory', usage);
    }
    return arg;
  }
  throw UsageException('The `$name` have no argResults', usage);
}
