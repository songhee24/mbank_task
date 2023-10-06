import 'package:mbank_task/manufacturers/data/mfr_api.dart';
import 'package:mbank_task/manufacturers/models/mfr_model.dart';
// import 'dart:convert';

class MfrRepository {
  static const String baseUrl = "https://vpic.nhtsa.dot.gov/api/vehicles";
  late MfrApi mfrApi = MfrApi();

  Future<List<MfrModel>> fetchManufacturers(int startIndex) async {
    try {
      final response = await mfrApi.get(
        path: '$baseUrl/getallmanufacturers',
        queryParameters: {'page': startIndex.toString(), 'format': 'json'},
      );
      final Map<String, dynamic> data = response.data;
      final results = data['Results'] as List;
      return results.map((dynamic json) {
        return MfrModel.fromJson(json);
      }).toList();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<MfrModel> fetchManufacturer(int manufacturerId) async {
    try {
      final response = await mfrApi.get(
          path: '$baseUrl/getmanufacturerdetails/$manufacturerId',
          queryParameters: {'format': 'json'});
      final Map<String, dynamic> data = response.data;
      final results = data['Results'] as List;
      return MfrModel.fromJson(results[0]);
    } catch (e) {
      rethrow;
    }
  }
}
