// ignore: non_constant_identifier_names
void CalculateCalories(_goalAchieved, _ageController, _heightController,
    _weightController, _gender, _activityLevel) {
  final weight = double.tryParse(_weightController.text);
  final height = double.tryParse(_heightController.text);
  final age = double.tryParse(_ageController.text);
  final goalAcieheved = _goalAchieved;
  final activityLevel = _activityLevel;
  final gender = _gender;
  // ignore: non_constant_identifier_names
  final double BMR;
  // ignore: non_constant_identifier_names
  final double TDEE; //based on Mifflin St. Jeor calculation
  final double caloriesDaily;

  if (gender == true) {
    BMR = (10 * weight!) + (6.25 * height!) - (5 * age!) + 5;
    TDEE = BMR * activityLevel;
  } else {
    BMR = (10 * weight!) + (6.25 * height!) - (5 * age!) - 161;
    TDEE = BMR * activityLevel; //Depending on the goal achieved

  }
  switch (goalAcieheved) {
    case 1:
      {
        caloriesDaily = TDEE - 200;

        print(caloriesDaily);
      }
      break;
    case 2:
      {
        caloriesDaily = TDEE;

        print(caloriesDaily);
      }
      break;

    case 3:
      {
        caloriesDaily = TDEE + 200;

        print(caloriesDaily);
      }
      break;

    default:
      {
        print(TDEE);
      }
      break;
  }
}
