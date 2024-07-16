import 'dart:io';

import 'package:aac_command_line_support/utils/output_utils.dart';
import 'package:dart_console/dart_console.dart';

String? echoAndRead({required String messageOut}) {
  stdout.write("$messageOut: ");
  String? userInput = stdin.readLineSync();
  if (userInput == null || userInput.isEmpty) {
    warn("Please input a value!");
    return echoAndRead(messageOut: messageOut);
  }
  return userInput;
}

List<String> echoListOption({
  required String message,
  required List<String> options,
  bool isMultipleChoice = true,
}) {
  final console = Console();
  console.writeLine("$message${options.map((e) => "\n").join()}");
  bool isPressedEnter = false;
  int selectedIndex = 0;
  _echoOptions(console: console, options: options, selectedIndex: selectedIndex);
  console.rawMode = true;
  while (!isPressedEnter) {
    final key = console.readKey();
    if (key.isControl) {
      if (key.controlChar == ControlCharacter.enter) {
        isPressedEnter = true;
      } else if (key.controlChar == ControlCharacter.arrowUp) {
        selectedIndex = selectedIndex > 0 ? selectedIndex - 1 : options.length - 1;
      } else if (key.controlChar == ControlCharacter.arrowDown) {
        selectedIndex = selectedIndex < options.length - 1 ? selectedIndex + 1 : 0;
      }
      _echoOptions(console: console, options: options, selectedIndex: selectedIndex);
    } else if (key.char == " ") {
      if (selectedIndex >= 0 && selectedIndex < options.length) {
        final prefix = options[selectedIndex].startsWith('* ') ? '' : '* ';
        if (!isMultipleChoice) {
          options = options.map((option) => option.replaceAll('* ', '')).toList();
        }
        options[selectedIndex] = '$prefix${options[selectedIndex].replaceAll('* ', '')}';
      }
      _echoOptions(console: console, options: options, selectedIndex: selectedIndex);
    }
  }
  console.rawMode = false;
  final selectedOptions = options.where((option) => option.startsWith('* ')).map((option) => option.replaceAll('* ', '')).toList();
  console.writeLine('Selected options: ${selectedOptions.join(', ')}');
  return selectedOptions;
}

void _echoOptions({
  required Console console,
  required List<String> options,
  required int selectedIndex,
}) {
  _clearOptionsListEcho(console, options, selectedIndex);
  for (int i = 0; i < options.length; i++) {
    var text = options[i];
    if (text.startsWith("* ")) {
      text = text.replaceAll('* ', '');
      text = "${green('* $text')}";
    } else {
      text = "  $text";
    }
    if (i == selectedIndex) {
      console.write(' > $text\n');
    } else {
      console.write('   $text\n');
    }
  }
}

void _clearOptionsListEcho(Console console, List<String> options, int selectedIndex) {
  for (int i = 0; i < options.length; i++) {
    console.cursorUp();
    console.eraseLine();
  }
}
