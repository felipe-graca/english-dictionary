import 'package:english_dictionary/core/routes/app_router.dart';
import 'package:english_dictionary/core/utils/utils.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/cubit/bottom_navigator_cubit.dart';
import 'package:english_dictionary/ui/global/bottom_navigator/widget/bottom_navigator_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BottomNavigatorBar extends StatelessWidget {
  const BottomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = GetIt.I.get<BottomNavigatorCubit>();

    return BlocBuilder<BottomNavigatorCubit, BottomNavigatorState>(
      bloc: cubit,
      builder: (context, state) {
        return SafeArea(
          child: Container(
            height: Utils.getBottomNavigatorHeight(context),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFCDCDCD).withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(2, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...state.pages.values.map(
                  (e) => SizedBox(
                    width: 50,
                    height: 50,
                    child: BottomNavigatorItem(
                      icon: e.icon,
                      onTap: () {
                        if (state.currentPage == e.pageEnum) return;
                        cubit.changePage(e.route);
                        Navigator.of(AppRouter.navigatorKey.currentState!.context).pushNamed(e.route);
                      },
                      isActive: state.currentPage == e.pageEnum,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
