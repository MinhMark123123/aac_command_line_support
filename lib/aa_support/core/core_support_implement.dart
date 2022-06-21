import 'dart:io';
import 'package:aac_command_line_support/aa_support/core/core_support.dart';

class CoreSupportImplement extends CoreAACSupport {
  @override
  String genCorePath() => "$folderCore";

  @override
  List<String> genListDataPath() {
    final corePath = genCorePath();
    return ["${corePath}${Platform.pathSeparator}$folderData"];
  }

  @override
  List<String> genListDomainPath() {
    final corePath = genCorePath();
    return ["${corePath}${Platform.pathSeparator}$folderDomain"];
  }

  @override
  List<String> genListPresentationPath() {
    final corePath = genCorePath();
    return ["${corePath}${Platform.pathSeparator}$folderPresentation"];
  }

  @override
  Future<String> getSampleDomainCore() async {
    final templatePath =
        "$pathTemplate${Platform.pathSeparator}domain_layer${Platform.pathSeparator}temp_plate_use_case.dart";
    String content = await getStringFromPath(path: templatePath);
    return formatContent(
      content: content,
      featureName: "SOMETHINGNOTTOREPLACE",
    );
  }

  @override
  // TODO: implement pathTemplate
  String get pathTemplate =>
      "package:aac_command_line_support/aa_support/core/template";
}