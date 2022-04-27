import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpya/home/home.dart';
import 'package:mpya/services/connectivityService.dart';
import 'package:mpya/services/jokeService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //service registration here
        home: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => JokeService()),
            RepositoryProvider(create: (context) => ConnectivityService())
          ],
          child: HomePage(),
        ));
  }
}
