import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_event.dart';

class TabBarBloc extends Bloc<NavigationBarEvent, int> {
  TabBarBloc(int initialState)
      : super(initialState);

  int currentIndex = 0;

  @override
  Stream<int> mapEventToState(
    NavigationBarEvent event,
  ) async* {
    if (event is NavBarTappedEvent) {
      currentIndex = event.index;
      yield currentIndex;
    }
  }

  @override
  void onTransition(Transition<NavigationBarEvent, int> transition) {
    print(transition);
  }
}
// }
// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:tab/screens/tab_bar/bloc/tab_bar_event.dart';
// import 'package:tab/screens/tab_bar/bloc/tab_bar_state.dart';

// class TabBarBloc extends Bloc<NavigationBarEvent, NavBarState> {
//   TabBarBloc() : super(NavBarInitialState());

//   int currentIndex = 1;

//   @override
//   Stream<NavBarState> mapEventToState(
//     NavigationBarEvent event,
//   ) async* {
//     if (event is NavBarTappedEvent) {
//       currentIndex = event.index;
//       yield NavBarSelectedState(index: currentIndex);
//     }
//   }
// }

