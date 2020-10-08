import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';

import '../globals.dart';

class CadastroScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  @override
  Widget build(BuildContext context) {
    bool _initialized = false;
    bool _error = false;
    // final formKey = GlobalKey<FormState>();
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    // void initializeFlutterFire() async {
    //   try {
    //     await Firebase.initializeApp();
    //     setState(() {
    //       _initialized = true;
    //     });
    //   } catch (e) {
    //     setState(() {
    //       _error = true;
    //     });
    //   }
    // }

    // @override
    // initState() {
    //   initializeFlutterFire();
    //   super.initState();
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.6,
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/BkRegisterScreen.png"), fit: BoxFit.fitWidth),
            ),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, maxHeight: MediaQuery.of(context).size.height),
            //Form key
            child: Form(
              key: widget.formKey,
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 245),
                    child: Center(
                      child: Text(
                        "Cadastro",
                        style: TextStyle(color: Colors.purple, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ContainerGestro(
                    text: "Nome",
                    icon: Icon(
                      Icons.person,
                      color: purpleSecudary,
                    ),
                    valueForm: nome,
                    onSaved: (input) => nome = input,
                  ),
                  ContainerGestro(
                    text: "Email",
                    icon: Icon(
                      Icons.mail,
                      color: purpleSecudary,
                    ),
                    valueForm: email,
                    onSaved: (input) => email = input,
                  ),
                  ContainerGestro(
                    text: "Senha",
                    passVisible: true,
                    icon: Icon(
                      Icons.lock,
                      color: purpleSecudary,
                    ),
                    valueForm: senha,
                    onSaved: (input) => senha = input,
                  ),
                  ContainerGestro(
                    text: "Confirme a senha",
                    passVisible: true,
                    icon: Icon(
                      Icons.lock,
                      color: purpleSecudary,
                    ),
                  ),
                  GestureDetector(
                    // padding: EdgeInsets.all(0),
                    onTap: () {
                      if (widget.formKey.currentState.validate()) {
                        widget.formKey.currentState.save();
                        print(email);
                        print(nome);
                        print(senha);
                        FirebaseFirestore.instance.collection('ProjetoTeste').doc('Projeto1').set({
                          "nome": nome,
                          "email": email,
                          "senha": senha,
                        });
                      }
                      // FirebaseFirestore.instance.collection('ProjetoTeste').doc('Projeto1').set({
                      //   "nome": "claylton",
                      //   "santos": "santos",
                      //   "idade": 23,
                      // });
                      // FirebaseFirestore.instance.collection('ProjetoTeste').add({
                      //   'nome': 'Projeto claylton',
                      //   'idade': 23,
                      // });
                    },
                    child: ButtonGestro(
                      text: 'Cadastrar',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Já possui cadastro?",
                          style: TextStyle(fontSize: 16, color: Colors.purple),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25, left: 5),
                        child: InkWell(
                          child: Text(
                            "Faça login.",
                            style: TextStyle(fontSize: 16, color: Colors.purple, fontWeight: FontWeight.bold),
                          ),
                          onTap: null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
