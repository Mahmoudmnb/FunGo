import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlaceImageSlider extends StatelessWidget {
  final List<String> imageUrls;
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 320,
          child: PageView.builder(
            itemCount: imageUrls.length,
            controller: controller,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              final src = imageUrls[index];
              final isNetwork = src.startsWith('http');
              return isNetwork
                  ? CachedNetworkImage(
                      imageUrl: src,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) =>
                          Image.asset('assets/images/placeholder.png'),
                    )
                  : Image.asset(
                      src,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) =>
                          Image.asset('assets/images/placeholder.png'),
                    );
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
              imageUrls.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.white
                      : Colors.white54,
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
