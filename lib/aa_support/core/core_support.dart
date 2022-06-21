import 'package:aac_command_line_support/aa_support/class_template_base.dart';

final String folderCore = "core";
final String folderData = "data";
final String folderDomain = "domain";
final String folderPresentation = "presentation";

abstract class CoreAACSupport extends ClassTemplateBase {
  String genCorePath();

  List<String> genListDataPath();

  List<String> genListDomainPath();

  List<String> genListPresentationPath();

  Future<String> getSampleDomainCore();

  String get pathTemplate;
}