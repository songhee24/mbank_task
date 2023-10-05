import 'package:mbank_task/manufacturers/data/mfr_api.dart';
import 'package:mbank_task/manufacturers/models/mfr_details_model.dart';
import 'package:mbank_task/manufacturers/models/mfr_model.dart';
// import 'dart:convert';

class MfrRepository {
  static const String baseUrl =
      "https://vpic.nhtsa.dot.gov/api/vehicles/getallmanufacturers?format=json";
  late MfrApi mfrApi = MfrApi();

  Future<List<MfrModel>> fetchManufacturers(int startIndex) async {
    try {
      final response = await mfrApi.get(
        path: baseUrl,
        queryParameters: {
          'page': startIndex.toString(),
        },
      );
      final Map<String, dynamic> data = response.data;
      final results = data['Results'] as List;
      return results.map((dynamic json) {
        return MfrModel.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<MfrDetailsModel> fetchManufacturer(int manufacturerId) async {
    try {
      final response = await mfrApi.get(
        path: '$baseUrl/$manufacturerId',
      );
      final Map<String, dynamic> data = response.data;
      final results = data['Results'] as List;
      return MfrDetailsModel.fromJson(results[0]);
    } catch (e) {
      rethrow;
    }
  }
}
