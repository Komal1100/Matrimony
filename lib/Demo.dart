// class DatabaseHelper {
//   static Database? _database;

//   // ✅ Table Name
//   static const String tableName = "members";

//   // ✅ Column Names
//   static const String columnId = "id";
//   static const String columnName = "name";
//   static const String columnMotherName = "motherName";
//   static const String columnBirthdate = "birthdate";
//   static const String columnHobbies = "hobbies";
//   static const String columnGender = "gender";
//   static const String columnReligion = "religion";
//   static const String columnHeight = "height";
//   static const String columnOccupation = "occupation";
//   static const String columnAddress = "address";
//   static const String columnMaritalStatus = "maritalStatus";
//   static const String columnAge = "age";
//   static const String columnContactNo = "contactNo";
//   static const String columnEmail = "email";
//   static const String columnIsFavorite = "isFavorite";

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     String path = join(await getDatabasesPath(), "matrimony.db");
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         db.execute('''
//           CREATE TABLE $tableName (
//             $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//             $columnName TEXT,
//             $columnMotherName TEXT,
//             $columnBirthdate TEXT,
//             $columnHobbies TEXT,
//             $columnGender TEXT,
//             $columnReligion TEXT,
//             $columnHeight REAL,
//             $columnOccupation TEXT,
//             $columnAddress TEXT,
//             $columnMaritalStatus TEXT,
//             $columnAge TEXT,
//             $columnContactNo TEXT,
//             $columnEmail TEXT,
//             $columnIsFavorite INTEGER DEFAULT 0
//           )
//         ''');
//       },
//     );
//   }

//   // ✅ Use Constants in Queries
//   Future<int> insertMember(Member member) async {
//     final db = await database;
//     return await db.insert(tableName, member.toMap());
//   }

//   Future<List<Member>> getMembers() async {
//     final db = await database;
//     final List<Map<String, dynamic>> result = await db.query(tableName);
//     return result.map((m) => Member.fromMap(m)).toList();
//   }

//   Future<int> updateMember(Member member) async {
//     final db = await database;
//     return await db.update(
//       tableName,
//       member.toMap(),
//       where: "$columnId = ?",
//       whereArgs: [member.id],
//     );
//   }

//   Future<int> deleteMember(int id) async {
//     final db = await database;
//     return await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
//   }
// }
