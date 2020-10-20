import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Teste de Integração", () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    var inkwellCadastrarSe = find.byValueKey("CadastrarSeKey");

    // container de Nome
    var containerName = find.byValueKey("NameKey");
    var containerNameText = find.text("test");

    // container de E-mail
    var containerEmail = find.byValueKey("EmailKey");
    var containerEmailText = find.text("test@test.com");

    // container de Senha
    var containerPass = find.byValueKey("PassKey");

    // container de Confirmar Senha
    var containerPassConfirm = find.byValueKey("PassConfirmKey");

    // botão de Cadastrar
    var btnCadastrar = find.byValueKey("btnCadastrarKey");

    // botão de Login
    var btnLogin = find.byValueKey("btnLoginKey");

    test("Verificar a saúde do flutter driver", () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    // test("Tela de Cadastro", () async {
    //   // clicar no inkwell de cadastrar-se
    //   await driver.tap(inkwellCadastrarSe);

    //   // clicar e inserir dado no container de Nome
    //   await driver.tap(containerName);
    //   await driver.enterText("test");
    //   await driver.waitFor(containerNameText);

    //   // clicar e inserir dado no container de E-mail
    //   await driver.tap(containerEmail);
    //   await driver.enterText("test@test.com");
    //   await driver.waitFor(containerEmailText);

    //   // clicar e inserir dado no container de Senha
    //   await driver.tap(containerPass);
    //   await driver.enterText("12345678");
    //   await Future.delayed(Duration(seconds: 2));

    //   // clicar e inserir dado no container de Confirmar Senha
    //   await driver.tap(containerPassConfirm);
    //   await driver.enterText("12345678");
    //   await Future.delayed(Duration(seconds: 2));

    //   // clicar no botão de Cadastrar
    //   await driver.tap(btnCadastrar);
    //   await driver.tap(btnCadastrar);
    //   await Future.delayed(Duration(seconds: 10));
    // });

    test("Tela de Login", () async {
      // clicar e inserir dado no container de E-mail
      await driver.tap(containerEmail);
      await driver.enterText("test@test.com");
      await driver.waitFor(containerEmailText);
      await Future.delayed(Duration(seconds: 2));

      // clicar e inserir dado no container de Senha
      await driver.tap(containerPass);
      await driver.enterText("12345678");
      await Future.delayed(Duration(seconds: 2));

      // clicar nop botão de Login
      await driver.tap(btnLogin);
      await driver.waitUntilNoTransientCallbacks();
    });
  });
}
