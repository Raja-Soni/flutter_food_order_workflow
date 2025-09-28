import 'package:flutter/material.dart';
import 'package:food_order_workflow/models/address.dart';
import 'package:food_order_workflow/models/restaurant.dart';
import 'package:food_order_workflow/pages/all_pages.dart';
import 'package:food_order_workflow/routes/all_routes.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.restaurantsPage:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const RestaurantListPage(),
        );

      case RouteNames.menuPage:
        final restaurant = settings.arguments as Restaurant;
        return PageTransition(
          type: PageTransitionType.fade,
          child: MenuPage(restaurant: restaurant),
        );

      case RouteNames.checkoutPage:
        final restaurant = settings.arguments as Restaurant;
        final address = settings.arguments as Address;
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: CheckoutPage(restaurant: restaurant),
        );

      default:
        return null;
    }
  }
}
