class UserModel {
  //It is the model of each user goal(lose,maintain,muscle)
  bool isSelected;
  final int dietNumber; //It represents what is your target(lose,maintain,gain)

  final String
      icon; //it is the icon that will be in assets folder icons represented by the id of the box
  final String title; //Lose weight,maintain weight,build muscle
  final String subtitle; //description of the title
  final double padding;

  UserModel(this.isSelected, this.dietNumber, this.icon, this.title,
      this.subtitle, this.padding);
}
