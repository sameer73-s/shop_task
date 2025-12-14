class DimensionsModel {
  final double? width;
  final double? height;
  final double? depth;

  DimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });
  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      width: json['width'],
      height: json['height'],
      depth: json['depth'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }
}
