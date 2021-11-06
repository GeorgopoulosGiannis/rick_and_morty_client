import 'package:flutter/material.dart';

class ListScream extends StatelessWidget {
  final bool scream;
  final Widget child;
  const ListScream({
    Key? key,
    required this.scream,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        if (scream)
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
