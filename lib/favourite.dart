import 'package:flutter/material.dart';
import 'package:matrimony/member_model.dart';
import 'package:matrimony/my_database.dart';

class favourite extends StatefulWidget {
  @override
  _favouriteState createState() => _favouriteState();
}



class _favouriteState extends State<favourite> {
  final _db = DB();
  List<Member> fmember = []; 
  @override
  void initState() {
    super.initState();
    _loadFavourites(); 
  }

 
  Future<void> _loadFavourites() async {
    List<Member> members = await _db.getFavourite();
    setState(() {
      fmember = members;
    });
  }

  
  Future<void> _toggleFavorite(Member favmember) async {
    setState(() {
      favmember.isFavorite = !favmember.isFavorite;
    });

    await _db.updateFavoriteStatus(favmember.id!, favmember.isFavorite ? 1 : 0);

    
    _loadFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites")),
      body: fmember.isEmpty
          ? Center(child: Text("No favorites added yet!"))
          : ListView.builder(
              itemCount: fmember.length,
              itemBuilder: (context, index) {
                Member favmember = fmember[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      favmember.name,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 54, 50, 50),
                          fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Age : ${favmember.age}"),
                        SizedBox(height: 6),
                        Text("Occupation : ${favmember.occupation}")
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () => _toggleFavorite(favmember),
                      icon: Icon(
                        favmember.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: favmember.isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
