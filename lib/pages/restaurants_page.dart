import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_workflow/AppColor/AppColors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/menu/menu_bloc.dart';
import '../../blocs/restaurant/restaurant_bloc.dart';
import '../custom_widgets/auto_scroll_image_slider.dart';
import 'menu_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurants",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColors.textColorWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantLoaded) {
            final sliderImages = [
              'https://img.freepik.com/premium-photo/two-burgers-dark-background_115919-24497.jpg',
              'https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/veggie-supreme.4bbddf98eccea9929192db1494ba3678.1.jpg',
              'https://media.istockphoto.com/id/1354366250/photo/set-of-rainbow-uramaki-sushi-rolls-with-avocado.jpg?s=612x612&w=0&k=20&c=wgFUfdRVdtW976mlii4zK_Ziy7rqEcXWPHjGZ8dO5A0=',
            ];
            return Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Support local, eat fresh, enjoy fast!, End your cravings",
                    style: GoogleFonts.roboto(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Slider at the top
                AutoScrollingImageSlider(imageUrls: sliderImages, height: 180),
                const SizedBox(height: 12),
                // ListView for restaurants
                Expanded(
                  child: ListView.builder(
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.restaurants[index];
                      return Card(
                        elevation: 6,
                        shadowColor: AppColors.restaurantCardGreenShadowColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          splashColor: AppColors.cardSplashColorColor,
                          onTap: () {
                            context.read<MenuBloc>().add(
                              FetchMenu(restaurant.id),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    MenuPage(restaurant: restaurant),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    restaurant.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors
                                                    .circularBarColorBlack,
                                              ),
                                            ),
                                          );
                                        },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 50,
                                        height: 50,
                                        color: AppColors
                                            .errorContainerBackGroundColor,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: AppColors.errorIconColor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurant.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        restaurant.description,
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        restaurant.address,
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, size: 35),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is RestaurantError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
