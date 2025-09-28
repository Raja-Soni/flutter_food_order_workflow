import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/address/address_bloc.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_event.dart';
import '../../blocs/cart/cart_state.dart';
import '../../blocs/menu/menu_bloc.dart';
import '../../models/restaurant.dart';
import '../AppColor/AppColors.dart';
import '../blocs/address/address_event.dart';
import '../blocs/address/address_state.dart';
import '../custom_widgets/import_all_custom_widgets.dart';
import '../models/address.dart';
import 'checkout_page.dart';

class MenuPage extends StatelessWidget {
  final Restaurant restaurant;

  const MenuPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    context.read<MenuBloc>().add(FetchMenu(restaurant.id));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name,
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColors.textColorWhite,
          ),
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<MenuBloc, MenuState>(
            builder: (context, state) {
              if (state is MenuLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MenuError) {
                return Center(child: Text(state.message));
              }
              if (state is MenuLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 250),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return ItemCard(
                      item: item,
                      onAdd: () {
                        final cartBloc = context.read<CartBloc>();
                        final currentRestaurantId = cartBloc.state.restaurantId;
                        if (currentRestaurantId != null &&
                            currentRestaurantId != item.restaurantId) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(
                                "Clear Cart?",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              content: Text(
                                "Clear cart and add items from this restaurant?",
                                style: TextStyle(
                                  color: AppColors.textColorBlack,
                                  fontSize: 18,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textButtonColor,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.removeButtonColor,
                                  ),
                                  onPressed: () {
                                    cartBloc.add(ClearCart());
                                    cartBloc.add(AddItem(item));
                                    Navigator.pop(ctx);
                                  },
                                  child: Text(
                                    "Clear Cart",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textColorWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          cartBloc.add(AddItem(item));
                        }
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState.items.isEmpty) return const SizedBox.shrink();
              return BlocBuilder<AddressBloc, AddressState>(
                builder: (context, addressState) {
                  final sheetController = DraggableScrollableController();
                  final addressSelected = addressState is AddressSelected;
                  return DraggableScrollableSheet(
                    controller: sheetController,
                    initialChildSize: 0.30,
                    minChildSize: 0.25,
                    maxChildSize: 0.5,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.boxBackGroundColorGrey,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: AppColors.boxShadowColorBlack,
                              offset: Offset(0, -2),
                            ),
                          ],
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onVerticalDragUpdate: (details) {
                                double newSize =
                                    sheetController.size -
                                    details.delta.dy /
                                        MediaQuery.of(context).size.height;
                                newSize = newSize.clamp(0.25, 0.5);
                                sheetController.jumpTo(newSize);
                              },
                              child: Icon(
                                Icons.drag_handle_rounded,
                                size: 50,
                                color: AppColors.dragIconColor,
                              ),
                            ),

                            Text(
                              "Your Cart",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColorBlack,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: AppColors.boxBackGroundColorGrey,
                                child: ListView.builder(
                                  controller: scrollController,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: cartState.items.length,
                                  itemBuilder: (context, index) {
                                    final cartItem = cartState.items[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.boxBackGroundColorWhite,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                AppColors.boxShadowColorBlack,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Row(
                                          children: [
                                            // Item Image
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                    child: SizedBox(
                                                      width: 400,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        child: Image.network(
                                                          cartItem
                                                              .item
                                                              .imageUrl,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  cartItem.item.imageUrl,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cartItem.item.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    "₹${cartItem.item.price.toStringAsFixed(1)} per piece",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .subTitleTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Quantity Selector
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                  color: AppColors
                                                      .quantityContainerBorderColor,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Row(
                                                  children: [
                                                    Material(
                                                      color:
                                                          AppColors.transparent,
                                                      child: InkWell(
                                                        splashColor: AppColors
                                                            .redSplashColor,
                                                        onTap: () {
                                                          final newQty =
                                                              cartItem
                                                                  .quantity -
                                                              1;
                                                          if (newQty <= 0) {
                                                            context
                                                                .read<
                                                                  CartBloc
                                                                >()
                                                                .add(
                                                                  RemoveItem(
                                                                    cartItem
                                                                        .item
                                                                        .id,
                                                                  ),
                                                                );
                                                          } else {
                                                            context
                                                                .read<
                                                                  CartBloc
                                                                >()
                                                                .add(
                                                                  ChangeQuantity(
                                                                    cartItem
                                                                        .item
                                                                        .id,
                                                                    newQty,
                                                                  ),
                                                                );
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .removeButtonColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                          ),
                                                      child: Text(
                                                        "${cartItem.quantity}",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Material(
                                                      color:
                                                          AppColors.transparent,
                                                      child: InkWell(
                                                        splashColor: AppColors
                                                            .greenSplashColor,
                                                        onTap: () {
                                                          context
                                                              .read<CartBloc>()
                                                              .add(
                                                                ChangeQuantity(
                                                                  cartItem
                                                                      .item
                                                                      .id,
                                                                  cartItem.quantity +
                                                                      1,
                                                                ),
                                                              );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .addButtonColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            const SizedBox(width: 12),

                                            // Total Price per item
                                            Text(
                                              "₹${(cartItem.item.price * cartItem.quantity).toStringAsFixed(1)}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Address / Checkout buttons
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.changeAddressButtonColor,
                                      ),
                                      onPressed: () async {
                                        final Address? result =
                                            await showAddressDialog(
                                              context: context,
                                              existingAddress: addressSelected
                                                  ? addressState.address
                                                  : null,
                                            );

                                        if (result != null) {
                                          context.read<AddressBloc>().add(
                                            SelectAddress(result),
                                          );
                                        }
                                      },
                                      child: Text(
                                        addressSelected
                                            ? "Change Address"
                                            : "Add Address",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (addressSelected)
                                    const SizedBox(width: 12),
                                  if (addressSelected)
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.checkOutButtonColor,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => CheckoutPage(
                                                restaurant: restaurant,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Checkout: ₹${cartState.total.toStringAsFixed(1)}",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textColorWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
