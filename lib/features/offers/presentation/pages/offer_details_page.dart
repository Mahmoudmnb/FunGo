import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../places/models/sales_places_model.dart';

class OfferDetailsPage extends StatelessWidget {
  final SalesPlacesModel sales;

  const OfferDetailsPage({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'تفاصيل العرض',
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Hero image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      sales.image!,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),

                  // Discount badge
                  // Positioned(
                  //   top: 20,
                  //   left: 20,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 16,
                  //       vertical: 8,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.red.shade600,
                  //       borderRadius: BorderRadius.circular(25),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.3),
                  //           blurRadius: 8,
                  //           offset: const Offset(0, 4),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Text(
                  //       '${offer.discountPercentage}% خصم',
                  //       style: GoogleFonts.cairo(
                  //         color: Colors.white,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Offer type badge
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade600,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        sales.title!,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title and location
                  Text(
                    sales.title!,
                    style: GoogleFonts.cairo(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Colors.teal.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sales.placeName!,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  Text(
                    'الوصف',
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    sales.body!,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Pricing section
                  // Container(
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(16),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.1),
                  //         blurRadius: 10,
                  //         offset: const Offset(0, 4),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Text(
                  //         'الأسعار',
                  //         style: GoogleFonts.cairo(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey.shade800,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 16),
                  //       const Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           // Column(
                  //           //   crossAxisAlignment: CrossAxisAlignment.start,
                  //           //   children: [
                  //           //     Text(
                  //           //       'السعر الأصلي',
                  //           //       style: GoogleFonts.cairo(
                  //           //         fontSize: 14,
                  //           //         color: Colors.grey.shade600,
                  //           //       ),
                  //           //     ),
                  //           //     const SizedBox(height: 4),
                  //           //     Text(
                  //           //       '${sales.originalPrice.toStringAsFixed(0)} ل.س',
                  //           //       style: GoogleFonts.cairo(
                  //           //         fontSize: 18,
                  //           //         color: Colors.grey.shade500,
                  //           //         decoration: TextDecoration.lineThrough,
                  //           //       ),
                  //           //     ),
                  //           //   ],
                  //           // ),
                  //           // Column(
                  //           //   crossAxisAlignment: CrossAxisAlignment.end,
                  //           //   children: [
                  //           //     Text(
                  //           //       'السعر بعد الخصم',
                  //           //       style: GoogleFonts.cairo(
                  //           //         fontSize: 14,
                  //           //         color: Colors.grey.shade600,
                  //           //       ),
                  //           //     ),
                  //           //     const SizedBox(height: 4),
                  //           //     Text(
                  //           //       '${sales.discountedPrice.toStringAsFixed(0)} ل.س',
                  //           //       style: GoogleFonts.cairo(
                  //           //         fontSize: 24,
                  //           //         fontWeight: FontWeight.bold,
                  //           //         color: Colors.red.shade600,
                  //           //       ),
                  //           //     ),
                  //           //   ],
                  //           // ),
                  //         ],
                  //       ),
                  //       const SizedBox(height: 16),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 16,
                  //           vertical: 8,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: Colors.green.shade100,
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: Text(
                  //           'وفرت ${(sales.originalPrice - sales.discountedPrice).toStringAsFixed(0)} ل.س',
                  //           style: GoogleFonts.cairo(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w600,
                  //             color: Colors.green.shade800,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 24),

                  // Validity section
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 24,
                          color: Colors.orange.shade600,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(
                              //   'صالح حتى',
                              //   style: GoogleFonts.cairo(
                              //     fontSize: 14,
                              //     color: Colors.grey.shade600,
                              //   ),
                              // ),
                              // const SizedBox(height: 4),
                              Text(
                                sales.remainingdays!,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Booking button
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 56,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.teal.shade600,
                  //       foregroundColor: Colors.white,
                  //       elevation: 0,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(16),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       // Show booking dialog
                  //       _showBookingDialog(context);
                  //     },
                  //     child: Text(
                  //       'احجز الآن',
                  //       style: GoogleFonts.cairo(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(height: 20),

                  // Contact info
                  Center(
                    child: Text(
                      'للمزيد من المعلومات: 0999-123-456',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.grey.shade600,
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

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تأكيد الحجز',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل تريد تأكيد حجز هذا العرض؟',
          style: GoogleFonts.cairo(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: GoogleFonts.cairo(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('تم تأكيد الحجز بنجاح!'),
                  backgroundColor: Colors.green.shade600,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
            ),
            child: Text(
              'تأكيد',
              style: GoogleFonts.cairo(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
