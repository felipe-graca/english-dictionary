part of 'bottom_navigator_cubit.dart';

enum BottomNavigatorPageEnum {
  profile,
  history,
  dictionary,
  favorites,
}

class BottomNavigatorPageModel {
  final String title;
  final IconData icon;
  final String route;

  const BottomNavigatorPageModel({
    required this.title,
    required this.icon,
    required this.route,
  });

  BottomNavigatorPageEnum get pageEnum {
    switch (route) {
      case AppRoutes.profile:
        return BottomNavigatorPageEnum.profile;
      case AppRoutes.history:
        return BottomNavigatorPageEnum.history;
      case AppRoutes.dictionary:
        return BottomNavigatorPageEnum.dictionary;
      case AppRoutes.favorites:
        return BottomNavigatorPageEnum.favorites;
      default:
        return BottomNavigatorPageEnum.dictionary;
    }
  }
}

const Map<BottomNavigatorPageEnum, BottomNavigatorPageModel> bottomNavigatorPages = {
  BottomNavigatorPageEnum.profile: BottomNavigatorPageModel(
    title: 'Profile',
    icon: Icons.account_circle,
    route: AppRoutes.profile,
  ),
  BottomNavigatorPageEnum.history: BottomNavigatorPageModel(
    title: 'History',
    icon: Icons.history,
    route: AppRoutes.history,
  ),
  BottomNavigatorPageEnum.dictionary: BottomNavigatorPageModel(
    title: 'Dictionary',
    icon: Icons.book,
    route: AppRoutes.dictionary,
  ),
  BottomNavigatorPageEnum.favorites: BottomNavigatorPageModel(
    title: 'Favorites',
    icon: Icons.favorite,
    route: AppRoutes.favorites,
  ),
};

class BottomNavigatorState extends Equatable {
  final Map<BottomNavigatorPageEnum, BottomNavigatorPageModel> pages;
  final BottomNavigatorPageEnum currentPage;

  const BottomNavigatorState({
    this.currentPage = BottomNavigatorPageEnum.dictionary,
  }) : pages = bottomNavigatorPages;

  @override
  List<Object?> get props => [
        pages,
        currentPage,
      ];

  BottomNavigatorState copyWith({
    BottomNavigatorPageEnum? currentPage,
  }) {
    return BottomNavigatorState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
