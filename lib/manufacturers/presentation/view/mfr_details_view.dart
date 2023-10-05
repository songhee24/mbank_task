import 'package:flutter/material.dart';

// 'Manufacturer details screen'
class MfrDetailsView extends StatelessWidget {
  static const routeName = '/details_page';
  const MfrDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    print(args);
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
