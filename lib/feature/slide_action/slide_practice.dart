import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:whatsapp_clone_app/feature/slide_action/slide_action.dart';

class SlidePractice extends StatefulWidget {
  const SlidePractice({super.key});

  static const String route = "/SlidePractice";

  @override
  State<SlidePractice> createState() => _SlidePracticeState();
}

class _SlidePracticeState extends State<SlidePractice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomSliderButton(width: 200.w, height: 50.h),
      ),
    );
  }
}

class CustomSliderButton extends StatefulWidget {
  final double width;
  final double height;

  const CustomSliderButton({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State createState() => _CustomSliderButtonState();
}

class _CustomSliderButtonState extends State<CustomSliderButton>
    with SingleTickerProviderStateMixin {
  double _value = 0.0;
  bool _isDragging = false;
  bool _isSlideCompleted = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(double newValue) {
    setState(() {
      _value = newValue.clamp(0.0, 1.0);
      if (_value == 1) {
        _isSlideCompleted = true;
        _controller.forward();
      } else {
        _isSlideCompleted = false;
        _controller.reset();
      }
    });

    if (_isSlideCompleted) {
      // _cancelRecording(context);'
      // _value = 0.0;
    }
  }

  void _onTapDown(TapDownDetails details) {
    _isDragging = true;
    _updateValue(details.localPosition.dx / widget.width);
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_value < 1) {
      // Update the value only if it's less than 1
      _isDragging = true;
      _updateValue(details.localPosition.dx / widget.width);
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _isDragging = false;
    if (!_isSlideCompleted) {
      _updateValue(0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 6),
        color: Colors.deepPurple.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          if (!_isSlideCompleted)
            Positioned(
              top: widget.height * 0.1,
              left: _value < 0.1
                  ? _value * widget.width
                  : (_value + 0.00) * widget.width,
              child: GestureDetector(
                onTapDown: _onTapDown,
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                onHorizontalDragEnd: _onHorizontalDragEnd,
                child: Container(
                  width: widget.height * 0.8,
                  height: widget.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.height / 6),
                    color: Colors.deepPurple,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (!_isSlideCompleted)
            Positioned(
              top: widget.height * 0.25,
              right:
                  _value * (widget.width - widget.height) + widget.height * 0.1,
              child: Container(
                width: widget.width - widget.height,
                height: widget.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height / 6),
                  color: Colors.transparent,
                ),
              ),
            ),
          if (_isSlideCompleted) // When the slide is completed
            Positioned(
              top: widget.height * 0.1,
              left: widget.width -
                  widget.height * 0.8, // Make the container stick to the right
              child: Container(
                width: widget.height * 0.8,
                height: widget.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height / 6),
                  color: Colors.deepPurple,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
