// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:matrimony/login.dart';
// import 'package:matrimony/member_model.dart';
// import 'package:matrimony/my_database.dart';

// class AddOrEdit extends StatefulWidget {
//   final int? index;

//   AddOrEdit({this.index});
//   //print(index);

//   // final int? memIndex;
//   // AddOrEdit({this.memIndex});

//   @override
//   _AddOrEditState createState() => _AddOrEditState();
// }

// class _AddOrEditState extends State<AddOrEdit> {
//   Member? existMember;

//   final _formKey = GlobalKey<FormState>();
//   final _db = DB();
//   final TextEditingController _dateController = TextEditingController();
//   String name = '';
//   String motherName = '';
//   String birthdate = '';
//   String hobbies = '';
//   String gender = 'Male';
//   String religion = '';
//   double height = 0.0;
//   String occupation = '';
//   String address = '';
//   String maritalStatus = '';
//   String contactNo = '';
//   String email = '';
//   String age = '';

//   void initState() {
//     super.initState();
//     if (widget.index != null) {
//       //existMember = member[widget.index!];
//       loadMember(widget.index!);
//     }
//   }

//  Future<void> loadMember(int id) async {
//     List<Member> members = await _db.getById(id);
//     if (members.isNotEmpty) {
//       setState(() {
//         existMember = members.first;
//         // Set the initial values for the form fields
//         name = existMember!.name;
//         motherName = existMember!.motherName ?? '';
//         birthdate = existMember!.birthdate;
//         hobbies = existMember!.hobbies;
//         gender = existMember!.gender;
//         religion = existMember!.religion;

//         height = existMember!.height;
//         occupation = existMember!.occupation;
//         address = existMember!.address;
//         maritalStatus = existMember!.maritalStatus;
//         contactNo = existMember!.contactNo ?? '';
//         email = existMember!.email ?? '';
//         age = existMember!.age;
//         _dateController.text = birthdate; // Set the date controller text
//       });
//     }
//   }

//   void _selectDate(BuildContext context) async {
//     FocusScope.of(context).unfocus();
//     DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: birthdate.isNotEmpty ? DateFormat('dd-MM-yyyy').parse(birthdate) : DateTime.now(),
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now());
//     if (picked != null && mounted) {
//       setState(() {
//         birthdate = DateFormat('dd-MM-yyyy').format(picked);
//         age = calculateAge(birthdate).toString();
//         _dateController.text = birthdate;
//       });
//     }
//   }
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       Member updatedMember = Member(
//         id: existMember?.id, // Include the ID for updates
//         name: name,
//         motherName: motherName,
//         birthdate: birthdate,
//         hobbies: hobbies,
//         gender: gender,
//         religion: religion,
//         height: height,
//         occupation: occupation,
//         address: address,
//         maritalStatus: maritalStatus,
//         contactNo: contactNo,
//         email: email,
//         age: age,
//       );

//       if (existMember == null) {
//         await _db.addUser(updatedMember);
//       } else {
//         await _db.updateUser(updatedMember);
//       }
//       Navigator.pop(context, true);
//     }
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(existMember == null ? "Add Member" : "Edit Member"),
//         backgroundColor: Colors.pink,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: 5,
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       existMember == null ? "Register" : "Edit Member",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.pink),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     _buildInputWithLable("Full Name", (value) => name = value!),
//                     _buildInputWithLable(
//                         "Mother's Name", (value) => motherName = value!),
//                     _buildGenderSelection(),
//                     _buildInputWithLable("Hobies", (value) => hobbies = value!),
//                     _buildDatePicker(),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: _buildInputWithLable(
//                                 "Religion", (value) => religion = value!)),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                             child: _buildInputWithLable(
//                           "Height (cm)",
//                           (value) {
//                             if (value!.isEmpty)
//                               return 'Please Enter your Height';
//                             final parsedValue = double.tryParse(value);
//                             if (parsedValue == null || parsedValue <= 0)
//                               return 'Invalid height';
//                             height = parsedValue;
//                             return null;
//                           },
//                           keyboardType: TextInputType.number,
//                         ))
//                       ],
//                     ),
//                     _buildInputWithLable(
//                         "Occupatation", (value) => occupation = value!),
//                     _buildInputWithLable(
//                         "Marital Status", (value) => maritalStatus = value!),
//                     _buildInputWithLable(
//                         "contact No", (value) => contactNo = value!,
//                         keyboardType: TextInputType.phone),
//                     _buildInputWithLable("Email", (value) => email = value!,
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter your Email';
//                       }
//                       if (!EmailValidator.validate(value)) return null;
//                     }),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.pink,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 50, vertical: 15),
//                         ),
//                         onPressed: _submitForm,
//                         child: Text(
//                           existMember == null ? "Add User" : "Save Changes",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ))
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }

//    String _getFieldValue(String label) {
//     if (existMember == null) return "";

//     switch (label) {
//       case "Full Name": return name;
//       case "Mother's Name": return motherName;
//       case "Hobies": return hobbies;
//       case "Religion": return religion;
//       case "Height (cm)": return height.toString();
//       case "Occupatation": return occupation;
//       case "Marital Status": return maritalStatus;
//       case "contact No": return contactNo;
//       case "Email": return email;
//       default: return "";
//     }
//   }

//  Widget _buildInputWithLable(String label, Function(String?) onSave,
//       {TextInputType? keyboardType, String? Function(String?)? validator}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style:
//                 TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
//           ),
//           TextFormField(
//             keyboardType: keyboardType,
//             initialValue:  _getFieldValue(label),
//             decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.pink))),
//             validator: validator ??
//                 (value) => value!.isEmpty ? 'Please Enter $label' : null,
//             onSaved: onSave,
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildGenderSelection() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Gender",
//             style:
//                 TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
//           ),
//           Row(
//             children: [
//               Flexible(
//                   child: RadioListTile<String>(
//                       value: "Male",
//                       groupValue: gender,
//                       onChanged: (value) {
//                         setState(() {
//                           gender = value!;
//                         });
//                       })),
//               Text("male"),
//               Flexible(
//                   child: RadioListTile<String>(
//                       value: "Female",
//                       groupValue: gender,
//                       onChanged: (value) {
//                         setState(() {
//                           gender = value!;
//                         });
//                       })),
//               Text("Female"),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildDatePicker() {
//     return Row(
//       children: [
//         Text(birthdate.isEmpty ?   "Select Birthdate" : birthdate,
//             style: TextStyle(fontSize: 16)),
//         IconButton(
//             onPressed: () => _selectDate(context),
//             icon: Icon(Icons.calendar_today))
//       ],
//     );
//   }}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/home.dart';
import 'package:matrimony/login.dart';
import 'package:matrimony/member_model.dart';
import 'package:matrimony/my_database.dart';

class AddOrEdit extends StatefulWidget {
  final int? index;

  AddOrEdit({this.index});

  @override
  _AddOrEditState createState() => _AddOrEditState();
}

class _AddOrEditState extends State<AddOrEdit> {
  Member? existMember;

  final _formKey = GlobalKey<FormState>();
  final _db = DB();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String name = '';
  String motherName = '';
  String birthdate = '';
  String hobbies = '';
  String gender = 'Male';
  String religion = '';
  double height = 0.0;
  String occupation = '';
  String address = '';
  String maritalStatus = '';
  String contactNo = '';
  String email = '';
  String age = '';

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      loadMember(widget.index!);
    }
  }

  Future<void> loadMember(int id) async {
    List<Member> members = await _db.getById(id);
    if (members.isNotEmpty) {
      setState(() {
        existMember = members.first;
        _nameController.text = existMember!.name;
        _motherNameController.text = existMember!.motherName ?? '';
        _hobbiesController.text = existMember!.hobbies;
        _religionController.text = existMember!.religion;
        _occupationController.text = existMember!.occupation;
        _maritalStatusController.text = existMember!.maritalStatus;
        _contactNoController.text = existMember!.contactNo ?? '';
        _emailController.text = existMember!.email ?? '';
        birthdate = existMember!.birthdate;
        gender = existMember!.gender;
        height = existMember!.height;
        age = existMember!.age;
        _dateController.text = birthdate;
      });
    }
  }

  void _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthdate.isNotEmpty ? DateFormat('dd-MM-yyyy').parse(birthdate) : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        birthdate = DateFormat('dd-MM-yyyy').format(picked);
        age = calculateAge(birthdate).toString();
        _dateController.text = birthdate;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Member updatedMember = Member(
        id: existMember?.id,
        name: name,
        motherName: motherName,
        birthdate: birthdate,
        hobbies: hobbies,
        gender: gender,
        religion: religion,
        height: height,
        occupation: occupation,
        address: address,
        maritalStatus: maritalStatus,
        contactNo: contactNo,
        email: email,
        age: age,
      );

      if (existMember == null) {
        await _db.addUser(updatedMember);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserList(), // Replace with the new page you want to navigate to
          ),
        );

      } else {
        await _db.updateUser(updatedMember);
         Future.delayed(Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pop(context, true);
          }
        });
      }
    
    }
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  Text("Male"),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Text(birthdate.isEmpty ? "Select Birthdate" : birthdate, style: TextStyle(fontSize: 16)),
        IconButton(
          onPressed: () => _selectDate(context),
          icon: Icon(Icons.calendar_today),
        ),
      ],
    );
  }

  Widget _buildInputWithLable(String label, Function(String?) onSave,
      {TextInputType? keyboardType, String? Function(String?)? validator, TextEditingController? controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
            validator: validator ?? (value) => value!.isEmpty ? 'Please Enter $label' : null,
            onSaved: onSave,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(existMember == null ? "Add Member" : "Edit Member"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    existMember == null ? "Register" : "Edit Member",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
                  ),
                  SizedBox(height: 20),
                  _buildInputWithLable("Full Name", (value) => name = value!, controller: _nameController),
                  _buildInputWithLable("Mother's Name", (value) => motherName = value!, controller: _motherNameController),
                  _buildGenderSelection(),
                  _buildInputWithLable("Hobbies", (value) => hobbies = value!, controller: _hobbiesController),
                  _buildDatePicker(),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputWithLable("Religion", (value) => religion = value!, controller: _religionController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildInputWithLable("Height (cm)", (value) {
                          if (value!.isEmpty) return 'Please Enter your Height';
                          final parsedValue = double.tryParse(value);
                          if (parsedValue == null || parsedValue <= 0) return 'Invalid height';
                          height = parsedValue;
                          return null;
                        }, keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  _buildInputWithLable("Occupation", (value) => occupation = value!, controller: _occupationController),
                  _buildInputWithLable("Marital Status", (value) => maritalStatus = value!, controller: _maritalStatusController),
                  _buildInputWithLable("Contact No", (value) => contactNo = value!, controller: _contactNoController, keyboardType: TextInputType.phone),
                  _buildInputWithLable("Email", (value) => email = value!, controller: _emailController, keyboardType: TextInputType.emailAddress),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: _submitForm,
                    child: Text(
                      existMember == null ? "Add User" : "Save Changes",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
