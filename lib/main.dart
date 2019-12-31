import 'package:bagaskara_redefined/bloc/aksara/aksara_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bagaskara_redefined/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AksaraBloc>(
        create: (context) => AksaraBloc(),
        child: HomePage(),
      )
    );
  }
}
