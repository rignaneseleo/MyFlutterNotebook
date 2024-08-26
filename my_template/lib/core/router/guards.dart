/*
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onda/core/logging/log.dart';
import 'package:onda/features/auth/photographer/providers/auth_photographer_provider.dart';
import 'package:onda/features/auth/user/providers/auth_user_provider.dart';

import '../../features/auth/photographer/models/photographer.dart';
import 'app_router.gr.dart';

class PhAuthGuard extends AutoRouteGuard {
  final ProviderRef ref;

  PhAuthGuard(this.ref);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    Log.generic("PhAuthGuard...");

    //load the first data of the async provider
    await ref.read(authPhotographerNotifierProvider.future);

    final ph = ref.read(authPhotographerNotifierProvider).valueOrNull;
    if (ph != null) {
      if ([
        PhotographerStatus.pending,
        PhotographerStatus.blocked,
      ].contains(ph.status)) {
        await ref.read(authPhotographerNotifierProvider.notifier).logout();
        return resolver.next(false);
      }

      //proceed
      resolver.next(true);
    } else {
      //pause the navigation and redirect to login, then eventually resume
      await resolver.redirect(PhLoginRoute(
        onResult: (success) {
          resolver.next(success);
        },
      ));
    }
    return;
  }
}

class BuyerAuthGuard extends AutoRouteGuard {
  final ProviderRef ref;

  BuyerAuthGuard(this.ref);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    //load the first data of the async provider
    await ref.read(authUserNotifierProvider.future);

    final user = ref.read(authUserNotifierProvider).valueOrNull;
    if (user != null) {
      //proceed
      resolver.next(true);
    } else {
      resolver.redirect(const SearchRoute());
    }
  }
}
*/
