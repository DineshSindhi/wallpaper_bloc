import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_bloc/presentation/bloc_curated/curated_bloc.dart';
import 'package:wallpaper_bloc/presentation/get_api/api.dart';
import 'package:wallpaper_bloc/presentation/home_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => CuratedBloc(apiHelper: ApiHelper()),
        child: HomePage(),
      ),
    );
  }
}
