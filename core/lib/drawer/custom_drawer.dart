import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final bool isMovie;
  CustomDrawer({required this.isMovie});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              if (isMovie) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, HOME_MOVIE_PAGE);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV'),
            onTap: () {
              if (isMovie) {
                Navigator.pushNamed(context, HOME_TV_PAGE);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_PAGE);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_PAGE);
            },
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
