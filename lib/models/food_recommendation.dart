class FoodRecommendationItem {
  String? name;
  double? calories;
  int? servingSizeG;

  FoodRecommendationItem({this.name, this.calories, this.servingSizeG});

  FoodRecommendationItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    servingSizeG = json['serving_size_g'];
    calories = double.parse(calories!.toStringAsFixed(2));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['serving_size_g'] = this.servingSizeG;
    return data;
  }
}
