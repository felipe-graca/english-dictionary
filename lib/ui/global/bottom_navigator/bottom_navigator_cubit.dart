import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigator_state.dart';

class BottomNavigatorCubit extends Cubit<BottomNavigatorState> {
  BottomNavigatorCubit() : super(const BottomNavigatorState());

  void init() async {}
}
