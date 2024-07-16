import 'package:aac_command_line_support/aa_support/data_layer/post_man/gen_config.dart';

abstract class GeneratorContract<T extends GenConfig> {
  final T genConfig;
  GeneratorContract({required this.genConfig});
}
