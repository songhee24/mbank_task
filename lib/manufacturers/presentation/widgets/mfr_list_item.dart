import 'package:flutter/material.dart';
import 'package:mbank_task/manufacturers/models/mfr_model.dart';
import 'package:mbank_task/manufacturers/presentation/view/mfr_details_view.dart';

class MfrListItem extends StatelessWidget {
  const MfrListItem({required this.manufacturer, super.key});

  final MfrModel manufacturer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('selected manufacturer id ${manufacturer.mfrId}');
        Navigator.of(context).pushNamed(
          MfrDetailsView.routeName,
          arguments: manufacturer.mfrId,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          leading: Text('${manufacturer.mfrId}'),
          title: Text(manufacturer.country,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          isThreeLine: true,
          subtitle: Text(manufacturer.mfrName),
          dense: true,
        ),
      ),
    );
  }
}
