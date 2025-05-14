class FunnyThingsModel {
  final String id;
  final String name;
  final String description;
  final List<String> category;
  final String riskLevel;
  final List<String> suitableWeather;
  final bool requiresContinuousTime;
  final bool requiresSocial;
  final int timeCost;
  final String moneyCost;
  final String imageUrl;

  FunnyThingsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.riskLevel,
    required this.suitableWeather,
    required this.requiresContinuousTime,
    required this.requiresSocial,
    required this.timeCost,
    required this.moneyCost,
    required this.imageUrl,
  });

  factory FunnyThingsModel.fromJson(Map<String, dynamic> json) {
    return FunnyThingsModel(
      id: json['_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: List<String>.from(json['category'] ?? []),
      riskLevel: json['riskLevel'] ?? '低',
      suitableWeather: List<String>.from(json['suitableWeather'] ?? []),
      requiresContinuousTime: json['requiresContinuousTime'] ?? false,
      requiresSocial: json['requiresSocial'] ?? false,
      timeCost: json['timeCost'] ?? 0,
      moneyCost: json['moneyCost'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}