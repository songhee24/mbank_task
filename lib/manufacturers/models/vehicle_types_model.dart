class VehicleTypeModel {
  final String gVWRFrom;
  final String gVWRTo;
  final bool isPrimary;
  final String name;

  VehicleTypeModel(
      {required this.gVWRFrom,
      required this.gVWRTo,
      required this.isPrimary,
      required this.name});

  factory VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    final gVWRFrom = json['GVWRFrom'] as String;
    final gVWRTo = json['GVWRTo'] as String;
    final isPrimary = json['IsPrimary'] as bool;
    final name = json['Name'] as String;
    return VehicleTypeModel(
        gVWRFrom: gVWRFrom, gVWRTo: gVWRTo, isPrimary: isPrimary, name: name);
  }
}
