import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/search/presentation/cubit/search_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.cupit,
  });

  final SearchCubit cupit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cupit.searchController,
      style: const TextStyle(color: Colors.white),
      cursorColor: AppColors.primaryColor,
      onChanged: (value) => cupit.searchQuote(),
      onSubmitted: (value) => cupit.searchQuote(),
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.translate('search')!),
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
    );
  }
}
