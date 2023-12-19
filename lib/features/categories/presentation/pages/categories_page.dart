import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/core/utils/app_colors.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
      padding: EdgeInsets.all(20.r),
      itemCount: 50,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.r,
          mainAxisSpacing: 20.r,
          childAspectRatio: 1.5),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            )),
        child: Center(child: Text('Category $index')),
      ),
    ));
  }
}
