// NÃO TÁ CADASTRANDO NO SISTEMA SÓ NA AUTENTICAÇÃO

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:toast/toast.dart';
import 'package:gestro_app/pages/login.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/widgets/button2Gestro.widget.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/pages/login.page.dart';
import '../globals.dart';

class CadastroScreen extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(userCredential.user != null);
      assert(await userCredential.user.getIdToken() != null);
      return userCredential.user;
    } catch (e) {
      // print do código do erro
      print("===Error===\n${e.code}\n-----------");

      // se o e-mail já estiver cadastrado
      if (e.code == "email-already-in-use") {
        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(title: Text("Esse e-mail já está cadastrado.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> docData = new Map();

    // controladores de senha e de confirmar senha,
    // para registrar o que está sendo digitado.
    dynamic myControllerPass = TextEditingController();
    dynamic myControllerPassConfirm = TextEditingController();
    dynamic myControllerLattes = TextEditingController();
    dynamic myControllerName = TextEditingController();
    dynamic myControllerEmail = TextEditingController();

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/BkRegisterScreen.png",
              ),
              fit: BoxFit.cover),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                    key: ValueKey("CadastroTextKey"),
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              InputGestro(
                textKey: "NameKey",
                text: "Nome",
                icon: Icon(
                  Icons.person,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 50,
                valueForm: myControllerName.text,
                myController: myControllerName,
                validator: (nameValue) {
                  if (nameValue.isEmpty) {
                    return 'O campo não pode ficar em branco.';
                  }
                },
                onSaved: (input) => nome = input,
              ),
              InputGestro(
                textKey: "EmailKey",
                text: "Email",
                icon: Icon(
                  Icons.mail,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 35,
                valueForm: myControllerEmail.text,
                myController: myControllerEmail,
                validator: (emailValue) {
                  if (emailValue.isEmpty) {
                    return 'O campo não pode ficar em branco.';
                  }

                  if (!(EmailValidator.validate(emailValue))) {
                    return 'E-mail inválido!';
                  }
                },
                onSaved: (input) => myControllerEmail.text = input,
              ),
              InputGestro(
                textKey: "LattesKey",
                text: "Lattes",
                icon: Icon(
                  FontAwesome.link,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 50,
                valueForm: myControllerLattes.text,
                myController: myControllerLattes,
                validator: (curriculumValue) {
                  if (curriculumValue.isEmpty) {
                    return 'O campo não pode ficar em branco.';
                  }

                  if (!(Uri.parse(myControllerLattes.text).isAbsolute)) {
                    return 'Talvez esteja faltando o http:// ou o https://';
                  }
                },
                onSaved: (input) => myControllerLattes.text = input,
              ),
              InputGestro(
                textKey: "PassKey",
                text: "Senha",
                passVisible: true,
                icon: Icon(
                  Icons.lock,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 15,
                valueForm: myControllerPass.text,
                myController: myControllerPass,
                validator: (passValue) {
                  if (passValue.isEmpty) {
                    return 'O campo não pode ficar em branco.';
                  }

                  if (passValue.length < 6) {
                    return 'Senha tem menos que 6 dígitos.';
                  }

                  if (myControllerPass.text != myControllerPassConfirm.text) {
                    return 'As senhas precisam ser iguais.';
                  }
                },
                onSaved: (input) => myControllerPass.text = input,
              ),
              InputGestro(
                textKey: "PassConfirmKey",
                text: "Confirme a senha",
                passVisible: true,
                icon: Icon(
                  Icons.lock,
                  color: purpleSecudary,
                ),
                qtdeLengthCharacters: 15,
                myController: myControllerPassConfirm,
                validator: (passConfirmValue) {
                  if (passConfirmValue.isEmpty) {
                    return 'O campo não pode ficar em branco.';
                  }

                  if (passConfirmValue.length < 6) {
                    return 'Senha tem menos que 6 dígitos.';
                  }

                  if (myControllerPass.text != myControllerPassConfirm.text) {
                    return 'As senhas precisam ser iguais.';
                  }
                },
              ),
              GestureDetector(
                // padding: EdgeInsets.all(0),
                onTap: () {
                  if (widget.formKey.currentState.validate()) {
                    widget.formKey.currentState.save();
                    signUp(myControllerEmail.text, myControllerPass.text).then(
                      (value) {
                        if (value == null) {
                          return;
                        }
                        docData['name'] = myControllerName.text;
                        docData['email'] = myControllerEmail.text;
                        docData['type'] = 'Pesquisador';
                        docData['curriculum'] = myControllerLattes.text;
                        docData['activationStatus'] = null;
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(value.uid)
                            .set(docData);
                        Toast.show("Usuário esperando aprovação", context,
                            duration: 5, gravity: Toast.BOTTOM);

                        Navigator.pop(context);
                      },
                    );
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
                      onTap: () {
                        Future.delayed(
                          Duration(
                            milliseconds: 0,
                          ),
                        ).then(
                          (_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
