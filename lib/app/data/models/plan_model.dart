class PlanModel {
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final bool featured;

  const PlanModel({
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    this.featured = false,
  });
}
