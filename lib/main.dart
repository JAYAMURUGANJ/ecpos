import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Form',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Color(0xFFCCC01D)),
      ),
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
