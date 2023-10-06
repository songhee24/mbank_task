import 'package:equatable/equatable.dart';
import 'package:mbank_task/manufacturers/models/vehicle_types_model.dart';

final class MfrModel extends Equatable {
  final int mfrId;
  final String country;
  final String mfrName;
  final List<VehicleTypeModel>? vehicleTypes;

  const MfrModel({
    required this.mfrId,
    required this.mfrName,
    required this.country,
    this.vehicleTypes,
  });

  factory MfrModel.fromJson(Map<String, dynamic> json) {
    List vehicleTypesJson = json['VehicleTypes'] as List;
    List<VehicleTypeModel> vehicleTypeModelList = vehicleTypesJson.map((e) {
      return VehicleTypeModel.fromJson(e);
    }).toList();
    final mfrId = json['Mfr_ID'] as int;
    final country = json['Country'] as String;
    final mfrName = json['Mfr_Name'] as String;
    return MfrModel(
        mfrId: mfrId,
        mfrName: mfrName,
        country: country,
        vehicleTypes: vehicleTypeModelList);
  }

  @override
  List<Object?> get props => [mfrId, country, mfrName];
}
