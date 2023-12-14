import 'package:flutter/material.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_colors.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, this.onPress});
  final Function? onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning_amber_outlined, size: 80),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
                AppLocalizations.of(context)!
                    .translate('something_went_wrong')!,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(AppLocalizations.of(context)!.translate('try_again')!,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (onPress != null) {
                  onPress!();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(24)),
              ),
              child: Text(
                  AppLocalizations.of(context)!.translate('reload_screen')!,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          )
        ],
      ),
    );
  }
}
