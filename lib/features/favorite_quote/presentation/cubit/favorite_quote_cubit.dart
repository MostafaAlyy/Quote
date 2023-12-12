import 'package:bloc/bloc.dart';

part 'favorite_quote_state.dart';

class FavoriteQuoteCubit extends Cubit<FavoriteQuoteState> {
  FavoriteQuoteCubit() : super(FavoriteQuoteInitial());
}
