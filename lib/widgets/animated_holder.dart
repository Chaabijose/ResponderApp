import 'package:flutter/material.dart';

class AnimatedHolder extends StatefulWidget {
  final Widget view;
  const AnimatedHolder({super.key, required this.view});

  @override
  State<AnimatedHolder> createState() => _AnimatedHolderState();
}

class _AnimatedHolderState extends State<AnimatedHolder> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation,child: InkWell(
      onTap: ()async{
        await _controller.reverse();
        await _controller.forward();
      },
      child: widget.view,
    ),);
  }
}
