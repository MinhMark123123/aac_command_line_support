import 'dart:io';

import 'package:aac_command_line_support/const.dart';
import 'package:aac_command_line_support/executor/creator/project_creator.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:aac_command_line_support/utils/string_extension.dart';

class MelosProjectCreator extends ProjectCreator {
  MelosProjectCreator({
    required super.projectName,
    required super.templatePath,
  });

  String get melosTempPath => ["apps_structure", "melos"].combinePath;

  @override
  Future<String> composeProject() async {
    final pathMelosStructure = [pathTemplate, melosTempPath].combinePath;
    final pathMelosYaml = [pathMelosStructure,FileNaming.melosYaml].combinePath;
    final pathPubYaml = [pathMelosStructure, FileNaming.pubYaml].combinePath;
    final pathApps = [pathMelosStructure, FileNaming.apps].combinePath;
    final pathPackages = [pathMelosStructure, FileNaming.packages].combinePath;
    //delete keep file
    deleteFile("$pathApps${separator}.keep");
    deleteFile("$pathPackages${separator}.keep");
    //edit content
    final melosYamlContent = await getStringFromPath(path: pathMelosYaml);
    final pubYamlContent = await getStringFromPath(path: pathPubYaml);
    final finalMelosYaml = melosYamlContent.replaceAll(
      NameReplace.projectNameSignal,
      projectName.toLowerCase(),
    );
    final finalPubYaml = pubYamlContent.replaceAll(
      NameReplace.projectNameSignal,
      projectName.toLowerCase(),
    );
    await writeTextFile(path: pathMelosYaml, content: finalMelosYaml);
    await writeTextFile(path: pathPubYaml, content: finalPubYaml);
    return pathMelosStructure;
  }

  @override
  void copyFinalFileDirectorySync({required Directory source, required Directory destination, String? replacePath}) {

  }
}
