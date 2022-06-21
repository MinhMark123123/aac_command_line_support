import 'package:aac_command_line_support/utils/string_extension.dart';
import 'package:resource_portable/resource.dart';
import 'dart:convert';


class ClassTemplateBase {
  String formatContent({required String content, required String featureName}) {
    content = content.replaceAll("/*", "");
    content = content.replaceAll("*/", "");
    content = content.replaceAll("#YOURFEATURE#", featureName);
    content = content.replaceAll(
      "#YOURFEATURENAME#",
      featureName.toFeatureName(),
    );
    content = content.replaceAll(
      "#YOURFEATURECAMEL#",
      featureName.toFeatureCamel(),
    );
    return content.trim();
  }

  Future<String> getStringFromPath({required String path}) async {
    /*final String templateContent = await File(path).readAsStringSync();
    return templateContent;*/
    var resource = new Resource(path);
    var string = await resource.readAsString(encoding: utf8);
    return string;
  }

}
