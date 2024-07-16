import 'dart:convert';
import 'dart:io';

class ModelGenerator {
  final String postmanJsonPath;

  ModelGenerator(this.postmanJsonPath);

  void generateModels() {
    final postmanJson = jsonDecode(File(postmanJsonPath).readAsStringSync());
    final listItem = postmanJson['item'];
    listItem.forEach((item){
      final itemDetails = item['item'];
      itemDetails.forEach((itemDetail) {
        final request = itemDetail['request'];
        final headers = request['header'];
        final response = itemDetail['response'];
        final modelName = itemDetail['name'].split(' ').join('') + 'Model';

        String headerString = '';
        if (headers != null) {
          headers.forEach((header) {
            headerString += '''
  final String ${header['key'].split(' ').join('')};
''';
          });
        }

        String responseString = '';
        if (response != null) {
          final responseJson = jsonDecode(response[0]['body']['raw']);
          responseString = _generateFieldsFromJson(responseJson, 1);
        }

        final classString = '''
class $modelName {
$headerString
$responseString
}
''';

        final file = File('$modelName.dart');
        file.writeAsStringSync(classString);
      });
    });
  }

  String _generateFieldsFromJson(dynamic json, int level) {
    String result = '';
    if (json is Map) {
      json.forEach((key, value) {
        result += '  ' * level + 'final ';
        if (value is Map) {
          final subClassName = key.split(' ').join('') + 'Model';
          result += '$subClassName $key;\n';
          result += _generateFieldsFromJson(value, level + 1);
        } else if (value is List) {
          result += 'List<dynamic> $key;\n';
        } else {
          result += '$value $key;\n';
        }
      });
    } else if (json is List) {
      result += '  ' * level + 'final List<dynamic> items;\n';
    }
    return result;
  }
}
