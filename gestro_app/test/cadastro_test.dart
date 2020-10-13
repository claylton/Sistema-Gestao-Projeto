import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestro_app/pages/cadastro_screen.page.dart';
import 'package:gestro_app/widgets/buttonGestro.widget.dart';
import 'package:gestro_app/widgets/containerGestro.widget.dart';

void main() {
  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('Teste da Tela de Cadastro', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CadastroScreen()));
    var singleChildScrollView = find.byType(SingleChildScrollView);
    expect(singleChildScrollView, findsOneWidget);

    // texto "Cadastro"
    var textCadastro = find.text("Cadastro");
    expect(textCadastro, findsOneWidget);

    // container gestro
    var containerGestro = find.byType(ContainerGestro);
    expect(containerGestro, findsNWidgets(4));

    var textNome = find.text("Nome");
    expect(textNome, findsOneWidget);

    var textEmail = find.text("Email");
    expect(textEmail, findsOneWidget);

    var textSenha = find.text("Senha");
    expect(textSenha, findsOneWidget);

    var textSenhaConfirm = find.text("Confirme a senha");
    expect(textSenhaConfirm, findsOneWidget);

    // botão
    var buttonGestro = find.byType(ButtonGestro);
    expect(buttonGestro, findsOneWidget);

    // textos finais
    var textJaPossuiCadastro = find.text("Já possui cadastro?");
    expect(textJaPossuiCadastro, findsOneWidget);

    var textFacaLogin = find.text("Faça login.");
    expect(textFacaLogin, findsOneWidget);
  });
}
