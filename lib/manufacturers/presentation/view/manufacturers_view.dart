import 'package:flutter/material.dart';
import 'package:mbank_task/manufacturers/presentation/view/mfr_infinity_list.dart';

class ManufacturersView extends StatefulWidget {
  const ManufacturersView({super.key, required this.title});

  final String title;

  @override
  State<ManufacturersView> createState() => _ManufacturersViewState();
}

class _ManufacturersViewState extends State<ManufacturersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          const MfrInfinityList(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
