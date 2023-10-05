import 'package:flutter/material.dart';

// 'Manufacturer details screen'
class MfrDetailsView extends StatelessWidget {
  static const routeName = 'details_page';
  const MfrDetailsView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manufacturer details screen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Column(children: []),
    );
  }
}
