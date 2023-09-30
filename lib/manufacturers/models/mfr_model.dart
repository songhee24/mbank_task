import 'package:equatable/equatable.dart';

final class MfrModel extends Equatable {
  final int mfrId;
  final String country;
  final String mfrName;

  const MfrModel({
    required this.mfrId,
    required this.mfrName,
    required this.country,
  });

  factory MfrModel.fromJson(Map<String, dynamic> json) {
    final mfrId = json['Mfr_ID'] as int;
    final country = json['Country'] as String;
    final mfrName = json['Mfr_Name'] as String;
    return MfrModel(mfrId: mfrId, mfrName: mfrName, country: country);
  }

  @override
  List<Object?> get props => [mfrId, country, mfrName];
}
