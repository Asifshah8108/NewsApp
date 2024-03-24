import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesspace/Auth/Provider/auth_provider.dart';
import 'package:moviesspace/profileScreen.dart';
import 'package:moviesspace/savedarticles.dart';
import 'package:moviesspace/settingsScreen.dart';
import 'package:moviesspace/settingsScreenProvider.dart';
import 'package:moviesspace/sourcesScreen.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsPage();
  }
}

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthScreenProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  // "Hello, ${provider.user?.displayName ?? ''}",
"hello,\n"+provider.displayName!,
                  style:  GoogleFonts.lato(color: Colors.white,fontSize: 18),
                ),
                SizedBox(height: 3.0),
              ],
            ),
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(Icons.home, size: 20.0, color: Colors.white),
          //   title: const Text("Home"),
          //   textColor: Colors.white,
          //   dense: true,
          // ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ProfilePage()));
              SideMenu.of(context)!.closeSideMenu();
            },
            leading: const Icon(Icons.verified_user,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => SourcesScreen()));
              SideMenu.of(context)!.closeSideMenu();
            },
            leading: const Icon(Icons.source_outlined,
                size: 20.0, color: Colors.white),
            title: const Text("Sources"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(Icons.shopping_cart,
          //       size: 20.0, color: Colors.white),
          //   title: const Text("Cart"),
          //   textColor: Colors.white,
          //   dense: true,

          //   // padding: EdgeInsets.zero,
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => SavedArticlesScreen()));
              SideMenu.of(context)!.closeSideMenu();
            },
            leading:
                const Icon(Icons.star_border, size: 20.0, color: Colors.white),
            title: const Text("Saved"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (ctx) => SettingsScreeen()));
          //           SideMenu.of(context)!.closeSideMenu();
          //   },
          //   leading:
          //       const Icon(Icons.settings, size: 20.0, color: Colors.white),
          //   title: const Text("Settings"),
          //   textColor: Colors.white,
          //   dense: true,

          //   // padding: EdgeInsets.zero,
          // ),
          ListTile(
            onTap: () {
              provider.logout(context);
              SideMenu.of(context)!.closeSideMenu();
            },
            leading: const Icon(Icons.logout_rounded,
                size: 20.0, color: Colors.white),
            title: const Text("Logout"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
