import 'package:sqflite/sqflite.dart';
import 'package:employee_data/app/modules/employee/data/models/employee_model.dart';
import 'package:employee_data/app/modules/employee/domain/entities/employee.dart';
import 'package:path/path.dart';


abstract class EmployeeLocalDataSource {
  Future<List<EmployeeModel>> getEmployees();
  // Future<void> cacheEmployees(List<EmployeeModel> employees);
  Future<void> addEmployee(Employee employee);
  Future<void> updateEmployee(Employee employee);
  Future<void> deleteEmployee(int employeeId);
}

class EmployeeLocalDataSourceImplementation implements EmployeeLocalDataSource  {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'employee_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        fromDate INTEGER NOT NULL,
        tillDate INTEGER
      )
    ''');
  }

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    final db = await database;
    final maps = await db.query('employees');
    if (maps.isEmpty){
      return [];
    }
    return maps.map((map) => EmployeeModel.fromLocalMap(map)).toList();
    // final employeeList=json.decode(maps);
    // if (data != null) {
    //   final List<dynamic> jsonList = json.decode(data);
    //   try {
    //     return jsonList.map((json) => RocketModel.fromLocalJson(json)).toList();
    //   } catch (e) {
    //     print("local exception: $e");
    //   }
    // }
    // throw Exception('Rockets not cached');
  }

  Future<Map<String, dynamic>?> getEmployeeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    final db = await database;
    print("LCAL DB ${employee.name} ${employee.fromDate} ${employee.tillDate}");
    final employeeMap=EmployeeModel.fromEmployee(employee).toMap();
    print("LCAL DB MAP ${employeeMap["name"]} ${employeeMap["fromDate"]} ${employeeMap["tillDate"]}");
    await db.insert('employees', employeeMap);
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final db = await database;
    final employeeMap=EmployeeModel.fromEmployee(employee).toMap();
    final updates = await db.update(
      'employees',
      employeeMap,
      where: 'id = ?',
      whereArgs: [employeeMap['id']],
    );
    if (updates == 1){
    }
  }

  @override
  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
