import 'package:flutter/material.dart';
import 'package:insta/models/userdetails.dart';
import 'package:insta/screens/home/profile.dart';
import 'package:provider/provider.dart';

class UserSearch extends SearchDelegate {
  List<UserProfileWithUid> suggestionlist;

  final List<UserProfileWithUid> _list;
  int ind = 0;
  UserSearch(this._list);

  List<UserProfileWithUid> suggestion(String q) {
    List<UserProfileWithUid> ans = [];
    for (int i = 0; i < _list.length; i++) {
      if (_list[i].name.toLowerCase().startsWith(q.toLowerCase())) {
        ans.add(_list[i]);
      }
    }
    return ans;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResu
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    bool dark = Provider.of<bool>(context);

    suggestionlist = query.isEmpty ? _list : suggestion(query);

    return Container(
      color: dark ? Color.fromARGB(255, 39, 39, 39) : Colors.white,
      child: ListView.builder(
        itemCount: suggestionlist.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            suggestionlist[index].name,
            style: TextStyle(color: dark ? Colors.white : Colors.black),
          ),
          onTap: () {
            ind = index;
//          showResults(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return Profile(suggestionlist[index].uid);
            }));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(suggestionlist[index].dpurl),
          ),
        ),
      ),
    );
  }
}
