import 'dart:io';
import 'output_utils.dart' as output;
import 'package:path/path.dart';

Future<void> createFile(
    {required String path, String? content, bool override = false, bool withTestFile = true}) async {
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
  if (override) {
    if (content != null) {
      file.writeAsStringSync(content);
      output.msg('File ${file.path} has been override');
    }
  } else {
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
  }
  if(!withTestFile){
    return;
  }
  if (fileTest.existsSync()) {
    output.error('already exists a $name test file');
    //exit(1);
  } else {
    fileTest.createSync(recursive: true);
    output.msg('File ${fileTest.path} created');
  }
}

bool existsFile(String path, [bool reset = false]) {
  if (path.contains('.')) {
    return File(libPath(path, reset: reset)).existsSync();
  }
  return Directory(libPath(path, reset: reset)).existsSync();
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
