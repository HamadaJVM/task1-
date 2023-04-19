import 'dart:io';

int count = 1;
void main() {
  //new file
  File studentsFile = File('students.txt');
  if (!studentsFile.existsSync()) {
    studentsFile.createSync();
  } else {
    var lines = studentsFile.readAsLinesSync();
    var line = lines[lines.length - 1];
    var parts = line.split(',');
    count = int.tryParse(parts[0])! + 1;
  }

  while (true) {
    print('\nWhat would you like to do?');
    print('1-Add student ');
    print('2-Read all student ');
    print('3-Search for a student ');
    print('4-Update a student ');
    print('5-Delete a student ');
    print('6-Close');

    final choice = int.tryParse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        Add_Data(studentsFile);
        break;
      case 2:
        Read_Data(studentsFile);
        break;
      case 3:
        Search_on_Data(studentsFile);
        break;
      case 4:
        Update_Data(studentsFile);
        break;
      case 5:
        Delete_Data(studentsFile);
        break;
      case 6:
        break;

      default:
        print('Invalid choice.');

        break;
    }
  }
}

void Add_Data(File studentsFile) {
  print('Enter name:');
  String name = stdin.readLineSync()!;

  print('Enter stage:');
  int stage = int.tryParse(stdin.readLineSync()!)!;

  studentsFile.writeAsStringSync('${count++},$name,$stage\n',
      mode: FileMode.append);
}

void Read_Data(File studentsFile) {
  final lines = studentsFile.readAsLinesSync();
  if (lines.isEmpty) {
    print('No student found.');
  } else {
    print('\nAll student:');

    for (var line in lines) {
      List parts = line.split(',');
      String id = parts[0];
      String name = parts[1];
      int stage = int.tryParse(parts[2])!;
      print('ID: $id, Name: $name, Stage: $stage');
    }
  }
}

void Search_on_Data(File studentsFile) {
  print('\nEnter student ID:');
  String id = stdin.readLineSync()!;
  List lines = studentsFile.readAsLinesSync();
  for (var line in lines) {
    var parts = line.split(',');
    if (parts[0] == id) {
      String name = parts[1];
      int stage = int.tryParse(parts[2])!;
      print('ID: $id, Name: $name, Stage: $stage');
    }
  }
  print('ID $id not found.');
}

void Update_Data(File studentsFile) {
  print('\nEnter student ID:');
  String id = stdin.readLineSync()!;

  List lines = studentsFile.readAsLinesSync();

  for (var i = 0; i < lines.length; i++) {
    List parts = lines[i].split(',');

    if (parts[0] == id) {
      print('Enter new student name (leave blank to keep current value):');
      String name = stdin.readLineSync()!;
      print('Enter new student stage (leave blank to keep current value):');
      String stageStr = stdin.readLineSync()!;
      int stage = stageStr.isEmpty ? parts[2] : int.tryParse(stageStr)!;
      lines[i] = '$id,$name,$stage';
      studentsFile.writeAsStringSync(lines.join('\n'));
    }
  }
  print('ID $id not found.');
}

void Delete_Data(File studentsFile) {
  print('\nEnter student ID:');
  final id = stdin.readLineSync()!;
  final lines = studentsFile.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    final parts = lines[i].split(',');
    if (parts[0] == id) {
      lines.removeAt(i);
      studentsFile.writeAsStringSync(lines.join('\n'));
      print('Student deleted Done.');
      return;
    }
  }
  print('No student  found with ID $id.');
}
