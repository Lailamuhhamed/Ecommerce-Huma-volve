import 'package:go_router/go_router.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/details/screens/product_details_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final idStr = state.pathParameters['id'] ?? '0';
        final productId = int.tryParse(idStr) ?? 0;
        return ProductDetailsScreen(productId: productId);
      },
    ),
  ],
);