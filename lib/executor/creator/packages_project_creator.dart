import 'dart:io';

import 'package:aac_command_line_support/const.dart';
import 'package:aac_command_line_support/executor/creator/project_creator.dart';
import 'package:aac_command_line_support/utils/communicate.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:aac_command_line_support/utils/string_extension.dart';
import 'package:path/path.dart';

class PackagesProjectCreator extends ProjectCreator {
  PackagesProjectCreator({
    required super.projectName,
    required super.templatePath,
  });

  String get packageTempPath => "apps_structure${separator}package${separator}";

  @override
  Future<String> composeProject() async {
    final packageDescription = echoAndRead(
      messageOut:
          "Please enter your package description (empty to use default description)",
    );
    //
    final pathPackageStructure = [
      pathTemplate,
      packageTempPath,
      "package_name",
    ].combinePath;
    final pubPath = [pathPackageStructure, FileNaming.pubYaml].combinePath;
    final readmePath = [pathPackageStructure, FileNaming.readme].combinePath;
    final interfaceDartPath = [
      pathPackageStructure,
      FileNaming.lib,
      "package_name.dart",
    ].combinePath;
    final packageSrcDartPath = [
      pathPackageStructure,
      FileNaming.lib,
      FileNaming.src,
      "package_name_source.dart",
    ].combinePath;
    final testDartPath = [
      pathPackageStructure,
      FileNaming.test,
      "package_name_test.dart",
    ].combinePath;
    //edit content
    final pubYamlContent = await getStringFromPath(path: pubPath);
    final readMeContent = await getStringFromPath(path: readmePath);
    final libDart = await getStringFromPath(path: interfaceDartPath);
    final testDart = await getStringFromPath(path: testDartPath);
    var finalPubYamlContent = pubYamlContent.replaceAll(
      NameReplace.projectNameSignal,
      projectName.toLowerCase(),
    );
    if (packageDescription != null && packageDescription.isNotEmpty) {
      // Compile the regex
      RegExp regex = RegExp(NameReplace.patternDes, dotAll: true);

      // Replace the text between the delimiters
      finalPubYamlContent =
          finalPubYamlContent.replaceAllMapped(regex, (match) {
        // You can modify this replacement string as needed
        return packageDescription;
      });
    } else {
      finalPubYamlContent.replaceAll(NameReplace.projectDescriptionSignal, "");
    }
    final finalReadMeContent = readMeContent.replaceAll(
      NameReplace.projectNameSignal,
      projectName,
    );
    //
    final finalLibDart = libDart.replaceAll(
      "package_name",
      projectName.toLowerCase(),
    );
    final testLibDart = testDart.replaceAll(
      "package_name",
      projectName.toLowerCase(),
    );
    //overwrite content
    await writeTextFile(path: pubPath, content: finalPubYamlContent);
    await writeTextFile(path: readmePath, content: finalReadMeContent);
    await writeTextFile(path: interfaceDartPath, content: finalLibDart);
    await writeTextFile(path: testDartPath, content: testLibDart);
    //rename file
    _renameFile(interfaceDartPath);
    _renameFile(packageSrcDartPath);
    _renameFile(testDartPath);
    return pathPackageStructure;
  }

  void _renameFile(String filePath) {
    final file = File(filePath);
    if (file.existsSync()) {
      final currentName = basename(file.path);
      final newName = currentName.replaceAll(
        "package_name",
        projectName.toLowerCase(),
      );
      file.renameSync(
        file.path.replaceAll(currentName, newName),
      );
    }
  }
}
