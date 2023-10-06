class VehicleTypeModel {
  final String? gVWRFrom;
  final String? gVWRTo;
  final bool? isPrimary;
  final String? name;

  VehicleTypeModel({this.gVWRFrom, this.gVWRTo, this.isPrimary, this.name});

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    final gVWRFrom = json['GVWRFrom'];
    final gVWRTo = json['GVWRTo'];
    final isPrimary = json['IsPrimary'];
    final name = json['Name'];
    return VehicleTypeModel(
        gVWRFrom: gVWRFrom, gVWRTo: gVWRTo, isPrimary: isPrimary, name: name);
  }
}
