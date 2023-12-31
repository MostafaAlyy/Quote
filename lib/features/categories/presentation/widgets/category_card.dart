import 'package:flutter/material.dart';
import 'package:quotes/config/routes/app_routes.dart';
import 'package:quotes/core/utils/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.quotesByCategory,
          arguments: title),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            )),
        child: Center(child: Text(title)),
      ),
    );
  }
}
