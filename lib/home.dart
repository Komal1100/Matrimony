import 'package:flutter/material.dart';
import 'package:matrimony/addUser.dart';
import 'package:matrimony/favourite.dart';
import 'package:cool_nav/cool_nav.dart';
import 'package:matrimony/memberDetailpage.dart';
import 'package:matrimony/member_model.dart';
import 'package:matrimony/my_database.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _db = DB();
  List<Member> member = [];
  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    List<Member> members = await _db.getUser();
    setState(() {
      member = members;
    });
  }

  Future<void> _deleteMember(int index, int id) async {
    await _db.deleteUser(id);
    setState(() {
      member.removeAt(index);
    });
  }

  Future<void> _toggleFavorite(Member mem) async {
    setState(() {
      mem.isFavorite = !mem.isFavorite;
    });
    await _db.updateFavoriteStatus(mem.id!, mem.isFavorite ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: member.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: Colors.pink[100],
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                member[index].name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("Age: ${member[index].age}")),
                        //Text("Occupation: ${member[index].occupation}"),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text("Gender: ${member[index].gender}")),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MemberDetailPage(member: member[index]),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(
                        member[index].isFavorite == false
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        _toggleFavorite(member[index]);
                      }),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      bool isUpdate = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrEdit(
                            index: member[index].id, // Pass the selected member
                          ),
                        ),
                      );

                      if (isUpdate) {
                        _loadMembers();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteMember(index, member[index].id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.pink,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: 2,
      //   onTap: (index) async {
      //     if (index == 0) {
      //       final newMem = await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) =>
      //                 AddOrEdit()), // Navigate to AddMemberPage
      //       );
      //       if (newMem != null) {
      //         _loadMembers();
      //       }
      //     }
      //     if (index == 1) {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => favourite()));
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Member'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), label: 'Favorites'),
      //     BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Members'),
      //     BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.contact_page), label: 'Contact Us'),
      //   ],
      // ),
    );
  }
}

class HomePage extends StatefulWidget{

  @override
 _HomePageState createState()=> _HomePageState();
 
  
}

class _HomePageState extends State<HomePage>{

  int selectedIndex = 2; 
  _updateIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = [
    AddOrEdit(), 
    favourite(), 
    UserList(), 
    Scaffold(body: Center(child: Text('About Us'))), 
    Scaffold(body: Center(child: Text('Contact Us'))), 
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex], // Show selected screen

       bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: selectedIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Add',
              selectedIcon: Icons.done_all,
              unselectedIcon: Icons.done_outline,
              selectedBackgroundColor: Colors.deepPurpleAccent[200]!,
              unselectedBackgroundColor: Colors.deepPurpleAccent[100]!,
            ),
            FlipBoxNavigationBarItem(
              name: 'Favourite',
              selectedIcon: Icons.person,
              unselectedIcon: Icons.person_outline,
              selectedBackgroundColor: Colors.indigoAccent[200]!,
              unselectedBackgroundColor: Colors.indigoAccent[100]!,
            ),
            FlipBoxNavigationBarItem(
              name: 'Home',
              selectedIcon: Icons.mail,
              unselectedIcon: Icons.mail_outline,
              selectedBackgroundColor: Colors.blueAccent[200]!,
              unselectedBackgroundColor: Colors.blueAccent[100]!,
            ),
            FlipBoxNavigationBarItem(
              name: 'About Us',
              selectedIcon: Icons.flag,
              unselectedIcon: Icons.outlined_flag,
              selectedBackgroundColor: Colors.greenAccent[200]!,
              unselectedBackgroundColor: Colors.greenAccent[100]!,
            ),
            FlipBoxNavigationBarItem(
              name: 'Contact Us',
              selectedIcon: Icons.people,
              unselectedIcon: Icons.people_outline,
              selectedBackgroundColor: Colors.orangeAccent[200]!,
              unselectedBackgroundColor: Colors.orangeAccent[100]!,
            ),
          ],
          onTap: _updateIndex,
        )
    );
  }
}
