import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/data/db_provider.dart';
import 'package:mbank_task/manufacturers/data/mfr_repository.dart';
import 'package:mbank_task/manufacturers/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  final mfrRepository = MfrRepository();
  final dBProvider = DBProvider.db;
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<MfrBloc>(
            create: (_) => MfrBloc(
                  mfrRepository: mfrRepository,
                  dbProvider: dBProvider,
                ))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      title: 'Manufacturers App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromARGB(255, 240, 232, 232),
        useMaterial3: true,
      ),
    );
  }
}
