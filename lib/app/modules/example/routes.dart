import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import './screens/example_screen.dart';

List<RouteBase> routes([
  GlobalKey<NavigatorState>? rootNavKey,
  FutureOr<String?> Function(BuildContext, GoRouterState)? redirect,
]) =>
    [
      GoRoute(
        parentNavigatorKey: rootNavKey,
        path: '/',
        builder: (context, state) => const ExampleScreen(),
        redirect: redirect,
      ),
    ];
