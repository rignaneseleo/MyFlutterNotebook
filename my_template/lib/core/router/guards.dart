/* import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.gr.dart';

class PremiumGuard extends AutoRouteGuard {
  final ProviderRef ref;

  PremiumGuard(this.ref);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    // Example: Check if user has premium subscription
    final isPremium = await _checkPremiumStatus();

    if (isPremium) {
      // User has premium access, proceed with navigation
      resolver.next(true);
    } else {
      // Redirect to subscription page or show a dialog
      await resolver.redirect(HomeRoute(
        onResult: (success) {
          // Resume navigation only if subscription was successful
          resolver.next(success);
        },
      ));
    }
  }

  Future<bool> _checkPremiumStatus() async {
    // Implementation to check premium status
    // This would typically check a provider or make an API call
    return false; // Default to non-premium for example
  }
}
 */
