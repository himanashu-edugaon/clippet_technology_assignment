import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user_model.dart';

class DbHelper {
  Database? _db;

  Future<void> initDb() async {
    _db ??= await openDatabase(
        join(await getDatabasesPath(), 'user_database.db'),
        onCreate: (db, version) {
          return db.execute('''
             CREATE TABLE users(
             id INTEGER PRIMARY KEY,
             email TEXT UNIQUE,
             name TEXT UNIQUE,
             password TEXT,
             phone TEXT,
             profession TEXT
              )''');
        },
        version: 1,
      );
  }

  Future<int> registerUser(UserModel user) async {
    try {
      await initDb();
      return await _db!.insert('users', user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Error registering user: $e");
      rethrow;
    }
  }

  Future<UserModel?> loginUser(String name, String password) async {
    try {
      await initDb();
      final List<Map<String, dynamic>> maps = await _db!.query(
        'users',
        where: 'name = ? AND password = ?',
        whereArgs: [name, password],
      );
      if (maps.isNotEmpty) {
        return UserModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print("Error logging in user: $e");
      rethrow;
    }
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      await initDb();
      final List<Map<String, dynamic>> maps = await _db!.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      if (maps.isNotEmpty) {
        return UserModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print("Error fetching user by email: $e");
      rethrow;
    }
  }
  Future<UserModel?> getUserByName(String name) async {
    try {
      await initDb();
      final List<Map<String, dynamic>> maps = await _db!.query(
        'users',
        where: 'name = ?',
        whereArgs: [name],
      );
      if (maps.isNotEmpty) {
        return UserModel.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print("Error fetching user by email: $e");
      rethrow;
    }
  }

  Future<void> updateCount(String email, int count) async {
    try {
      await initDb();
      await _db!.update(
        'users',
        {'counter': count},
        where: 'email = ?',
        whereArgs: [email],
      );
    } catch (e) {
      print("Error updating user name: $e");
      rethrow;
    }
  }
}
