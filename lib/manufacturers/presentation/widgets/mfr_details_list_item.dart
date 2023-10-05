import 'package:flutter/material.dart';
import 'package:mbank_task/manufacturers/models/vehicle_types_model.dart';

class MfrDetailsListItem extends StatelessWidget {
  const MfrDetailsListItem({super.key, required this.vehicleTypeModel});

  final VehicleTypeModel vehicleTypeModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: Colors.white,
        title: Text(vehicleTypeModel.name!),
      ),
    );
  }
}
