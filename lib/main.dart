import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';
import 'package:quotes/bloc_observer.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.serviceLocatorInit();
  Bloc.observer = AppBlocObserver();
  runApp(const QuoteApp());
}
