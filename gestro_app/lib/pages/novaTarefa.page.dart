import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:gestro_app/models/project.model.dart';
import 'package:gestro_app/pages/abas/abaTarefa.page.dart';
import 'package:gestro_app/pages/tarefas.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/widgets/bottomNavigation.dart';
import 'package:gestro_app/widgets/appBarGestro.widget.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestroGrande.widget.dart';
import 'package:intl/intl.dart';

class NovaTarefaPage extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  dynamic dataPrazo;
  int index;
  final firestoreInstance = FirebaseFirestore.instance;
  ProjectModel projeto;

  DocumentReference documentReference;

  dynamic myControllerNomeTarefa = TextEditingController();
  dynamic myControllerDescTarefa = TextEditingController();

  void newTask(context) {
    firestoreInstance
        .collection("Projects")
        .doc(projeto.idProject.id)
        .collection("Tasks")
        .add({
      "name": myControllerNomeTarefa.text,
      "description": myControllerDescTarefa.text,
      "deadline": dataPrazo,
    });
    AbaTarefa(projectModel: this.projeto);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TarefaPage(),
      ),
    );
  }

  NovaTarefaPage({@required this.projeto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigation(),
      appBar: AppBarGestro(
        title: "Tarefa",
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/BkNovaTarefa.jpg",
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
                      "Nova Tarefa",
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // InputGestro(text: "ID do Projeto - números", icon: null, myController: myControllerIDProjeto),
                  InputGestro(
                    text: "Nome",
                    icon: null,
                    myController: myControllerNomeTarefa,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: purplePrimary,
                      ),
                      margin: EdgeInsets.only(top: 15),
                      padding: EdgeInsets.only(left: 20, right: 10),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Column(children: [
                        DateTimeField(
                            decoration: InputDecoration(
                              hintText: "Prazo",
                              hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.032,
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                            ),
                            format: format,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              ).then((pickedDate) {
                                dataPrazo = pickedDate;
                                return dataPrazo;
                              });
                            })
                      ])),
                  InputGestroGrande(
                      text: "Descrição",
                      icon: null,
                      myController: myControllerDescTarefa),
                  GestureDetector(
                    onTap: () {
                      newTask(context);
                    },
                    child: ButtonGestro(
                      text: "Salvar",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
