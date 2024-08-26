import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../log.dart';

class BugFenderRouteObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final routeSettings = route.settings;
    Log.info(">> PUSH: ${routeSettings.name ?? 'Unknown'}");
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final routeSettings = newRoute?.settings;
    Log.info(">> REPLACE: ${routeSettings?.name ?? 'Unknown'}");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final routeSettings = previousRoute?.settings;
    Log.info(">> POP: ${routeSettings?.name ?? 'Unknown'}");
  }
}
