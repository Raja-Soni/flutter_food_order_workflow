import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_workflow/AppColor/AppColors.dart';
import 'package:food_order_workflow/blocs/address/address_bloc.dart';
import 'package:food_order_workflow/routes/all_routes.dart';

import 'blocs/cart/cart_bloc.dart';
import 'blocs/checkout/checkout_bloc.dart';
import 'blocs/menu/menu_bloc.dart';
import 'blocs/restaurant/restaurant_bloc.dart';
import 'repo/import_all_repos.dart';

void main() {
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantRepo = FakeRestaurantRepository();
    final orderRepo = FakeOrderRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              RestaurantBloc(repository: restaurantRepo)
                ..add(FetchRestaurants()),
        ),
        BlocProvider(create: (_) => MenuBloc(repository: restaurantRepo)),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => AddressBloc()),
        BlocProvider(create: (_) => CheckoutBloc(repository: orderRepo)),
      ],
      child: MaterialApp(
        title: 'Food Delivery Workflow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.primarySwatchColor,
          colorScheme: ColorScheme.light(
            surface: AppColors.surfaceColorScheme,
            onSurface: AppColors.onSurfaceColorScheme,
          ),
          scaffoldBackgroundColor: AppColors.scaffoldBackGroundColor,
          appBarTheme: AppBarTheme(
            surfaceTintColor: AppColors.transparent,
            backgroundColor: AppColors.appBarBackGroundColor,
            foregroundColor: AppColors.appBarForeGroundColor,
          ),
        ),
        initialRoute: RouteNames.restaurantsPage,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RestaurantError) {
            return Center(child: Text(state.message));
          }
          if (state is RestaurantLoaded) {
            Navigator.pushNamed(context, RouteNames.restaurantsPage);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
