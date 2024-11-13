// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appstarter/app/models/app_settings.dart';
import 'package:appstarter/app/services/app_settings_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingsRepositoryNotifier extends StateNotifier<AppSettings> {
  AppSettingsRepositoryNotifier() : super(AppSettings());

  void rehydrate(AppSettings settings) {
    state = settings;
  }

  void changeLocale(Locale locale) {
    state = state.copyWith(currentLocale: locale);
    AppSettingsStorage.instance.getData.then((AppSettings value) {
      AppSettingsStorage.instance.save(value.copyWith(currentLocale: locale));
    });
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsRepositoryNotifier, AppSettings>((ref) {
  return AppSettingsRepositoryNotifier();
});
