import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
