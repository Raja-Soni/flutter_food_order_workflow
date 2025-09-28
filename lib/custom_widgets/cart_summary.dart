import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';

class CartSummary extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSummary({super.key, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final hasItems = cartState.items.isNotEmpty;

        return AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: hasItems ? Offset.zero : const Offset(0, 1),
          curve: Curves.easeInOut,
          child: Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Items: ${cartState.totalItems}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "Total: \$${cartState.total.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onCheckout,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
