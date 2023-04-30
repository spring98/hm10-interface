import 'package:hm10_interface/models/specimen_model.dart';

class DataModel {
  final int id;
  // final String placeName2;
  final String materialName;
  final int materialCount;
  final int costTime;
  final String originAnalysisResult;
  List<SpecimenModel>? specimenModels;
  final String placeName;
  final String address;
  final num lat;
  final num lon;
  final String note;
  final String inputImage;
  final String analImage;
  final String createTime;
  final String updateTime;

  DataModel({
    required this.id,
    // required this.placeName2,
    required this.materialName,
    required this.materialCount,
    required this.costTime,
    required this.originAnalysisResult,
    required this.placeName,
    required this.address,
    required this.lat,
    required this.lon,
    required this.note,
    required this.inputImage,
    required this.analImage,
    required this.createTime,
    required this.updateTime,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['ID'],
      // placeName2: json['PLACE_NAME_2'],
      materialName: json['MATERIAL_NAME'],
      materialCount: json['MATERIAL_COUNT'],
      costTime: json['COST_TIME'],
      originAnalysisResult: json['ORIGIN_ANALYSIS_RESULT'],
      placeName: json['PLACE_NAME'],
      address: json['ADDRESS'],
      lat: json['LAT'],
      lon: json['LON'],
      note: json['NOTE'],
      inputImage: json['INPUT_IMAGE'],
      analImage: json['ANAL_IMAGE'],
      createTime: json['CREATE_TIME'],
      updateTime: json['UPDATE_TIME'],
    );
  }
}
