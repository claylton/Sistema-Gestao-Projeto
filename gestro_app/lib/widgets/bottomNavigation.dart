import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:gestro_app/models/project.model.dart';
import 'package:gestro_app/pages/alunos.page.dart';
import 'package:gestro_app/pages/aprovacoes.page.dart';
import 'package:gestro_app/pages/home.page.dart';
import 'package:gestro_app/pages/perfil.page.dart';
import 'package:gestro_app/pages/projetos.page.dart';
import 'package:gestro_app/pages/tarefas.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';

import '../globals.dart';

class BottomNavigation extends StatefulWidget {
  ProjectModel projectModel;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  void onTabTapped(int index) {
    currentIndexSection = index;
    setState(() {
      currentIndexSection = index;
    });
    if (currentIndexSection == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    if (currentIndexSection == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AprovacoesPage(),
        ),
      );
    }

    if (currentIndexSection == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TarefaPage(),
        ),
      );
    }

    if (currentIndexSection == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AlunosPage(),
        ),
      );
    }

    if (currentIndexSection == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PerfilPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: purpleSecudary,
      type: BottomNavigationBarType.fixed,
      onTap: onTabTapped,
      currentIndex: currentIndexSection,
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
    );
  }
}
