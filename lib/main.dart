import 'dart:developer';

import 'package:appstarter/app/modules/auth/auth_storage.dart';
import 'package:appstarter/app/repositories/app_settings_repository.dart';
import 'package:appstarter/app/services/app_settings_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import 'app/modules/auth/repositories/auth_token_repository.dart';
import 'app/modules/example/routes.dart' as exampleroutes;
import 'app/screens/splash_screen.dart';
import 'app/theme/theme_data.dart';
// import 'app/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authData = await AuthStorage.instance.getData;
  final authSettings = await AppSettingsStorage.instance.getData;

  runApp(
    ProviderScope(
      overrides: [
        authProvider.overrideWith((ref) {
          final authNotifier = AuthTokenNotifier();
          authNotifier.save(authData);
          return authNotifier;
        }),
        appSettingsProvider.overrideWith((ref) {
          final appSettings = AppSettingsRepositoryNotifier();

          appSettings.rehydrate(authSettings);

          return appSettings;
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _rootNavigationKey = GlobalKey<NavigatorState>();
  // final _shellKey = GlobalKey<NavigatorState>();
  late String? token = ref.watch(authProvider);
  late RouterConfig<Object> routerConfig;
  late Future<void> _cachedFuture;

  Future<bool> checkIfAuthTokenExistsAndItsValid(
    GoRouterState state,
  ) async {
    // AuthData? localToken = await AuthStorage.instance.getData;

    // final now = DateTime.now().millisecondsSinceEpoch;
    // if (localToken == null) return false;
    // if (now < localToken.expiresIn) {
    //   final duration = Duration(milliseconds: localToken.expiresIn - now);
    //   log('O Token existe e ainda é válido (${duration.inHours}h ${duration.inMinutes.remainder(60)}m ${duration.inSeconds.remainder(60)}s)');
    //   return true;
    // }

    // log('o token expirou!');
    // return false;
    return true;
  }

  Future<String?> guardRoute(BuildContext context, GoRouterState state) async {
    // final permissionControl = ref.read(permissionControlProvider);
    // final userRepo = ref.read(userRepositoryProvider);

    Map<String, String> params = {};
    if (state.path != null) {
      params['redirect'] = state.uri.toString();
    }
    // state.fullPath
    Uri authUri = Uri(path: '/auth', queryParameters: params);

    bool result = await checkIfAuthTokenExistsAndItsValid(state);

    if (!result
        // || userRepo.currentUser == null
        ) {
      return authUri.toString();
    }

    if (state.fullPath != null
        // && !permissionControl.checkPathPermission(state.fullPath!)
        ) {
      return '/403';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    Future<void> futures() async {
      try {
        // final userService = ref.read(userServiceProvider);
        // final userRepo = ref.read(userRepositoryProvider.notifier);
        // final user = await userService.getCurrentUser();
        // userRepo.setCurrentUser(user);
      } on Exception catch (_) {
        log('não foi possível obter os dados do usuário atual na inicialização');
      }
    }

    _cachedFuture = futures();
    routerConfig = setRouter('/');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  setRouter([String? initialRoute]) {
    // initialRoute = '/example';

    return GoRouter(
      initialLocation: initialRoute,
      navigatorKey: _rootNavigationKey,
      routes: [
        ...exampleroutes.routes(),
        // ...authroutes.routes(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = [
      'lib/app/i18n',
    ];

    return FutureBuilder(
        future: _cachedFuture,
        builder: (context, snap) {
          return MaterialApp.router(
            supportedLocales: const [
              Locale('pt', 'BR'),
              Locale('es', 'ES'),
              Locale('de', 'DE'),
              Locale('fr', 'FR'),
              Locale('en', 'US'),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (supportedLocales.contains(locale)) {
                return locale;
              }

              if (locale?.languageCode == 'pt') {
                return const Locale('pt', 'BR');
              }

              if (locale?.languageCode == 'es') {
                return const Locale('es', 'ES');
              }

              if (locale?.languageCode == 'fr') {
                return const Locale('Fr', 'FR');
              }

              if (locale?.languageCode == 'de') {
                return const Locale('de', 'DE');
              }

              if (locale?.languageCode == 'en') {
                return const Locale('en', 'US');
              }

              return const Locale('pt', 'BR');
            },
            localizationsDelegates: [
              // FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              LocalJsonLocalization.delegate,
            ],
            title: 'SARPAS Mobile',
            debugShowCheckedModeBanner: false,
            routerConfig: routerConfig,
            theme: appThemeData,
          );
        });
  }
}

class AppSplashScreen extends ConsumerWidget {
  const AppSplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);

    LocalJsonLocalization.delegate.directories = [
      'lib/app/i18n',
    ];

    return Builder(builder: (context) {
      return MaterialApp(
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('es', 'ES'),
          Locale('de', 'DE'),
          Locale('fr', 'FR'),
          Locale('en', 'US'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }

          if (locale?.languageCode == 'pt') {
            return const Locale('pt', 'BR');
          }

          if (locale?.languageCode == 'es') {
            return const Locale('es', 'ES');
          }

          if (locale?.languageCode == 'fr') {
            return const Locale('Fr', 'FR');
          }

          if (locale?.languageCode == 'de') {
            return const Locale('de', 'DE');
          }

          if (locale?.languageCode == 'en') {
            return const Locale('en', 'US');
          }

          return const Locale('pt', 'BR');
        },
        locale: appSettings.currentLocale,
        localizationsDelegates: [
          // FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          LocalJsonLocalization.delegate,
        ],
        home: const SplashScreen(),
      );
    });
  }
}
