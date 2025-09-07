import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/place_model.dart';

class PlaceImageSlider extends StatefulWidget {
  final List<Images> imageUrls;
  final PageController controller;
  final int currentPage;
  final void Function(int) onPageChanged;

  const PlaceImageSlider({
    super.key,
    required this.imageUrls,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<PlaceImageSlider> createState() => _PlaceImageSliderState();
}

class _PlaceImageSliderState extends State<PlaceImageSlider> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            itemCount: widget.imageUrls.length,
            controller: widget.controller,
            onPageChanged: (value) {
              currentPage = value;
              setState(() {});
              widget.onPageChanged(value);
            },
            itemBuilder: (context, index) {
              final Images src = widget.imageUrls[index];
              final isNetwork = src.original!.startsWith('http');
              return isNetwork
                  ? CachedNetworkImage(
                      imageUrl: src.original!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) => const Center(
                            child: Text(
                              'خطأ في الصورة',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                            ),
                          )
                      // Image.asset('assets/images/placeholder.png'),
                      )
                  : Image.asset(src.original!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) =>
                          // Image.asset('assets/images/placeholder.png'),
                          const Center(
                            child: Text(
                              'خطأ في الصورة',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 40),
                            ),
                          ));
            },
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imageUrls.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
