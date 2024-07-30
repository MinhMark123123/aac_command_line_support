import 'dart:io';

import 'package:aac_command_line_support/executor/creator/packages_project_creator.dart';
import 'package:aac_command_line_support/utils/file_utils.dart';
import 'package:archive/archive_io.dart';

import 'melos_project_creator.dart';

const String _urlTemplate =
    "https://github.com/MinhMark123123/template/archive/refs/heads/main.zip";

abstract class ProjectCreator {
  final String projectName;
  final String templatePath;
  late String pathTemplate;

  String get separator => Platform.pathSeparator;

  ProjectCreator({required this.projectName, required this.templatePath});

  factory ProjectCreator.melosProject({
    required String projectName,
    required String templatePath,
  }) {
    return MelosProjectCreator(
      projectName: projectName,
      templatePath: templatePath,
    );
  }

  factory ProjectCreator.package({
    required String projectName,
    required String templatePath,
  }) {
    return PackagesProjectCreator(
      projectName: projectName,
      templatePath: templatePath,
    );
  }

  Future<void> create() async {
    final dir = Directory(projectName.toLowerCase());
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print("Create folder project $projectName.");
    } else {
      print(
          "Project folder $projectName was exits breaking out create command.");
      return;
    }
    final fileName = templatePath
        .split(Platform.pathSeparator)
        .last;
    final path = templatePath.replaceAll(templatePath, fileName);
    print("Start download template at $_urlTemplate");
    final pathFile = await downloadFile(
      url: _urlTemplate,
      fileName: fileName,
      path: path,
    );
    final pathExtract = "${path.replaceAll(".zip", "$separator")}";
    print("Extracting file downloaded to $pathExtract");
    await extractFileToDisk(pathFile, pathExtract);
    print("Extracted download file to $pathExtract");
    if (File(pathFile).existsSync()) {
      deleteFile(pathFile);
    }
    final folderChild = Directory(pathExtract).listSync();
    pathTemplate = folderChild.first.path;
    print("compose project $pathTemplate");
    final pathFolder = await composeProject();
    copyDirectorySync(
      source: Directory(pathFolder),
      destination: dir,
      replacePath: pathFolder,
    );
    print("Delete extracted file $pathExtract");
    deleteFile(pathExtract);
  }

  Future<String> composeProject();
}
