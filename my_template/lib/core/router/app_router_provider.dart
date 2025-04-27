import 'package:my_template/core/router/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router_provider.g.dart';

@Riverpod(keepAlive: true)
AppRouter appRouter(AppRouterRef ref) => AppRouter();
