part of 'bottom_navigator_cubit.dart';

enum BottomNavigatorPageEnum {
  profile,
  history,
  dictionary,
  favorites,
}

class BottomNavigatorPageModel {
  final String title;
  final String icon;
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
    icon: 'assets/icons/profile.svg',
    route: AppRoutes.profile,
  ),
  BottomNavigatorPageEnum.history: BottomNavigatorPageModel(
    title: 'History',
    icon: 'assets/icons/history.svg',
    route: AppRoutes.history,
  ),
  BottomNavigatorPageEnum.dictionary: BottomNavigatorPageModel(
    title: 'Dictionary',
    icon: 'assets/icons/dictionary.svg',
    route: AppRoutes.dictionary,
  ),
  BottomNavigatorPageEnum.favorites: BottomNavigatorPageModel(
    title: 'Favorites',
    icon: 'assets/icons/favorites.svg',
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
