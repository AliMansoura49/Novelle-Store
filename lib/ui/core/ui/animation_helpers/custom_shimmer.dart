import 'package:flutter/material.dart';

class CustomShimmer extends StatefulWidget {
  final Widget child;
  const CustomShimmer({super.key,required this.child});

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1)
      )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _){
        return ShaderMask(
          shaderCallback: (bounds){
            final shimmerPosition = _controller.value * bounds.width * 2;
            return LinearGradient(
              begin: Alignment(-1, 0),
              end: Alignment(1, 0),
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
              stops: [
                (shimmerPosition - bounds.width) / bounds.width,
                shimmerPosition / bounds.width,
                (shimmerPosition + bounds.width) / bounds.width,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      }
      );
  }
}
