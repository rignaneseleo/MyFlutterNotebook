import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_template/shared/providers/test_mode_provider.dart';

import 'core/logging/bugfender/route_observer.dart';
import 'core/router/app_router.dart';
import 'core/router/app_router_provider.dart';

// responsive layout: https://codelabs.developers.google.com/codelabs/flutter-animated-responsive-layout#5
// https://www.youtube.com/watch?v=LeKLGzpsz9I

class App extends ConsumerWidget {
  App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Leorigna Template',
      routerConfig: _appRouter.config(
        /*
        /// This will reevaluate the guards of the current page whenever the auth state changes
        reevaluateListenable: ReevaluateListenable.stream(
          ref.watch(firebaseAuthApiProvider).authStateChanges(),
        ),
        */
        navigatorObservers: () => [
          //bugfender observer
          BugFenderRouteObserver(),

          /*FirebaseAnalyticsObserver(
              analytics: FirebaseAnalytics.instance,
              nameExtractor: (RouteSettings pageSettings) {
                if (pageSettings.name != null) {
                  //print("Route name: ${settings.name}");
                  return pageSettings.name;
                }
                return "unknown";
              }),*/
        ],
      ),
      debugShowCheckedModeBanner: ref.watch(isTestModeProvider),
    );
  }
}
