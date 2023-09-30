import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/data/mfr_repository.dart';
import 'package:mbank_task/manufacturers/presentation/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MfrBloc>(
          create: (_) =>
              MfrBloc(mfrRepository: MfrRepository())..add(MfrFetched()),
        ),
        // BlocProvider<MfrBloc>(
        //   create: (_) =>
        //       MfrBloc(mfrRepository: MfrRepository())..add(MfrFetchedById()),
        // ),
      ],
      child: MaterialApp(
        title: 'Manufacturers App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
