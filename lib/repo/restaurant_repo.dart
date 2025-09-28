import '../models/menu_item.dart';
import '../models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> fetchRestaurants();
  Future<List<MenuItem>> fetchMenuForRestaurant(String restaurantId);
}
