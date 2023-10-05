import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbank_task/manufacturers/bloc/mfr_bloc.dart';
import 'package:mbank_task/manufacturers/data/mfr_repository.dart';
import 'package:mbank_task/manufacturers/presentation/view/mfr_infinity_list.dart';
import 'package:provider/provider.dart';

class ManufacturersView extends StatefulWidget {
  const ManufacturersView({super.key});

  @override
  State<ManufacturersView> createState() => _ManufacturersViewState();
}

class _ManufacturersViewState extends State<ManufacturersView> {
  @override
  Widget build(BuildContext context) {
    final mfrRepository = Provider.of<MfrRepository>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Manufacturers List'),
      ),
      body: BlocProvider<MfrBloc>(
        create: (_) => MfrBloc(mfrRepository: mfrRepository)..add(MfrFetched()),
        child: const MfrInfinityList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
