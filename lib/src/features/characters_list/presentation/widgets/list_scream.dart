import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool enabled;
  final Widget child;
  const Loader({
    Key? key,
    required this.enabled,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (enabled)
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
