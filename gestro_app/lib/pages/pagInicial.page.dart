import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:gestro_app/pages/aprovacoes.page.dart';
import 'package:gestro_app/pages/home.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';

class PagInicial extends StatefulWidget {
  @override
  _PagInicialState createState() => _PagInicialState();
}

class _PagInicialState extends State<PagInicial> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    AprovacoesPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: purpleSecudary,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome5.house_user,
              // color: index == 0 ? purpleSecudary : Colors.grey,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome5.clipboard_check,
              // color: index == 1 ? purpleSecudary : Colors.grey,
            ),
            label: "Aprovações",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome5.list,
            ),
            label: "Tarefas",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome5.users,
            ),
            label: "Alunos",
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesome5.user,
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}