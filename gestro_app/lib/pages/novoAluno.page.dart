import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestro_app/globals.dart';
import 'package:gestro_app/models/project.model.dart';
import 'package:gestro_app/pages/abas/abaAlunos.page.dart';
import 'package:gestro_app/pages/alunos.page.dart';
import 'package:gestro_app/widgets/bottomNavigation.dart';
import 'package:gestro_app/widgets/appBarGestro.widget.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';

import 'detalheProjeto.page.dart';

class NovoAlunoPage extends StatelessWidget {
  ProjectModel projectModel;
  NovoAlunoPage({
    @required this.projectModel,
  });
  final firestoreInstance = FirebaseFirestore.instance;

  dynamic myControllerAlunoNome = TextEditingController();
  dynamic myControllerAlunoEmail = TextEditingController();
  dynamic myControllerAlunoSenha = TextEditingController();
  dynamic myControllerAlunoPassConfirm = TextEditingController();
  dynamic myControllerIDProjeto = TextEditingController();

  void newAluno(context) {
    firestoreInstance.collection("Users").add({
      "name": myControllerAlunoNome.text,
      "email": myControllerAlunoEmail.text,
      "password": myControllerAlunoSenha.text,
      "passwordConfirm": myControllerAlunoPassConfirm.text,
      "type": "Aluno",
      "created_at": DateTime.now()
    }).then((reference) {
      firestoreInstance
          .collection("Projects")
          .doc(projectModel.idProject.id)
          .collection("Alunos")
          .add({
        "referencia_aluno": reference,
      });
    });

    AbaAluno(projectModel: this.projectModel);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => AlunosPage(
                projectModel: projectModelGlobal,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigation(),
      appBar: AppBarGestro(
        title: "Alunos",
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/BkNovoAluno.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.38,
                bottom: MediaQuery.of(context).size.height * 0.1,
              ),
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
                children: [
                  Center(
                    child: Text(
                      "Novo Aluno",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InputGestro(
                    text: "Nome",
                    icon: Icon(Icons.person),
                    myController: myControllerAlunoNome,
                  ),
                  InputGestro(
                    text: "Email",
                    icon: Icon(Icons.email),
                    myController: myControllerAlunoEmail,
                  ),
                  InputGestro(
                    text: "Senha",
                    icon: Icon(Icons.lock),
                    passVisible: true,
                    myController: myControllerAlunoSenha,
                  ),
                  InputGestro(
                    text: "Confirme a senha",
                    icon: Icon(Icons.lock),
                    passVisible: true,
                    myController: myControllerAlunoPassConfirm,
                  ),
                  GestureDetector(
                      child: ButtonGestro(text: "Salvar"),
                      onTap: () {
                        newAluno(context);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
