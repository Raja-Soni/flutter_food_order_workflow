import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order_workflow/AppColor/AppColors.dart';
import 'package:food_order_workflow/models/address.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/address/address_bloc.dart';
import '../blocs/address/address_event.dart';
import '../blocs/address/address_state.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../blocs/cart/cart_state.dart';
import '../custom_widgets/address_dialog.dart';
import '../models/restaurant.dart';
import '../routes/route_names.dart';

class CheckoutPage extends StatelessWidget {
  final Restaurant restaurant;

  const CheckoutPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColors.textColorWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState.items.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Your cart is empty",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: AppColors.addMoreItemButtonColor,
                        size: 30,
                      ),
                      Text(
                        "Add more items",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.addMoreItemButtonColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: AppColors
                            .restaurantNameCheckoutContainerGradientColor,
                      ),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          restaurant.imageUrl,
                          width: 60,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        restaurant.name,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        "Restaurant Name",
                        style: GoogleFonts.openSans(fontSize: 14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Address Card
                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, addressState) {
                    Address? currentAddress;
                    if (addressState is AddressSelected) {
                      currentAddress = addressState.address;
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors:
                                AppColors.addressCheckoutContainerGradientColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery Address:",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColorBlack,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    if (currentAddress != null)
                                      Text(
                                        "${currentAddress.street}, "
                                        "${currentAddress.city}, "
                                        "${currentAddress.state} - "
                                        "${currentAddress.zipCode}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: AppColors.textColorBlack,
                                        ),
                                      )
                                    else
                                      Text(
                                        "No address selected",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: AppColors.subTitleTextColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final Address? result =
                                      await showAddressDialog(
                                        context: context,
                                        existingAddress: currentAddress,
                                      );

                                  if (result != null && context.mounted) {
                                    context.read<AddressBloc>().add(
                                      SelectAddress(result),
                                    );
                                  }
                                },
                                child: Text(
                                  "Change",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textButtonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Order Summary Card
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.checkOutOrderItemContainerColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Your Order",
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textColorBlack,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color:
                                              AppColors.addMoreItemButtonColor,
                                        ),
                                        Text(
                                          "Add more items",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors
                                                .addMoreItemButtonColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Divider(),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: AppColors
                                        .checkOutOrderListContainerGradientColor,
                                  ),
                                ),
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount: cartState.items.length,
                                  itemBuilder: (context, index) {
                                    final cartItem = cartState.items[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.boxBackGroundColorWhite,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
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
                                                        cartItem.item.imageUrl,
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
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartItem.item.name,
                                                  style: GoogleFonts.nunito(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "₹${cartItem.item.price.toStringAsFixed(1)} per piece",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Quantity selector
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
                                                            cartItem.quantity -
                                                            1;
                                                        if (newQty <= 0) {
                                                          context
                                                              .read<CartBloc>()
                                                              .add(
                                                                RemoveItem(
                                                                  cartItem
                                                                      .item
                                                                      .id,
                                                                ),
                                                              );
                                                        } else {
                                                          context
                                                              .read<CartBloc>()
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
                                                        padding: EdgeInsets.all(
                                                          6,
                                                        ),
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
                                                        padding: EdgeInsets.all(
                                                          6,
                                                        ),
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
                                          Text(
                                            "₹${(cartItem.item.price * cartItem.quantity).toStringAsFixed(1)}",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Place Order Button in Card
                Card(
                  color: AppColors.placeOrderButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      final List<String> paymentMethods = [
                        'COD',
                        'UPI',
                        'Card',
                      ];
                      String? selectedPaymentMethod;
                      selectedPaymentMethod = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          String? tempSelected = 'COD';
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text(
                                  'Select Payment Method',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: paymentMethods.map((method) {
                                    return RadioListTile<String>(
                                      activeColor: Colors.green,
                                      title: Text(method),
                                      value: method,
                                      groupValue: tempSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          tempSelected = value!;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, null),
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.cancelButtonColor,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.addButtonColor,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, tempSelected),
                                    child: Text(
                                      'Confirm',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColorWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );

                      if (selectedPaymentMethod != null) {
                        // Now place the order
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 600),
                                backgroundColor: Colors.green,
                                content: Row(
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Order placed successfully via $selectedPaymentMethod!",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .closed
                            .then((_) {
                              if (!context.mounted) return;
                              context.read<CartBloc>().add(ClearCart());
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.restaurantsPage,
                                (route) => false,
                              );
                            });
                      }
                    },
                    // onTap: () {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(
                    //         SnackBar(
                    //           duration: const Duration(milliseconds: 600),
                    //           backgroundColor: Colors.green,
                    //           content: Row(
                    //             children: [
                    //               const Icon(Icons.check, color: Colors.white),
                    //               const SizedBox(width: 8),
                    //               Text(
                    //                 "Order placed successfully!",
                    //                 style: GoogleFonts.montserrat(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: AppColors.textColorWhite,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //       .closed
                    //       .then((_) {
                    //         if (!context.mounted) return;
                    //         context.read<CartBloc>().add(ClearCart());
                    //         Navigator.pushNamedAndRemoveUntil(
                    //           context,
                    //           RouteNames.restaurantsPage,
                    //           (route) => false,
                    //         );
                    //       });
                    // },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Center(
                        child: Text(
                          "Place Order: ₹${cartState.total.toStringAsFixed(1)}",
                          style: GoogleFonts.montserrat(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColorWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
