import '../models/menu_item.dart';
import '../models/restaurant.dart';
import 'restaurant_repo.dart';

class FakeRestaurantRepository implements RestaurantRepository {
  @override
  Future<List<Restaurant>> fetchRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      Restaurant(
        id: 'r1',
        name: 'Pizza Palace',
        description: 'Best pizzas in town with fresh ingredients',
        address: '123 Downtown Street',
        imageUrl:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8fDA%3D',
      ),
      Restaurant(
        id: 'r2',
        name: 'Burger Hub',
        description: 'Juicy burgers and crispy fries',
        address: '456 Main Street',
        imageUrl:
            'https://img.freepik.com/premium-photo/two-burgers-dark-background_115919-24497.jpg',
      ),
      Restaurant(
        id: 'r3',
        name: 'Sushi World',
        description: 'Fresh sushi made daily',
        address: '789 Ocean Avenue',
        imageUrl:
            'https://images.unsplash.com/photo-1611143669185-af224c5e3252?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c3VzaGl8ZW58MHx8MHx8fDA%3D',
      ),
    ];
  }

  @override
  Future<List<MenuItem>> fetchMenuForRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (restaurantId == 'r1') {
      // Pizza Palace menu
      return [
        MenuItem(
          id: 'p1',
          name: 'Cheese Pizza',
          description: 'Delicious cheese pizza',
          price: 50.00,
          imageUrl:
              'https://img.freepik.com/free-psd/delicious-slice-pepperoni-pizza_191095-85600.jpg',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p2',
          name: 'Chicken Pizza',
          description: 'Non-veg. Chicken Pizza',
          price: 70.0,
          imageUrl:
              'https://t4.ftcdn.net/jpg/14/77/97/95/360_F_1477979597_TeBUou9rFOOVxDprMjGaCeaNMrGLmGbc.jpg',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p3',
          name: 'Margherita Pizza',
          description:
              'Classic pizza topped with fresh tomatoes, mozzarella, and basil.',
          price: 400.0,
          imageUrl:
              'https://media.istockphoto.com/id/467496365/photo/slice-of-cheese-pizza-close-up-isolated.jpg?s=612x612&w=0&k=20&c=4HEjgG0LzfgosSXASrskcgQrWKkcP9iuQLSZ7tPYnmU=',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p4',
          name: 'Pepperoni Pizza',
          description: 'Spicy pepperoni slices on a cheesy base.',
          price: 450.0,
          imageUrl:
              'https://t3.ftcdn.net/jpg/06/27/81/36/360_F_627813626_bjLLoQXww5AlKs1giaxRW8H7g2woTqll.jpg',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p5',
          name: 'BBQ Chicken Pizza',
          description: 'BBQ Chicken Pizza.',
          price: 500.0,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTy9e__2azdh3yZESDJC6esW2VFI8vWAy14jA&s',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p6',
          name: 'Veggie Supreme Pizza',
          description:
              'Loaded with bell peppers, olives, onions, and mushrooms.',
          price: 480.0,
          imageUrl:
              'https://img.freepik.com/premium-photo/vegetarian-pizza-with-slice-mushroom-3d-isolated-white-background-centered-composition_987339-18.jpg',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'p7',
          name: 'Garlic Breadsticks',
          description: 'Soft breadsticks brushed with garlic butter.',
          price: 150.0,
          imageUrl:
              'https://media.istockphoto.com/id/1196410984/photo/garlic-breadsticks.jpg?s=612x612&w=0&k=20&c=TUV2QRtjgkKB9ZpRqQ-TBHbCRwoL1MXOYg0Xx7AXtVs=',
          restaurantId: restaurantId,
        ),
      ];
    } else if (restaurantId == 'r2') {
      // Burger Hub menu
      return [
        MenuItem(
          id: 'b1',
          name: 'Veggie Burger',
          description: 'Healthy veggie burger',
          price: 70.0,
          imageUrl: "https://pngimg.com/d/burger_sandwich_PNG96781.png",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b2',
          name: 'Classic Cheese Burger',
          description: 'Goat patty with cheddar cheese, lettuce, and tomato.',
          price: 350.0,
          imageUrl:
              "https://www.unileverfoodsolutions.com.sg/dam/global-ufs/mcos/SEA/calcmenu/recipes/SG-recipes/vegetables-&-vegetable-dishes/%E7%BB%8F%E5%85%B8%E8%8A%9D%E5%A3%AB%E6%B1%89%E5%A0%A1/main-header.jpg",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b3',
          name: 'Non-Veg. Burger',
          description: 'Full of protein non-veg burger',
          price: 70.0,
          imageUrl:
              "https://img.freepik.com/premium-psd/fresh-beef-burger-isolated-transparent-background_191095-9018.jpg",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b4',
          name: 'Mushroom Melt Burger',
          description:
              'Chicken patty topped with sautéed mushrooms and Swiss cheese.',
          price: 400.0,
          imageUrl:
              "https://media.istockphoto.com/id/539659420/photo/mushroom-swiss-burger.jpg?s=612x612&w=0&k=20&c=jMNa1F6VJmUGvDafmgumvBqtWvFhyIPdgmvcxGKHWiM=",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b5',
          name: 'BBQ Chicken  Burger',
          description: 'Chicken patty with crispy bacon and BBQ sauce',
          price: 450.0,
          imageUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVIRgpwRSeV1y0lr8tAPwi3jwkCjEqmvsjYA&s",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b6',
          name: 'Loaded Fries',
          description: 'Fries topped with cheese, bacon, and ranch.',
          price: 200.0,
          imageUrl: "https://i.ytimg.com/vi/C0b6oUkqujk/sddefault.jpg",
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 'b7',
          name: 'Chicken Tender Basket',
          description: 'Full of protein non-veg burger',
          price: 300.0,
          imageUrl:
              "https://as2.ftcdn.net/jpg/06/16/27/95/1000_F_616279555_qlCC1elLK1xlJyqv7dBPdMCxre6ieFNo.jpg",
          restaurantId: restaurantId,
        ),
      ];
    } else if (restaurantId == 'r3') {
      // Sushi World menu
      return [
        MenuItem(
          id: 's1',
          name: 'Salmon Sushi',
          description: 'Fresh salmon sushi',
          price: 300.0,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKGQKoRik9LshZ2gx5CBuAj0xYCoweQoJ5mg&s',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 's2',
          name: 'Tuna Roll',
          description: 'Delicious tuna roll',
          price: 250.0,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsYfsQU9Uy-_nPtoPqQwrDFmJyaL65y3ta4g&s',
          restaurantId: restaurantId,
        ),
        MenuItem(
          id: 's3',
          name: 'Miso Soup',
          description: 'Traditional Japanese soup with tofu and seaweed.',
          price: 150.0,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQKXXG2tEg7nJuObT2xcwLg9jDw1NTKpQTYQ&s',
          restaurantId: restaurantId,
        ),
      ];
    } else {
      // default empty menu
      return [];
    }
  }
}
