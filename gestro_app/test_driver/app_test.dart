import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Tela de Cadastro', () {
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

    var containerName = find.byValueKey("NameKey");
    var containerNameText = find.text("test");

    var containerEmail = find.byValueKey("EmailKey");
    var containerEmailText = find.text("test@test.com");

    var containerPass = find.byValueKey("PassKey");
    var containerPassConfirm = find.byValueKey("PassConfirmKey");

    test("Tela de Cadastro", () async {
      // clicar no inkwell de cadastrar-se
      await driver.tap(inkwellCadastrarSe);

      // clicar e inserir dado no container de Nome
      await Future.delayed(Duration(seconds: 5));
      await driver.tap(containerName);
      await Future.delayed(Duration(seconds: 2));
      await driver.enterText("test");
      await driver.waitFor(containerNameText);
      await Future.delayed(Duration(seconds: 2));

      // clicar e inserir dado no container de E-mail
      await driver.tap(containerEmail);
      await Future.delayed(Duration(seconds: 2));
      await driver.enterText("test@test.com");
      await driver.waitFor(containerEmailText);
      await Future.delayed(Duration(seconds: 2));

      // clicar e inserir dado no container de Senha
      await driver.tap(containerPass);
      await Future.delayed(Duration(seconds: 2));
      await driver.enterText("12345678");
      await Future.delayed(Duration(seconds: 2));

      // clicar e inserir dado no container de Confirmar Senha
      await driver.tap(containerPassConfirm);
      await Future.delayed(Duration(seconds: 2));
      await driver.enterText("12345678");
      await Future.delayed(Duration(seconds: 2));

      await driver.waitUntilNoTransientCallbacks();
    });
  });
}
