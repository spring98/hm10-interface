class SpecimenModel {
  final int x;
  final int y;
  final num? specimenSize;

  SpecimenModel({
    required this.x,
    required this.y,
    required this.specimenSize,
  });

  factory SpecimenModel.fromJson(Map<String, dynamic> json) {
    return SpecimenModel(
      x: json['x'],
      y: json['y'],
      specimenSize: json['specimen_size'],
    );
  }
}
