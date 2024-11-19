import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_app/features/home_tap/cubit/home_tab_cubit.dart';
import 'package:messenger_app/view_model/home/home_view_model.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabCubit, HomeTabState>(
      builder: (context, state) {
        return BottomAppBar(
          height: 63,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate( HomeTabCubit.instance.pages.length, (index) {
                return GestureDetector(
                  onTap: () {
                     HomeTabCubit.instance.onChangePage(index);
                  
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Icon(
                          HomeTabCubit.instance.words[index]['icon'],
                          size: 27,
                          color:  HomeTabCubit.instance.currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Text(
                          HomeTabCubit.instance.words[index]['pageName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: HomeTabCubit.instance.currentIndex == index
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        );
      },
    );
  }
}
