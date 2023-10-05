import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/data/mfr_repository.dart';
import 'package:mbank_task/manufacturers/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

void main() {
  final mfrRepository = MfrRepository();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<MfrBloc>(
            create: (_) => MfrBloc(mfrRepository: mfrRepository))
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
        useMaterial3: true,
      ),
    );
  }
}
