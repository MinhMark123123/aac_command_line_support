
import 'package:recase/recase.dart';

class DataClassGenerator {
  static String genClassBody(String className, dynamic jsonData) {
    final buffer = StringBuffer();
    // Write fields
    if (jsonData is Map<String, dynamic>) {
      for (final entry in jsonData.entries) {
        final key = entry.key;
        final value = entry.value;
        final type = _getDartType(value);

        buffer.writeln('  final $type? ${ReCase(key).camelCase};');
      }
    }

    // Write constructor
    buffer.writeln('');
    buffer.writeln('  $className({');
    if (jsonData is Map<String, dynamic>) {
      for (final entry in jsonData.entries) {
        final key = entry.key;
        final value = entry.value;

        buffer.writeln('    required this.${ReCase(key).camelCase},');
      }
    }
    buffer.writeln('  });');
    return buffer.toString();
  }

  static String createClassString(String className, dynamic jsonData) {
    final buffer = StringBuffer();
    // Write class header
    buffer.writeln('class $className {');
    buffer.writeln(genClassBody(className, jsonData));

    // Write toJson method
    buffer.writeln('');
    buffer.writeln('  Map<String, dynamic> toJson() => {');
    if (jsonData is Map<String, dynamic>) {
      for (final entry in jsonData.entries) {
        final key = entry.key;

        buffer.writeln('    \'$key\': $key,');
      }
    }
    buffer.writeln('  };');

    // Write class footer
    buffer.writeln('}');

    return buffer.toString();
  }

  static String _getDartType(dynamic value) {
    if (_isInt(value)) {
      return 'int';
    } else if (_isDouble(value)) {
      return 'double';
    } else if (_isBool(value)) {
      return 'bool';
    } else if (_isString(value)) {
      return 'String';
    } else if (value is List) {
      final fist = value.first;
      String dartType = _getDartType(fist);
      return 'List<$dartType>';
    } else if (value is Map) {
      return 'Map<String, dynamic>';
    } else {
      return "dynamic";
      throw Exception('Unsupported data type: ${value.runtimeType}');
    }
  }

  static bool _isInt(dynamic value) {
    return int.tryParse(value.toString()) != null;
  }

  static bool _isDouble(dynamic value) {
    return double.tryParse(value.toString()) != null;
  }

  static bool _isString(dynamic value) {
    return value is String;
  }

  static bool _isBool(dynamic value) {
    return value is bool;
  }
}
