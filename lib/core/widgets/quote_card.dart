import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/features/favorite_quote/presentation/cubit/favorite_quote_cubit.dart';
import 'package:quotes/features/random_quotes/domain/entities/quote.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QuoteCard extends StatelessWidget {
  QuoteCard({super.key, required this.quote});
  final Quote quote;
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteQuoteCubit, FavoriteQuoteState>(
      builder: (context, state) {
        var favoriteQuoteCubit = FavoriteQuoteCubit.get(context);
        return Screenshot(
          controller: screenshotController,
          child: Container(
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ",,",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        quote.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 8,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            quote.author,
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                screenshotController.capture().then((value) {
                                  saveImage(value!, quote.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Quote saved to gallery'),
                                  ));
                                });
                              },
                              icon: const Icon(Icons.save_alt)),
                          IconButton(
                              onPressed: () {
                                screenshotController.capture().then((value) {
                                  saveAndShare(value!, quote.id);
                                });
                              },
                              icon: const Icon(Icons.ios_share)),
                          IconButton(
                              onPressed: () {
                                favoriteQuoteCubit.toggleFavoriteQuote(quote);
                              },
                              icon: Icon(
                                (favoriteQuoteCubit.quotesList.contains(quote))
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              )),
                        ],
                      )
                    ]),
              )),
        );
      },
    );
  }
}

Future<void> saveAndShare(Uint8List bytes, String id) async {
  final directory = await getApplicationDocumentsDirectory();

  final image = File('${directory.path}/quote_$id.png');
  image.writeAsBytesSync(bytes);

  Share.shareXFiles([XFile(image.path)]);
}

Future<String> saveImage(Uint8List bytes, String id) async {
  await Permission.storage.request();
  final result = await ImageGallerySaver.saveImage(bytes, name: 'quote_$id');
  return result['filePath'];
}
