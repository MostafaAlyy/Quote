import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/search/presentation/cubit/search_cubit.dart';
import 'package:quotes/injection_container.dart' as di;

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(12.r),
      child: BlocProvider(
        create: (context) => di.sl<SearchCubit>(),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            var cupit = SearchCubit.get(context);
            return Column(
              children: [
                TextField(
                  controller: cupit.searchController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    label: const Text('Search'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.r),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
