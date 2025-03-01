class Member {
  int? id;
  String name;
  String motherName;
  String birthdate;
  String hobbies;
  String gender;
  String religion;
  double height;
  String occupation;
  String address;
  String maritalStatus;
  String age;
  String contactNo;
  String email;
  bool isFavorite = false;

  Member({
    this.id,
    required this.name,
    required this.motherName,
    required this.birthdate,
    required this.hobbies,
    required this.gender,
    required this.religion,
    required this.height,
    required this.occupation,
    required this.address,
    required this.maritalStatus,
    required this.contactNo,
    required this.email,
    required this.age,
    this.isFavorite=false
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'name': name,
      'mothername': motherName,
      'birthdate': birthdate,
      'hobbies': hobbies,
      'gender': gender,
      'religion': religion,
      'height': height,
      'occupation': occupation,
      'address': address,
      'maritalStatus': maritalStatus,
      'age': age,
      'contactNo': contactNo,
      'email': email,
      'isFavorite': isFavorite
          ? 1
          : 0, 
    };

  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'],
      motherName: map['mothername'],
      birthdate: map['birthdate'],
      hobbies: map['hobbies'],
      gender: map['gender'],
      religion: map['religion'],
      height: map['height'],
      occupation: map['occupation'],
      address: map['address'],
      maritalStatus: map['maritalStatus'],
      age: map['age'],
      contactNo: map['contactNo'],
      email: map['email'],
      isFavorite: (map['isFavorite'] as int?) == 1
    );
  }

  @override
  String toString() {
    return 'Member(name: $name, birthdate: $birthdate, hobbies: $hobbies, gender: $gender, '
        'religion: $religion, height: $height, occupation: $occupation, '
        'address: $address, maritalStatus: $maritalStatus, age : $age)';
  }
}

// Global Member List
//List<Member> member = [];
