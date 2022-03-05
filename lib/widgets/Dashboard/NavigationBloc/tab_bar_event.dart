abstract class NavigationBarEvent {}

class NavBarTappedEvent extends NavigationBarEvent {
  final int index;

  NavBarTappedEvent({
    required this.index,
  });
}
