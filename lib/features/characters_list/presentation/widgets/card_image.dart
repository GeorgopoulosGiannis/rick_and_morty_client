import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String url;
  const CardImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: Image.network(
        url,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return const Text('😢');
        },
      ),
    );
  }
}
