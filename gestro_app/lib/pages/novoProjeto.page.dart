import 'package:flutter/material.dart';
import 'package:gestro_app/pages/bottomNavigation.dart';
import 'package:gestro_app/widgets/appBarGestro.widget.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestroGrande.widget.dart';

class NovoProjetoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigation(),
      appBar: AppBarGestro(
        title: "Projetos",
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/BkLampada.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.3,
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
                children: [
                  Center(
                    child: Text(
                      "Novo projeto",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InputGestro(text: "Nome", icon: null),
                  InputGestroGrande(text: "Descrição", icon: null),
                  InputGestro(text: "Data de início", icon: null),
                  InputGestro(text: "Data de Término", icon: null),
                  ButtonGestro(text: "Salvar"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
