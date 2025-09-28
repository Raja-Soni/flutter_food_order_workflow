import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/menu_item.dart';
import '../AppColor/AppColors.dart';

class ItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback? onAdd;

  const ItemCard({super.key, required this.item, this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.itemsCardGreenShadowColor,
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: AppColors.itemCardContainerGradientColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Image.network(
                  item.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // image loaded
                    }
                    return Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColors.circularBarColorBlack,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: AppColors.errorContainerBackGroundColor,
                      child: Icon(
                        Icons.image_not_supported,
                        color: AppColors.errorIconColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "₹ ${item.price.toStringAsFixed(1)}",
                          style: TextStyle(
                            color: AppColors.rupeesStringColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: AppColors.subTitleTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: AppColors.boxShadowColorBlack,
                    ),
                    BoxShadow(
                      blurRadius: 10,
                      color: AppColors.boxShadowColorGreen,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Material(
                  color: AppColors.materialWidgetColorWhite,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    splashColor: AppColors.greenSplashColor,
                    onTap: onAdd,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.addIconColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
