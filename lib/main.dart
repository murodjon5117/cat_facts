import 'package:cat_facts/domain/model/cat_fact.dart';
import 'package:cat_facts/presentation/bloc/cat_facts_bloc.dart';
import 'package:cat_facts/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/repositories/cat_repository.dart';
import 'package:dio/dio.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatFactAdapter());
  await Hive.openBox<CatFact>('facts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CatFactsBloc(
          repository: CatRepository(Dio()),
          factsBox: Hive.box<CatFact>('facts'),
        )..add(LoadNewFact()),
        child: const HomeScreen(),
      ),
    );
  }
}
