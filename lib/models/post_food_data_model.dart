class CalculatedItems {
  String? uri;
  num? calories;
  num? totalWeight;
  TotalNutrients? totalNutrients;
  List<Ingredients>? ingredients;

  CalculatedItems(
      {this.uri,
      this.calories,
      this.totalWeight,
      this.totalNutrients,
      this.ingredients});

  CalculatedItems.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    calories = json['calories'];
    totalWeight = json['totalWeight'];
    totalNutrients = json['totalNutrients'] != null
        ? TotalNutrients.fromJson(json['totalNutrients'])
        : null;
  }
}

class TotalNutrients {
  ENERCKCAL? calories;
  FAT? fat;
  FAT? fatSat;
  FAT? fatTotTrans;
  FAT? fatTotMono;
  FAT? fatTotPoly;
  ENERCKCAL? carbs;
  ENERCKCAL? fibers;
  ENERCKCAL? sugar;
  FAT? protein;
  ENERCKCAL? cholosterol;
  ENERCKCAL? sodim;
  ENERCKCAL? calcium;
  ENERCKCAL? magensium;
  ENERCKCAL? potassium;
  FAT? iron;
  FAT? water;
  Map nutrientsValuesMap = Map();

  TotalNutrients(
      {this.calories,
      this.fat,
      this.fatSat,
      this.fatTotTrans,
      this.fatTotMono,
      this.fatTotPoly,
      this.carbs,
      this.fibers,
      this.sugar,
      this.protein,
      this.cholosterol,
      this.sodim,
      this.calcium,
      this.magensium,
      this.potassium,
      this.iron,
      this.water});

  TotalNutrients.fromJson(Map<String, dynamic> json) {
    calories = json['ENERC_KCAL'] != null
        ? ENERCKCAL.fromJson(json['ENERC_KCAL'])
        : null;
    fat = json['FAT'] != null ? FAT.fromJson(json['FAT']) : null;
    fatSat = json['FASAT'] != null ? FAT.fromJson(json['FASAT']) : null;
    fatTotTrans = json['FATRN'] != null ? FAT.fromJson(json['FATRN']) : null;
    fatTotMono = json['FAMS'] != null ? FAT.fromJson(json['FAMS']) : null;
    fatTotPoly = json['FAPU'] != null ? FAT.fromJson(json['FAPU']) : null;
    carbs = json['CHOCDF'] != null ? ENERCKCAL.fromJson(json['CHOCDF']) : null;
    fibers = json['FIBTG'] != null ? ENERCKCAL.fromJson(json['FIBTG']) : null;
    sugar = json['SUGAR'] != null ? ENERCKCAL.fromJson(json['SUGAR']) : null;
    protein = json['PROCNT'] != null ? FAT.fromJson(json['PROCNT']) : null;
    cholosterol =
        json['CHOLE'] != null ? ENERCKCAL.fromJson(json['CHOLE']) : null;
    sodim = json['NA'] != null ? ENERCKCAL.fromJson(json['NA']) : null;
    calcium = json['CA'] != null ? ENERCKCAL.fromJson(json['CA']) : null;
    magensium = json['MG'] != null ? ENERCKCAL.fromJson(json['MG']) : null;
    potassium = json['K'] != null ? ENERCKCAL.fromJson(json['K']) : null;
    iron = json['FE'] != null ? FAT.fromJson(json['FE']) : null;
    water = json['WATER'] != null ? FAT.fromJson(json['WATER']) : null;
    nutrientsValuesMap["Calories"] = calories?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Carbs"] = carbs?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Fibers"] = fibers?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Sugars"] = sugar?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Cholesterol"] = cholosterol?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Fats"] = fat?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Sat Fat"] = fatSat?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Trans Fat"] = fatTotTrans?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Mono Fats"] = fatTotMono?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Poly Fats"] = fatTotPoly?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Protein"] = protein?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Sodium"] = sodim?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Calcium"] = calcium?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Magnesium"] = magensium?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Potassium"] = potassium?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Iron"] = iron?.quantity?.toStringAsFixed(1) ?? "0";
    nutrientsValuesMap["Water"] = water?.quantity?.toStringAsFixed(1) ?? "0";
  }
}

class ENERCKCAL {
  String? label;
  num? quantity;
  String? unit;

  ENERCKCAL({this.label, this.quantity, this.unit});

  ENERCKCAL.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = this.label;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}

class FAT {
  String? label;
  num? quantity;
  String? unit;

  FAT({this.label, this.quantity, this.unit});

  FAT.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['label'] = this.label;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}

class Ingredients {
  List<Parsed>? parsed;

  Ingredients({this.parsed});

  Ingredients.fromJson(Map<String, dynamic> json) {
    if (json['parsed'] != null) {
      parsed = <Parsed>[];
      json['parsed'].forEach((v) {
        parsed!.add(Parsed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parsed != null) {
      data['parsed'] = parsed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parsed {
  num? quantity;
  String? measure;
  String? food;
  String? foodId;
  num? weight;
  num? retainedWeight;
  String? measureURI;
  String? status;

  Parsed(
      {this.quantity,
      this.measure,
      this.food,
      this.foodId,
      this.weight,
      this.retainedWeight,
      this.measureURI,
      this.status});

  Parsed.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    measure = json['measure'];
    food = json['food'];
    foodId = json['foodId'];
    weight = json['weight'];
    retainedWeight = json['retainedWeight'];
    measureURI = json['measureURI'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['measure'] = this.measure;
    data['food'] = this.food;
    data['foodId'] = this.foodId;
    data['weight'] = this.weight;
    data['retainedWeight'] = this.retainedWeight;
    data['measureURI'] = this.measureURI;
    data['status'] = this.status;
    return data;
  }
}
