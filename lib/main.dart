import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/app_config.dart';
import 'app/modules/auth/repositories/auth_token_repository.dart';
import 'app/modules/example/routes.dart' as exampleroutes;
import 'app/screens/splash_screen.dart';
import 'app/theme/theme_data.dart';
// import 'app/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
    home: SplashScreen(),
  ));

  final appInitializer = await AppConfig.instance.initializer();

  await Future.wait([
    Future.delayed(const Duration(seconds: 1)),
    ...appInitializer.asyncDataFetchers,
  ]);
  runApp(
    ProviderScope(
      overrides: [
        authProvider.overrideWith((ref) {
          final authNotifier = AuthTokenNotifier();
          authNotifier.save(appInitializer.authToken);

          return authNotifier;
        }),
      ],
      child: MyApp(launcherData: appInitializer),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final AppLauncherData? launcherData;
  const MyApp({
    Key? key,
    required this.launcherData,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final _rootNavigationKey = GlobalKey<NavigatorState>();
  // final _shellKey = GlobalKey<NavigatorState>();
  late String? token = ref.watch(authProvider);
  late RouterConfig<Object> routerConfig;

  Future<String?> guardRoute(BuildContext context, GoRouterState state) async {
    // final token = ref.read(authProvider);
    // if (token == null) {
    //   return '/auth';
    // }
    return null;
  }

  @override
  void initState() {
    super.initState();
    routerConfig = setRouter(widget.launcherData?.initialRoute);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
    return MaterialApp.router(
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'App Starter',
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      theme: appThemeData,
    );
  }
}
