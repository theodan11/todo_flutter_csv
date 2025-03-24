import 'dart:io';
// import 'package:path/path.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CSVService {
  static final CSVService _instance = CSVService._();

  static List<List<dynamic>> list = [];
  final _fileName = "todo_list.csv";
  factory CSVService() {
    return _instance;
  }

  CSVService._();

  // Creates csv file on first run.
  void createCsv() async {
    Directory? dir = await getApplicationDocumentsDirectory();
    String path = dir.path.toString();

    File file = File("$path/$_fileName");

    if (!(await file.exists())) {
      await file.create(recursive: true);
      await file.writeAsString('ID,Title,Description,CreatedAt,Status\n');
    }

    print("csv created");
  }

  Future<List<List<dynamic>>> loadCSV() async {
    Directory? dir = await getApplicationDocumentsDirectory();
    String path = dir.path.toString();

    File file = File("$path/$_fileName");
    if (!(await file.exists())) {
      await file.create(recursive: true);
      await file.writeAsString('ID,Title,Description,CreatedAt,Status\n');
    }
    String rawData = await file.readAsString();
    print(rawData);
    list = _convertToList(rawData);
    return list;
  }

  List<List<dynamic>> _convertToList(String data) {
    List<List<dynamic>> csv = [];
    csv = const CsvToListConverter().convert(data);
    return csv;
  }

  void createTodo(String title, String description, String status) async {
    loadCSV();
    var id = const Uuid().v4();
    String createdAt = DateTime.now().toIso8601String();
    list.add([id, title, description, createdAt, status]);
    // String listToCsv = const ListToCsvConverter().convert(list);
    await writeToCsv(list);

    print(list);
  }

  Future<void> writeToCsv(List<List<dynamic>> listContent) async {
    Directory? dir = await getApplicationDocumentsDirectory();
    String path = dir.path.toString();
    String listToCsv = const ListToCsvConverter().convert(listContent);
    File file = File("$path/$_fileName");
    await file.writeAsString(listToCsv);
  }

  Future<void> deleteTodos() async {
    Directory? dir = await getApplicationDocumentsDirectory();
    String path = dir.path.toString();

    File file = File("$path/$_fileName");
    if (!(await file.exists())) {
      return;
    }
    await file.delete();
    print('deleted');
  }

  Future<void> deleteSingleTodo(String id) async {
    list.removeWhere((listItem) => listItem[0] == id);
    await writeToCsv(list);
    print("deleted the single todo");
  }
}
