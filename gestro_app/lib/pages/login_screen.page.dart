import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestro_app/pages/cadastro_screen.page.dart';
import 'package:gestro_app/pages/home.page.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestro_app/globals.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;

    Future<User> signIn(String email, String password) async {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

        assert(userCredential.user != null);
        assert(await userCredential.user.getIdToken() != null);

        final User currentUser = auth.currentUser;
        assert(userCredential.user.uid == currentUser.uid);
        return userCredential.user;
      } catch (e) {
        return null;
      }
    }

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/BkLoginScreen.png",
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 320,
                    // top: MediaQuery.of(context).size.height * 0.46,
                    // top: 150,
                    left: 35,
                    right: 35,
                  ),
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ContainerGestro(
                        text: "Email",
                        icon: Icon(
                          Icons.email,
                        ),
                        qtdeLengthCharacters: 35,
                        valueForm: email,
                      ),
                      ContainerGestro(
                        text: "Senha",
                        icon: Icon(
                          Icons.lock,
                        ),
                        qtdeLengthCharacters: 15,
                        passVisible: true,
                        valueForm: senha,
                      ),
                      GestureDetector(
                        onTap: () {
                          signIn(email, senha).then((value) {
                            // print(value);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          });
                        },
                        child: ButtonGestro(
                          text: 'Login',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 55,
                            ),
                            child: Text(
                              "Não possui cadastro?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 55,
                              left: 5,
                            ),
                            child: InkWell(
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
                          ),
                        ],
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
