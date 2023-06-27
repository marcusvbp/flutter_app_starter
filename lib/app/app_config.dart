// ignore_for_file: public_member_api_docs, sort_constructors_first

class AppConfig {
  String? initialRoute = '/';
  Future<void> getCurrentUser = Future.value();

  factory AppConfig() {
    return _singleton;
  }
  AppConfig._internal();

  Future<AppLauncherData> initializer() async {
    // await AppSettingsStorage.instance.save(AppSettings());
    // String? localToken = await AuthStorage.instance.getData;

    // if (localToken != null && localToken.isNotEmpty) {
    //   log('O Auth Token existe!');
    //   initialRoute = null;
    //   final http = Dio(BaseOptions(
    //     baseUrl: apiUrl,
    //     headers: {'Authorization': 'Bearer $localToken'},
    //   ));

    //   Future<void> getUser() async {
    //     try {
    //       final res = await http.get(Api.currentUser.url);
    //       _currentUser = User.fromMap(res.data);
    //     } on DioException catch (e) {
    //       log('error: ${e.message}');
    //       // localToken = null;
    //     }
    //   }

    //   getCurrentUser = getUser();
    // } else {
    //   log('O Auth Token não existe!');
    // initialRoute = '/auth';
    // }

    return AppLauncherData(
      asyncDataFetchers: [getCurrentUser],
      initialRoute: initialRoute,
      // authToken: localToken,
    );
  }

  static AppConfig get instance => AppConfig();

  static final AppConfig _singleton = AppConfig._internal();

  // User? get currentUser => _currentUser;
}

class AppLauncherData {
  final String? initialRoute;
  final String? authToken;
  final List<Future> asyncDataFetchers;

  AppLauncherData({
    required this.asyncDataFetchers,
    this.initialRoute,
    this.authToken,
  });

  @override
  String toString() {
    return 'AppLauncherData(initialRoute: $initialRoute, authToken: $authToken, asyncDataFetchers: $asyncDataFetchers)';
  }
}
