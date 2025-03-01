import 'package:matrimony/member_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Database? _database;

  //Table
  static const String TABLENAME = "members";

  //Column
  static const String ID = "id";
  static const String NAME = "name";
  static const String MOTHERNAME = "mothername";
  static const String BIRTHDATE = "birthdate";
  static const String HOBBIES = "hobbies";
  static const String GENDER = "gender";
  static const String RELIGION = "religion";
  static const String HEIGHT = "height";
  static const String OCCUPATION = "occupation";
  static const String ADDRESS = "address";
  static const String AGE = "age";
  static const String MARITALsTATUS = "maritalStatus";
  static const String CONTACTNO = "contactNo";
  static const String EMAIL = "email";
  static const String ISFAVORITE = "isFavorite";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), "matrimoyDB.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $TABLENAME(
              $ID INTEGER PRIMARY KEY AUTOINCREMENT,
              $NAME TEXT,
              $MOTHERNAME TEXT,
              $BIRTHDATE TEXT,
              $HOBBIES TEXT,
              $GENDER TEXT,
              $RELIGION TEXT,
              $HEIGHT REAL,
              $OCCUPATION TEXT,p
              $ADDRESS TEXT,
              $MARITALsTATUS TEXT,
              $AGE TEXT,
              $CONTACTNO TEXT,
              $EMAIL TEXT,
              $ISFAVORITE INTEGER DEFAULT 0
            )
         ''');
      },
    );
  }

  // Add User
  Future<int> addUser(Member member) async {
    final db = await database;
    print("Added Data Succesfully");
    return await db.insert(TABLENAME, member.toMap());
  }

  //Get all members
  Future<List<Member>> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(TABLENAME);
    return result.map((m) => Member.fromMap(m)).toList();
  }

  //update member
  Future<int> updateUser(Member member) async {
    final db = await database;
    print(member.id);
    return await db.update(
      TABLENAME,
      member.toMap(),
      where: "$ID = ?",
      whereArgs: [member.id],
    );
  }

  //delete member
  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete(TABLENAME, where: "$ID = ?", whereArgs: [id]);
  }

  //get favourite member
  Future<List<Member>> getFavourite() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      TABLENAME,
      where: "$ISFAVORITE =1",
    );
    return result.map((m) => Member.fromMap(m)).toList();
  }


  //get member by id 
  Future<List<Member>> getById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      TABLENAME,
      where: "$ID = ?",
      whereArgs: [id]
    );
    return result.map((m) => Member.fromMap(m)).toList();
  }

  //update favourite state
  Future<int> updateFavoriteStatus(int id, int isFavorite) async {
    final db = await database;
    return await db.update(
      TABLENAME,
      {ISFAVORITE: isFavorite}, // Update only the favorite status
      where: "$ID = ?",
      whereArgs: [id],
    );
  }

}
