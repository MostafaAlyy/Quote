import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:quotes/features/categories/presentation/widgets/category_card.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        var cupit = CategoriesCubit.get(context);
        if (state is GetCategoriesListLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is GetCategoriesListError) {
          return error_widget.ErrorWidget(onPress: () {
            cupit.initCategoriesList();
          });
        }

        return GridView.builder(
          padding: EdgeInsets.all(20.r),
          itemCount: cupit.categoriesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.r,
              mainAxisSpacing: 20.r,
              childAspectRatio: 1.5),
          itemBuilder: (context, index) =>
              CategoryCard(title: cupit.categoriesList[index].name),
        );
      },
    ));
  }
}
