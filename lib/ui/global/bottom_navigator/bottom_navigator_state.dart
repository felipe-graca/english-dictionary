part of 'bottom_navigator_cubit.dart';

enum BottomNavigatorPageEnum {
  profile,
  history,
  dictionary,
  favorites,
}

const Map<BottomNavigatorPageEnum, Map<String, dynamic>> bottomNavigatorPages = {
  BottomNavigatorPageEnum.profile: {
    'title': 'Profile',
    'icon': 'assets/icons/profile.svg',
    'route': AppRoutes.profile,
  },
  BottomNavigatorPageEnum.history: {
    'title': 'History',
    'icon': 'assets/icons/history.svg',
    'route': AppRoutes.history,
  },
  BottomNavigatorPageEnum.dictionary: {
    'title': 'Dictionary',
    'icon': 'assets/icons/dictionary.svg',
    'route': AppRoutes.dictionary,
  },
  BottomNavigatorPageEnum.favorites: {
    'title': 'Favorites',
    'icon': 'assets/icons/favorites.svg',
    'route': AppRoutes.favorites,
  },
};

class BottomNavigatorState extends Equatable {
  final pages = bottomNavigatorPages;
  final currentPage = BottomNavigatorPageEnum.dictionary;
  const BottomNavigatorState({
    BottomNavigatorPageEnum? currentPage,
  });

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
