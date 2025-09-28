import 'dart:async';

import 'package:flutter/material.dart';

class AutoScrollingImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final double height;

  const AutoScrollingImageSlider({
    super.key,
    required this.imageUrls,
    this.height = 200,
  });

  @override
  State<AutoScrollingImageSlider> createState() =>
      _AutoScrollingImageSliderState();
}

class _AutoScrollingImageSliderState extends State<AutoScrollingImageSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Auto-scroll every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // loop back to first image
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(widget.imageUrls[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
