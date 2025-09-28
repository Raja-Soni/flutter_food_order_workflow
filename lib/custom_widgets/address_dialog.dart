// lib/widgets/address_dialog.dart
import 'package:flutter/material.dart';
import 'package:food_order_workflow/AppColor/AppColors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_widgets/custom_form_text_field.dart';
import '../models/address.dart';

Future<Address?> showAddressDialog({
  required BuildContext context,
  Address? existingAddress,
}) {
  final streetController = TextEditingController(
    text: existingAddress?.street ?? "",
  );
  final cityController = TextEditingController(
    text: existingAddress?.city ?? "",
  );
  final stateController = TextEditingController(
    text: existingAddress?.state ?? "",
  );
  final zipController = TextEditingController(
    text: existingAddress?.zipCode ?? "",
  );
  final addressFormKey = GlobalKey<FormState>();

  final screenWidth = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final isSmallScreen = screenWidth < 600;

  return showDialog<Address>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(
            existingAddress != null
                ? "Change Delivery Address"
                : "Enter Delivery Address",
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
        ),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isSmallScreen ? screenWidth : 400,
            maxHeight: height * 0.6,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: addressFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFormTextField(
                    textEditingController: streetController,
                    inputType: TextInputType.text,
                    hintText: "Street / House No.",
                    icon: const Icon(Icons.home_outlined),
                    autoFocus: true,
                    validate: (value) => (value == null || value.isEmpty)
                        ? "Please enter your street"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    textEditingController: cityController,
                    inputType: TextInputType.text,
                    hintText: "City",
                    icon: const Icon(Icons.location_city_outlined),
                    validate: (value) => (value == null || value.isEmpty)
                        ? "Please enter your city"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    textEditingController: stateController,
                    inputType: TextInputType.text,
                    hintText: "State",
                    icon: const Icon(Icons.map_outlined),
                    validate: (value) => (value == null || value.isEmpty)
                        ? "Please enter your state"
                        : null,
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    textEditingController: zipController,
                    inputType: TextInputType.number,
                    hintText: "ZIP Code",
                    icon: const Icon(Icons.pin_outlined),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your area's ZIP code";
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Only numbers allowed";
                      }
                      if (value.length != 6) {
                        return "ZIP Code must be 6 digits";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.saveAddressButtonColor,
                          ),
                          onPressed: () {
                            if (addressFormKey.currentState!.validate()) {
                              final address = Address(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                street: streetController.text,
                                city: cityController.text,
                                state: stateController.text,
                                zipCode: zipController.text,
                              );
                              Navigator.pop(context, address);
                            }
                          },
                          child: Text(
                            "Save Address",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColorWhite,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cancelButtonColor,
                          ),
                          onPressed: () => Navigator.pop(context, null),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColorWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
