class FoodRecommendationItem {
  String? name;
  double? calories;
  int? servingSizeG;
  double? carbs;
  double? protein;
  double? fats;

  FoodRecommendationItem({this.name, this.calories, this.servingSizeG, this.carbs, this.protein, this.fats});

  FoodRecommendationItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    servingSizeG = json['serving_size_g'];
    carbs = json['carbohydrates_total_g'];
    protein = json['protein_g'];
    fats = json['fat_total_g'];

    calories = double.parse(calories!.toStringAsFixed(2));
    carbs = double.parse(carbs!.toStringAsFixed(2));
    protein = double.parse(protein!.toStringAsFixed(2));
    fats = double.parse(fats!.toStringAsFixed(2));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['calories'] = this.calories;
    data['serving_size_g'] = this.servingSizeG;
    data['carbohydrates_total_g'] = this.carbs;
    data['protein_g'] = this.protein;
    data['fat_total_g'] = this.fats;

  
    return data;
  }
}
