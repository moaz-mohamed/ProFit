class UserProfile {
  // late String _id;
  late String _name;
  late String _email;
  late int _goal;
  late String _age;
  late String _height;
  late String _weight;
  late bool _gender;
  late double _activityLevel;
  late double calories;
  late double remainingCalories;
  late double eatenCalories;
  late double burnedCalories;
  late double totalProteins;
  late double totalFats;
  late double totalCarbs;
  late double remainingProteins;
  late double remainingFats;
  late double remainingCarbs;

  List<Map<String, dynamic>> breakfast = [];
  List<Map<String, dynamic>> lunch = [];
  List<Map<String, dynamic>> dinner = [];
  List<Map<String, dynamic>> workout = [];

  UserProfile(dynamic obj) {
    //  _id =  obj['id'];
    _name = obj['name'];
    _email = obj['email'];
    _goal = obj['goal'];
    _age = obj['age'];
    _height = obj['height'];
    _weight = obj['weight'];
    _gender = obj['gender'];
    _activityLevel = obj['activityLevel'];
    calories = obj['calories'];
    remainingCalories = 0;
    eatenCalories = 0;
    burnedCalories = 0;
    totalProteins = 0;
    totalCarbs = 0;
    totalFats = 0;
    remainingProteins = 0;
    remainingFats = 0;
    remainingCarbs = 0;
  }

  UserProfile.fromMap(Map<String, dynamic> data) {
    // _id =  data['id'];
    _name = data['name'];
    _email = data['email'];
    _goal = data['goal'];
    _age = data['age'];
    _height = data['height'];
    _weight = data['weight'];
    _gender = data['gender'];
    _activityLevel = data['activityLevel'];
    calories = data['calories'];
    remainingCalories = data['_remainingCalories'];
    eatenCalories = data['_eatenCalories'];
    burnedCalories = data['_burnedCalories'];
    breakfast = data['breakfast'];
    lunch = data['lunch'];
    dinner = data['dinner'];
    workout = data['workout'];
    totalProteins = data['_totalProteins'];
    totalCarbs = data['_totalCarbs'];
    totalFats = data['_totalFats'];
  }

  Map<String, dynamic> toMap() => {
        'name': _name,
        'email': _email,
        'goal': _goal,
        'age': _age,
        'height': _height,
        'weight': _weight,
        'gender': _gender,
        'activityLevel': _activityLevel,
        'calories': calories,
        'remainingCalories': remainingCalories,
        'eatenCalories': eatenCalories,
        'burnedCalories': eatenCalories,
        'breakfast': breakfast,
        'lunch': lunch,
        'dinner': dinner,
        'workout': workout,
        'totalFats': totalFats,
        'totalCarbs': totalCarbs,
        'totalProteins': totalProteins,
        'remainingFats': remainingFats,
        'remainingCarbs': remainingCarbs,
        'remainingProteins': remainingProteins,
      };
  //   String getId() => _id;

  // setId(String id){
  //     _id = id;
  // }
}
