import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/dashboard_view.dart';
import 'viewmodels/dashboard_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analytics Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Inter',
      ),
      home: ChangeNotifierProvider(
        create: (_) => DashboardViewModel(),
        child: const DashboardView(),
      ),
    );
  }
}
