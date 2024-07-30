import 'dart:convert';
import 'dart:io';
import 'package:aac_command_line_support/utils/string_extension.dart';
import 'package:recase/recase.dart';
import 'package:resource_portable/resource.dart';

import 'output_utils.dart' as output;
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as io;

Future<void> createFile({required String path, String? content}) async {
  path = path.replaceAll('\\', '/').replaceAll('\"', '');
  if (path.startsWith('/')) path = path.substring(1);
  if (path.endsWith('/')) path = path.substring(0, path.length - 1);
  path = libPath(path);

  Directory dir = Directory(path);

  final name = basename(path);
  final file = File(
      '${dir.path.replaceAll(name, "")}/${name.replaceAll(".dart", "")}.dart');
  final fileTest = File(
      '${dir.path.replaceAll(name, "").replaceFirst("lib/", "test/")}/${name.replaceAll(".dart", "")}_test.dart');

  if (file.existsSync()) {
    output.error('already exists a $path');
    //exit(1);
  } else {
    file.createSync(recursive: true);
    if (content != null) {
      file.writeAsStringSync(content);
    }
    output.msg('File ${file.path} created');
  }

  if (fileTest.existsSync()) {
    output.error('already exists a $name test file');
    //exit(1);
  } else {
    fileTest.createSync(recursive: true);
    output.msg('File ${fileTest.path} created');
  }
}

String writeTextFile({required String path, required String content}) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync();
  }
  print("writing file : $path");
  file.writeAsStringSync(content);
  return file.path;
}

void copyDirectorySync({
  required Directory source,
  required Directory destination,
  String? replacePath,
}) {
  /// create destination folder if not exist
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }

  for (var entity in source.listSync(recursive: true)) {
    final relativePath = entity.path.replaceFirst(source.path, '');
    final newPath = destination.path + relativePath;
    if (entity is Directory) {
      // Create subdirectory in the destination
      final newDirectory = Directory(newPath);
      if (!newDirectory.existsSync()) {
        newDirectory.createSync(recursive: true);
      }
    } else if (entity is File) {
      // Copy the file to the destination directory
      final newFile = File(newPath);
      newFile.createSync(recursive: true);
      entity.copySync(newFile.path);
    }
  }
}

bool existsFileLibPath(String path, [bool reset = false]) {
  if (path.contains('.')) {
    return File(libPath(path, reset: reset)).existsSync();
  }
  return Directory(libPath(path, reset: reset)).existsSync();
}

bool existsFilePath(String path, [bool reset = false]) {
  if (path.contains('.')) {
    return File(path).existsSync();
  }
  return Directory(path).existsSync();
}

void deleteFile(String path) {
  final file = File(path);
  if (file.existsSync()) {
    print("deleting file $path");
    file.deleteSync();
    return;
  }
  final dir = Directory(path);
  if (dir.existsSync()) {
    print("deleting Directory $path");
    dir.deleteSync(recursive: true);
  }
}

String mainDirectory = '';

String? _libPath;

String libPath(String path, {bool reset = false}) {
  if (reset || _libPath == null) {
    if (Directory("${mainDirectory}lib").existsSync()) {
      _libPath = "${mainDirectory}lib";
    } else if (Directory("${mainDirectory}lib").existsSync()) {
      _libPath = "${mainDirectory}lib";
    } else {
      _libPath = "${mainDirectory}lib";
    }
  }
  return _libPath! + "/$path";
}

Future<String> getStringFromPath({required String path}) async {
  /*final String templateContent = await File(path).readAsStringSync();
    return templateContent;*/
  var resource = new Resource(path);
  var string = await resource.readAsString(encoding: utf8);
  return string;
}

String formatContent({
  required String content,
  required String featureName,
  String? body,
}) {
  content = content.replaceAll("/*", "");
  content = content.replaceAll("*/", "");
  content = content.replaceAll(
      "#YOURFEATURE#", ReCase(featureName).snakeCase.toLowerCase());
  content = content.replaceAll(
    "#YOURFEATURENAME#",
    featureName.toFeatureName(),
  );
  content = content.replaceAll(
    "#YOURFEATURECAMEL#",
    featureName.toFeatureCamel(),
  );
  content = content.replaceAll("#body#", body ?? "");
  return content.trim();
}

Future<String> downloadFile({
  required String url,
  required String fileName,
  required String path,
}) async {
  final response = await http.get(Uri.parse(url));
  final filePath = "$path";
  final isExist = existsFilePath(filePath);
  print("check file path download $filePath");
  if (isExist) {
    deleteFile(filePath);
  }
  await File(filePath).writeAsBytes(response.bodyBytes);
  print("downloaded $fileName to $filePath ");
  return filePath;
}
/*
import 'package:path/path.dart';
import 'output_utils.dart' as output;
import 'dart:io';

Future<void> createFile({
    required String path,
    }) async {
  output.msg('Creating $path...');
  final package = await getNamePackage();

  path = path.replaceAll('\\', '/').replaceAll('\"', '');
  if (path.startsWith('/')) path = path.substring(1);
  if (path.endsWith('/')) path = path.substring(0, path.length - 1);

  path = libPath(path);

  Directory dir = Directory(path);

  final name = basename(path);
  final file =
  File('${dir.path}/${name}_${type.replaceAll("_complete", "")}.dart');
  final fileTest = File(
      '${dir.path.replaceFirst("lib/", "test/")}/${name}_${type.replaceAll("_complete", "")}_test.dart');

  if (file.existsSync()) {
    output.error('already exists a $path');
    exit(1);
  }

  if (fileTest.existsSync()) {
    output.error('already exists a $type $name test file');
    exit(1);
  }

  file.createSync(recursive: true);
  LocalSaveLog().add(file.path);
  output.msg('File ${file.path} created');

  if (type == 'module_complete') {
    file.writeAsStringSync(
      generator(
        ObjectGenerate(
          packageName: package,
          name: formatName(name),
          pathModule: '$path/$name',
          additionalInfo: additionalInfo,
        ),
      ),
    );
  } else if (type == 'module') {
    file.writeAsStringSync(
      generator(
        ObjectGenerate(
          name: formatName(name),
          packageName: package,
          pathModule: path,
          additionalInfo: additionalInfo,
        ),
      ),
    );
  } else if (type == 'mapper') {
    file.writeAsStringSync(
      generator(
        ObjectGenerate(
          name: formatName(name),
          type: type,
          packageName: package,
          additionalInfo: additionalInfo,
        ),
      ),
    );
    final indexPath = libPath('data/mappers/index.dart');
    final content = "export '$name/${name}_mapper.dart';";
    if (existsFile('data/mappers/index.dart')) {
      final indexFile = File(indexPath);
      indexFile.writeAsStringSync(
          File(indexPath).readAsStringSync() + content + '\n');
    } else {
      createStaticFile(indexPath, content);
    }
  } else {
    file.writeAsStringSync(
      generator(
        ObjectGenerate(
          name: formatName(name),
          type: type,
          packageName: package,
          additionalInfo: additionalInfo,
        ),
      ),
    );
  }

  File module;
  String nameModule;

  if (type == 'controller' ||
      type == 'repository' ||
      type == 'store' ||
      type == 'service') {
    try {
      module = await addModule(formatName('${name}_$type'), file.path);
    } catch (e) {
      print('not Module');
    }
    nameModule = module == null ? null : basename(module.path);
  }

  if (generatorTest != null) {
    fileTest.createSync(recursive: true);
    LocalSaveLog().add(fileTest.path);

    output.msg('File test ${fileTest.path} created');
    if (type == 'widget' || type == 'page') {
      fileTest.writeAsStringSync(
        generatorTest(
          ObjectGenerate(
            name: formatName(name),
            packageName: package,
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            additionalInfo: additionalInfo,
          ),
        ),
      );
    } else {
      fileTest.writeAsStringSync(
        generatorTest(
          ObjectGenerate(
            name: formatName(name),
            packageName: package,
            import: file.path,
            module: nameModule != null ? formatName(nameModule) : null,
            pathModule: module?.path,
            type: type,
            additionalInfo: additionalInfo,
          ),
        ),
      );
    }
  }

  output.success('$type created');
}*/
