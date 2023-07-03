import 'package:english_dictionary/core/routes/app_routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorState> {
  BottomNavigatorCubit() : super(const BottomNavigatorState());

  void init() async {}

  void changePage(String route) {
    late BottomNavigatorPageEnum page;
    switch (route) {
      case AppRoutes.profile:
        page = BottomNavigatorPageEnum.profile;
        break;
      case AppRoutes.history:
        page = BottomNavigatorPageEnum.history;
        break;
      case AppRoutes.dictionary:
        page = BottomNavigatorPageEnum.dictionary;
        break;
      case AppRoutes.favorites:
        page = BottomNavigatorPageEnum.favorites;
        break;
      default:
        page = BottomNavigatorPageEnum.dictionary;
    }

    emit(state.copyWith(currentPage: page));
  }
}
