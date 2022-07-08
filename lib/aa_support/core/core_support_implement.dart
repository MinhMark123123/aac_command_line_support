import 'dart:io';
import 'package:aac_command_line_support/aa_support/core/core_support.dart';

class CoreSupportImplement extends CoreAACSupport {
  @override
  String genCorePath() => "$folderCore";

  @override
  String genListDataPath() {
    final corePath = genCorePath();
    return "${corePath}${Platform.pathSeparator}$folderData";
  }

  @override
  String genListDomainPath() {
    final corePath = genCorePath();
    final corePathDomain = "${corePath}${Platform.pathSeparator}$folderDomain";
    return "$corePathDomain${Platform.pathSeparator}base_use_case.dart";
  }

  @override
  String genListPresentationPath() {
    final corePath = genCorePath();
    return "${corePath}${Platform.pathSeparator}$folderPresentation";
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
  String get pathTemplate =>
      "package:aac_command_line_support/aa_support/core/template";
}
