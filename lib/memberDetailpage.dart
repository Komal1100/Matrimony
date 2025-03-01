import 'package:flutter/material.dart';
import 'package:matrimony/member_model.dart';

class MemberDetailPage extends StatelessWidget {
  final Member member;

  MemberDetailPage({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member.name, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade300, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Colors.pink),
                ),
                SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow("Name", member.name),
                        _buildInfoRow("Age", "${member.age} years"),
                        _buildInfoRow("Occupation", member.occupation),
                        _buildInfoRow("Hobbies", member.hobbies),
                        _buildInfoRow("Gender", member.gender),
                        _buildInfoRow("Religion", member.religion),
                        _buildInfoRow("Height", "${member.height} cm"),
                        _buildInfoRow("Marital Status", member.maritalStatus),
                        _buildInfoRow("Address", member.address),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite, color: Colors.white),
                  label: Text("Send Interest", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label + ":", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.pink)),
          Expanded(
            child: Text(value, textAlign: TextAlign.right, style: TextStyle(fontSize: 16, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
