import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xFFCCC01D),
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
