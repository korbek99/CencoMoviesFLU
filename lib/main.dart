import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/MovieViewModel.dart';
import 'views/launch_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cenco Movie Test',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      home: const LaunchView(),
    );
  }
}
