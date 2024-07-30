class NameReplace{
  NameReplace._();
  static const String projectNameSignal = "###PROJECT_NAME###";
  static const String projectDescriptionSignal = "###Default_PROJECT_Description###";
  static const patternDes = r'###Default_PROJECT_Description###(.*?)###Default_PROJECT_Description###';
}
class FileNaming{
  FileNaming._();
  static const String pubYaml = "pubspec.yaml";
  static const String melosYaml = "melos.yaml";
  static const String readme = "README.md";
  static const String packages = "packages";
  static const String apps = "apps";
  static const String lib = "lib";
  static const String src = "src";
  static const String test = "test";
}
