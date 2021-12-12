class Items {
  Items({
    required this.text,
    required this.hints,
  });
  late final String text;

  late final List<Hints> hints;

  Items.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    hints = List.from(json['hints']).map((e) => Hints.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['hints'] = hints.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Food {
  Food({
    required this.foodId,
    required this.label,
    required this.nutrients,
    required this.category,
    required this.categoryLabel,
    required this.image,
  });
  late final String foodId;
  late final String label;
  late final Nutrients nutrients;
  late final String category;
  late final String categoryLabel;
  late final String image;

  Food.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
    label = json['label'];
    nutrients = Nutrients.fromJson(json['nutrients']);
    category = json['category'];
    categoryLabel = json['categoryLabel'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['foodId'] = foodId;
    _data['label'] = label;
    _data['nutrients'] = nutrients.toJson();
    _data['category'] = category;
    _data['categoryLabel'] = categoryLabel;
    _data['image'] = image;
    return _data;
  }
}

class Nutrients {
  Nutrients({
    required this.ENERCKCAL,
    required this.PROCNT,
    required this.FAT,
    required this.CHOCDF,
  });
  late final int ENERCKCAL;
  late final double PROCNT;
  late final double FAT;
  late final double CHOCDF;

  Nutrients.fromJson(Map<String, dynamic> json) {
    ENERCKCAL = json['ENERC_KCAL'];
    PROCNT = json['PROCNT'];
    FAT = json['FAT'];
    CHOCDF = json['CHOCDF'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ENERC_KCAL'] = ENERCKCAL;
    _data['PROCNT'] = PROCNT;
    _data['FAT'] = FAT;
    _data['CHOCDF'] = CHOCDF;
    return _data;
  }
}

class Hints {
  Hints({
    required this.food,
    required this.measures,
  });
  late final Food food;
  late final List<Measures> measures;

  Hints.fromJson(Map<String, dynamic> json) {
    food = Food.fromJson(json['food']);
    measures =
        List.from(json['measures']).map((e) => Measures.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['food'] = food.toJson();
    _data['measures'] = measures.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Measures {
  Measures({
    required this.uri,
    required this.label,
    required this.weight,
  });
  late final String uri;
  late final String label;
  late final double? weight;

  Measures.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    label = json['label'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uri'] = uri;
    _data['label'] = label;
    _data['weight'] = weight;
    return _data;
  }
}
