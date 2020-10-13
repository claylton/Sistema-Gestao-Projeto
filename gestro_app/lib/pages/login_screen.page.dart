import 'package:flutter/material.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/BkLoginScreen.png"),
              fit: BoxFit.fitWidth),
        ),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        child: Container(
          padding: EdgeInsets.only(top: 320, left: 35, right: 35),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ContainerGestro(
                text: "Email",
                icon: Icon(Icons.email),
                qtdeLengthCharacters: 35,
              ),
              ContainerGestro(
                text: "Senha",
                icon: Icon(Icons.lock),
                qtdeLengthCharacters: 15,
                passVisible: true,
              ),
              ButtonGestro(
                text: 'Login',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 55),
                    child: Text(
                      "Não possui cadastro?",
                      style: TextStyle(fontSize: 16, color: Colors.purple),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 55, left: 5),
                    child: InkWell(
                      child: Text(
                        "Cadastrar-se.",
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
    );
  }
}
