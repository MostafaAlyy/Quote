import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/search/presentation/cubit/search_cubit.dart';
import 'package:quotes/features/search/presentation/widgets/quote_list_view.dart';
import 'package:quotes/features/search/presentation/widgets/seach_bar.dart';
import 'package:quotes/injection_container.dart' as di;
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(12.r),
          child: BlocProvider(
            create: (context) => di.sl<SearchCubit>(),
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                var cupit = SearchCubit.get(context);
                if (state is SearchError) {
                  return error_widget.ErrorWidget(onPress: () {
                    cupit.searchQuote();
                  });
                } else {
                  return Column(
                    children: [
                      SearchBarWidget(cupit: cupit),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (state is SearchLoading)
                        Center(
                          child: SpinKitFadingCircle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      else if (state is SearchLoaded)
                        if (state.searchQuotesResponse.results.isEmpty)
                          const Center(child: Text('No results found'))
                        else
                          QuoteListView(
                            quotes: state.searchQuotesResponse.results,
                          ),
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}
