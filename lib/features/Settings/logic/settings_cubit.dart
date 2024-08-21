// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<Locale> {
  SettingsCubit() : super(const Locale('en'));

  static SettingsCubit get(context) => BlocProvider.of(context);

  void changeLanguage(Locale locale) {
    emit(locale);
  }
}
