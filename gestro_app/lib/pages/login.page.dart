import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestro_app/models/user_model.dart';

import 'package:gestro_app/pages/cadastro.page.dart';
import 'package:gestro_app/pages/home.page.dart';
import 'package:gestro_app/themes/globals.themes.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/inputGestro.widget.dart';
import 'package:gestro_app/globals.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;

    dynamic myControllerEmail = TextEditingController();
    dynamic myControllerPass = TextEditingController();

    Future<User> signIn(String email, String password) async {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        // print("---\n${userCredential.user}\n---");

        assert(userCredential.user != null);
        assert(await userCredential.user.getIdToken() != null);

        final User currentUser = auth.currentUser;
        assert(userCredential.user.uid == currentUser.uid);
        return userCredential.user;
      } catch (e) {
        print("===Error===\n${e}\n-----------");
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         print("Sem data");
        //       }

        //       if (snapshot.hasData) {
        //         print("Com data");
        //         print(snapshot.data.documents[0]);
        //       }
        //     });

        // FirebaseFirestore.instance
        //     .collection('Users')
        //     .where('email', isEqualTo: "${myControllerEmail.text}")
        //     .snapshots()
        //     .listen((data) => print('${data.docs[0]['email']}'));
      }
    }

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                // width: double.infinity,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: purpleSecudary,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/BkLoginScreen.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    // top: 320,
                    // top: MediaQuery.of(context).size.height * 0.45,
                    // top: 150,
                    // left: 35,
                    left: MediaQuery.of(context).size.width * 0.052,
                    // right: 35,
                    right: MediaQuery.of(context).size.width * 0.052,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.45,
                      // ),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            // fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InputGestro(
                        textKey: "EmailKey",
                        text: "Email",
                        icon: Icon(
                          Icons.email,
                        ),
                        qtdeLengthCharacters: 35,
                        valueForm: email,
                        myController: myControllerEmail,
                        validator: (emailValue) {
                          if (emailValue.isEmpty) {
                            return 'O campo não pode ficar em branco.';
                          }

                          if (!(EmailValidator.validate(emailValue))) {
                            return 'E-mail inválido!';
                          }
                        },
                      ),
                      InputGestro(
                        textKey: "PassKey",
                        text: "Senha",
                        icon: Icon(
                          Icons.lock,
                        ),
                        qtdeLengthCharacters: 15,
                        passVisible: true,
                        valueForm: senha,
                        myController: myControllerPass,
                        validator: (passValue) {
                          if (passValue.isEmpty) {
                            return 'O campo não pode ficar em branco.';
                          }

                          if (passValue.length < 6) {
                            return 'Senha tem menos que 6 dígitos.';
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          if (EmailValidator.validate(myControllerEmail.text) &&
                              (myControllerPass.text.toString().length >= 6)) {
                            signIn(myControllerEmail.text,
                                    myControllerPass.text)
                                .then((value) {
                              if (value == null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(
                                        "O e-mail não está cadastrado no sistema ou a senha está incorreta."),
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                    "Formato de e-mail inválido ou senha com menos de 6 dígitos."),
                              ),
                            );
                          }
                          // signIn(email, senha).then((value) {
                          //   if (value == null) {
                          //     showDialog(
                          //       context: context,
                          //       builder: (_) => AlertDialog(
                          //         title: Text("O e-mail não está cadastrado no sistema"),
                          //       ),
                          //     );
                          //     return;
                          //   }

                          //   if (EmailValidator.validate(myControllerEmail.text) && (myControllerPass.text.toString().length >= 6)) {
                          //     user = UserModel(name: "Claylton", type: "Pesquisador");

                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => HomePage(),
                          //       ),
                          //     );
                          //   } else {
                          //     showDialog(
                          //       context: context,
                          //       builder: (_) => AlertDialog(
                          //         title: Text("Formato de e-mail inválido ou senha com menos de 6 dígitos."),
                          //       ),
                          //     );
                          //   }
                          // });
                        },
                        child: ButtonGestro(
                          textKey: "btnLoginKey",
                          text: 'Login',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Não possui cadastro?",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          InkWell(
                            child: Text(
                              "Cadastrar-se.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
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
                                      builder: (context) => CadastroScreen(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
