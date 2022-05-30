import 'package:aac_command_line_support/aa_support/data_layer/data_layer_support.dart';
import 'package:aac_command_line_support/aa_support/data_layer/riverpod_retrofit/data_layer_riverpod_retrofit.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:aac_command_line_support/utils/get_args.dart';
import 'package:args/command_runner.dart';


class CreateDataFeatureCommand extends Command {
  @override
  String get name => "data_layer";

  @override
  final description = 'Support create data layer feature with command line';

  CreateDataFeatureCommand() {
    argParser..addOption('feature');
    //argParser.addFlag('feature', abbr: 'n');
  }

  final String folderData = "data";
  final String folderDataSource = "data_sources";
  final String folderModels = "models";
  final String repositories = "repository";

  @override
  Future<void> run() async{
    String feature = getArg<String>("feature", argResults, isMandatory: true);
    DataLayerAACSupport aacSupport = DataLayerAACSupportRiverPodRetrofit();
    List<String> listPath = [
      ...aacSupport.genListDataSourcePathFromFeature(featureName: feature),
      ...aacSupport.genModelsPathFromFeature(featureName: feature),
      ...aacSupport.genRepositoryPathFromFeature(featureName: feature),
      ...aacSupport.genInjectorPathFromFeature(featureName: feature),
    ];
    final mapFileAndContent = Map<String, String?>();
    final contentEntity =
    await aacSupport.getSampleDataClassEntity(featureName: feature);
    final contentInjector =
    await aacSupport.getSampleInjector(featureName: feature);
    final contentLocalSource =
    await aacSupport.getSampleDataClassLocalSource(featureName: feature);
    final contentRemoteSource =
    await aacSupport.getSampleDataClassRemoteSource(featureName: feature);
    final contentRepository =
    await aacSupport.getSampleDataClassRepository(featureName: feature);
    final contentRetrofit =
    await aacSupport.getSampleDataClassRetrofit(featureName: feature);
    listPath.forEach((element) {
      if (element.contains("_entity")) {
        mapFileAndContent[element] = contentEntity;
      } else if (element.contains("_injector")) {
        mapFileAndContent[element] = contentInjector;
      } else if (element.contains("_local_data_source")) {
        mapFileAndContent[element] = contentLocalSource;
      } else if (element.contains("_remote_data_source")) {
        mapFileAndContent[element] = contentRemoteSource;
      } else if (element.contains("_repository")) {
        mapFileAndContent[element] = contentRepository;
      } else if (element.contains("_retrofit")) {
        mapFileAndContent[element] = contentRetrofit;
      } else {
        mapFileAndContent[element] = null;
      }
    });
    mapFileAndContent.forEach((key, value) {
      createFile(path: key, content: value);
    });
  }
}
