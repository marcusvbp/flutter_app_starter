import 'dart:convert';
import 'dart:ui';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppSettings {
  final Locale currentLocale;

  AppSettings({
    this.currentLocale = const Locale('pt', 'BR'),
  });

  AppSettings copyWith({
    Locale? currentLocale,
  }) {
    return AppSettings(
      currentLocale: currentLocale ?? this.currentLocale,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentLocale': {
        'languageCode': currentLocale.languageCode,
        'countryCode': currentLocale.countryCode,
      },
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      currentLocale: Locale(
        map['currentLocale']['languageCode'],
        map['currentLocale']['countryCode'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettings.fromJson(String source) =>
      AppSettings.fromMap(json.decode(source) as Map<String, dynamic>);
}
