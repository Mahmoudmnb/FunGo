import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../places/models/sales_places_model.dart';

class OfferCard extends StatelessWidget {
  final SalesPlacesModel sales;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final bool isFavorite;

  const OfferCard({
    super.key,
    required this.sales,
    required this.onTap,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        // onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with discount badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    sales.image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ),

                // Discount badge
                // Positioned(
                //   top: 12,
                //   left: 12,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 12,
                //       vertical: 6,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.red.shade600,
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.2),
                //           blurRadius: 4,
                //           offset: const Offset(0, 2),
                //         ),
                //       ],
                //     ),
                //     child: Text(
                //       '${offer.discountPercentage}% خصم',
                //       style: GoogleFonts.cairo(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),

                // Favorite button
                // Positioned(
                //   top: 12,
                //   right: 12,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.9),
                //       shape: BoxShape.circle,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.1),
                //           blurRadius: 4,
                //           offset: const Offset(0, 2),
                //         ),
                //       ],
                //     ),
                //     child: IconButton(
                //       icon: Icon(
                //         isFavorite ? Icons.favorite : Icons.favorite_border,
                //         color: isFavorite ? Colors.red : Colors.grey.shade600,
                //         size: 24,
                //       ),
                //       onPressed: onFavorite,
                //       constraints: const BoxConstraints(
                //         minWidth: 40,
                //         minHeight: 40,
                //       ),
                //     ),
                //   ),
                // ),

                // Offer type badge
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade600,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      sales.title!,
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title and location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              sales.title!,
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                              textAlign: TextAlign.end,
                              textDirection: TextDirection.rtl,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.teal.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  sales.placeName!,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    sales.body!,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // Pricing section
                  Row(
                    children: [
                      // Original price (crossed out)
                      // Text(
                      //   '${offer.originalPrice.toStringAsFixed(0)} ل.س',
                      //   style: GoogleFonts.cairo(
                      //     fontSize: 16,
                      //     color: Colors.grey.shade500,
                      //     decoration: TextDecoration.lineThrough,
                      //   ),
                      // ),

                      // const SizedBox(width: 12),

                      // // Discounted price
                      // Text(
                      //   '${offer.discountedPrice.toStringAsFixed(0)} ل.س',
                      //   style: GoogleFonts.cairo(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.red.shade600,
                      //   ),
                      // ),

                      const Spacer(),

                      // Validity period
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          // _getValidityText(),
                          sales.remainingdays!,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: onTap,
                      child: Text(
                        'اظهار التفاصيل',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getValidityText(DateTime validUntil) {
    final now = DateTime.now();
    final difference = validUntil.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم متبقي';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة متبقية';
    } else {
      return 'ينتهي قريباً';
    }
  }
}
