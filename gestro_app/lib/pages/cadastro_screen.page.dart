import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/pages/login_screen.page.dart';

import '../globals.dart';

class CadastroScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    Map<String, dynamic> docData = new Map();

    Future<User> signUp(email, password) async {
      try {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        assert(userCredential.user != null);
        assert(await userCredential.user.getIdToken() != null);
        return userCredential.user;
      } catch (e) {
        return null;
      }
    }

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
              image: DecorationImage(
                  image: AssetImage("assets/BkRegisterScreen.png"),
                  fit: BoxFit.fitWidth),
            ),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height),
            //Form key
            child: Form(
              key: widget.formKey,
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 250),
                    child: Center(
                      child: Text(
                        "Cadastro",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ContainerGestro(
                    textKey: "NameKey",
                    text: "Nome",
                    icon: Icon(
                      Icons.person,
                      color: purpleSecudary,
                    ),
                    qtdeLengthCharacters: 50,
                    valueForm: nome,
                    onSaved: (input) => nome = input,
                  ),
                  ContainerGestro(
                    textKey: "EmailKey",
                    text: "Email",
                    icon: Icon(
                      Icons.mail,
                      color: purpleSecudary,
                    ),
                    qtdeLengthCharacters: 35,
                    valueForm: email,
                    // if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                    // {
                    //   return Text("E-mail inválido!")
                    // },
                    onSaved: (input) => email = input,
                  ),
                  ContainerGestro(
                    textKey: "PassKey",
                    text: "Senha",
                    passVisible: true,
                    icon: Icon(
                      Icons.lock,
                      color: purpleSecudary,
                    ),
                    qtdeLengthCharacters: 15,
                    valueForm: senha,
                    onSaved: (input) => senha = input,
                  ),
                  ContainerGestro(
                    textKey: "PassConfirmKey",
                    text: "Confirme a senha",
                    passVisible: true,
                    icon: Icon(
                      Icons.lock,
                      color: purpleSecudary,
                    ),
                    qtdeLengthCharacters: 15,
                  ),
                  GestureDetector(
                    // padding: EdgeInsets.all(0),
                    onTap: () {
                      if (widget.formKey.currentState.validate()) {
                        widget.formKey.currentState.save();

                        signUp(email, senha).then((value) {
                          docData['name'] = nome;
                          docData['email'] = email;
                          docData['password'] = senha;
                          docData['type'] = 'Aluno';
                          docData['created_at'] = Timestamp.now();
                          docData['updated_at'] = Timestamp.now();
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(value.uid)
                              .set(docData);
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: ButtonGestro(
                      textKey: "btnCadastrarKey",
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
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
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
