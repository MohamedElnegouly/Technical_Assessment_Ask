import 'package:go_router/go_router.dart';
import 'package:technical_assessment_task/core/utils/app_routers_strings.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/login_screen.dart';
import 'package:technical_assessment_task/features/Authentication/presentation/screen/register_screen.dart';
import 'package:technical_assessment_task/features/Home/presentation/screens/home.dart';


class AppRouters {
  static final router = GoRouter(
    initialLocation: AppRoutersStrings.login,
    routes: [
      GoRoute(
        path: AppRoutersStrings.login,
        builder: (context, state) => const LoginScreen(),
      ),

      /// 🔹 Register Screen
      GoRoute(
        path: AppRoutersStrings.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
            path: AppRoutersStrings.home,
            builder: (context, state) => const Home(),
          ),

      /// 🧭 ShellRoute → يحتوي على Navigation Bar + Home Cubits
      // ShellRoute(
      //   builder: (context, state, child) {
      //     return MultiBlocProvider(
      //       providers: [
      //         BlocProvider(
      //           create: (context) =>
      //               CategoryCubit(getIt.get<HomeRepo>())..getCategory(),
      //         ),
      //         BlocProvider(
      //           create: (context) =>
      //               AllProductsCubit(getIt.get<HomeRepo>())..getProducts(),
      //         ),
      //         BlocProvider(
      //           create: (context) =>
      //               CategoryScreenCubit(getIt.get<CategoriesRepo>())
      //                 ..getCategory(),
      //         ),
      //         BlocProvider(
      //           create: (context) =>
      //               MenProductCubit(getIt.get<HomeRepo>())..getProducts(),
      //         ),
      //         BlocProvider(
      //           create: (context) =>
      //               ElectronicsProductCubit(getIt.get<HomeRepo>())
      //                 ..getProducts(),
      //         ),
      //         BlocProvider(create: (context) => FavoriteScreenCubit()),
             
      //       ],
      //       child: Scaffold(
      //         body: child,
      //         bottomNavigationBar: const CustomNavigationBar(),
      //       ),
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: AppRoutersStrings.home,
      //       builder: (context, state) => const HomeBody(),
      //     ),
      //     GoRoute(
      //       path: AppRoutersStrings.categories,
      //       builder: (context, state) {
      //         final categoryId = state.uri.queryParameters['categoryId'];
      //         return BlocProvider(
      //           create: (_) => getIt<CategoryScreenCubit>(),
      //           child: CategoriesScreen(initialCategoryId: categoryId),
      //         );
      //       },
      //     ),
      //     GoRoute(
      //       path: AppRoutersStrings.favoriteScreen,
      //       builder: (context, state) => const FavoriteScreen(),
      //     ),
      //     GoRoute(
      //       path: AppRoutersStrings.profile,
      //       builder: (context, state) => const ProfileScreen(),
      //     ),
      //   ],
      // ),
    ],
  );
}
