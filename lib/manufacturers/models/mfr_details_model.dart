import 'package:equatable/equatable.dart';
import 'package:mbank_task/manufacturers/models/vehicle_types_model.dart';

class MfrDetailsModel extends Equatable {
  final String mfrName;
  final int mfrID;
  final List<VehicleTypeModel> vehicleTypes;

  const MfrDetailsModel({
    required this.mfrName,
    required this.mfrID,
    required this.vehicleTypes,
  });

  factory MfrDetailsModel.fromJson(Map<String, dynamic> json) {
    List vehicleTypesJson = json['VehicleTypes'] as List;
    List<VehicleTypeModel> _vehicleTypeModelList =
        vehicleTypesJson.map((e) => VehicleTypeModel.fromJson(e)).toList();
    final mfrName = json['Mfr_Name'] as String;
    final mfrID = json['Mfr_ID'] as int;

    return MfrDetailsModel(
        mfrName: mfrName, mfrID: mfrID, vehicleTypes: _vehicleTypeModelList);
  }

  @override
  List<Object?> get props => [];
}
