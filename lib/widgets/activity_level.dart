// import 'package:calory_calc/common/theme/theme.dart';
// import 'package:calory_calc/widgets/customRadio.dart';
// import 'package:calory_calc/widgets/widgets.dart';
// import 'package:flutter/material.dart';
//
// class ActivityLevelForm extends StatefulWidget {
//   const ExerciseStressPickerForm({
//     Key key,
//     @required this.onComplete,
//   }) : super(key: key);
//
//   final Function(double workModel) onComplete;
//
//   @override
//   _ActivityLevelFormState createState() =>
//       _ActivityLevelFormState();
// }
//
// class _ActivityLevelFormState extends State<ActivityLevelForm> {
//   late double _activityLevel;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.all(40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Column(
//             children: [
//               Text(
//                 'Регистрация',
//                 style: CustomTheme.title,
//               ),
//               Text(
//                 'Физическая активность',
//                 style: CustomTheme.subtitle.copyWith(
//                   color: theme.primaryColor,
//                 ),
//               ),
//             ],
//           ),
//           CustomRadio(
//             onSelect: (double activityLevel) {
//               setState(() {
//                 _activityLevel = activityLevel;
//               });
//             },
//           ),
//           CommonButton(
//             child: Text(
//               'Далее',
//               style: Theme.of(context).textTheme.button.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             onPressed: () => widget.onComplete(_activityLevel),
//           ),
//         ],
//       ),
//     );
//   }
// }
