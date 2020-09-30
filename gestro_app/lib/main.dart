import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/cadastro_screen.page.dart';
import 'pages/login_screen.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      //       localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate
      // ],
      // supportedLocales: [const Locale('pt', 'BR')],
      title: 'Gestro App',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: CadastroScreen(),
      // initialRoute: '/',
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => CadastroScreen(),
      // },
    );
  }
}
