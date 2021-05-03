import 'package:flutter/material.dart';
import 'package:space_app/theme/appColors.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/astronauts_page/astronautsPage.dart';
import 'package:space_app/views/favorite_page/favoritePage.dart';
import 'package:space_app/views/initial_page/initialPage.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:space_app/views/settings_page/settingsPage.dart';

class BottomNavegationBarLayout extends StatefulWidget {
  @override
  _BottomNavegationBarLayoutState createState() =>
      _BottomNavegationBarLayoutState();
}

class _BottomNavegationBarLayoutState extends State<BottomNavegationBarLayout> {
  int _currentPage = 0;
  List<InterfacePage> _pages = [
    InitialPage(),
    FavoritePage(),
  ];
  Map<String, Object> _drawerItensNames = {
    'astronautas': AstronautsPage(),
    'agências': null,
    'eventos': null,
    'ISS': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.theme.backgroundColor,
      appBar: AppBar(
        title: Text('SpaceApp', style: TextStyle(color: AppColors.secondary)),
        brightness: Brightness.dark,
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: generateBottomNavegationBar(),
      drawer: generateDrawer(context),
    );
  }

  BottomNavigationBar generateBottomNavegationBar() {
    return BottomNavigationBar(
      elevation: 1,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.secondary,
      backgroundColor: AppColors.primary.shade700,
      items: generateListItens(),
      currentIndex: _currentPage,
      onTap: (value) {
        setState(() {
          _currentPage = value;
        });
      },
    );
  }

  List<BottomNavigationBarItem> generateListItens() {
    List<BottomNavigationBarItem> itens = [];
    _pages.forEach((page) {
      itens.add(new BottomNavigationBarItem(
        icon: page.pageIcon,
        label: page.pageName,
      ));
    });
    return itens;
  }

  Drawer generateDrawer(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Container(
        color: AppColors.secondary.shade600,
        child: ListView(
          padding: EdgeInsets.zero,
          children: _generateDrawerItemList(context),
        ),
      ),
    );
  }

  List<Widget> _generateDrawerItemList(BuildContext context) {
    List<Widget> list = [_generateDrawerHeader(context)];
    _drawerItensNames.forEach((key, item) {
      list.add(new ListTile(
        title: Text(key, style: AppTheme.stylerDrawerText),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => item));
        },
      ));
    });
    return list;
  }

  DrawerHeader _generateDrawerHeader(BuildContext context) {
    return DrawerHeader(
      child: Stack(children: [
        Align(
          child: IconButton(
            icon: Icon(
              Icons.settings,
              semanticLabel: 'Ajustes',
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ));
            },
          ),
          alignment: Alignment.topRight,
        ),
        Center(child: Text('SpaceApp', style: TextStyle(fontSize: 32)))
      ]),
      decoration: BoxDecoration(color: AppColors.accent),
    );
  }
}
