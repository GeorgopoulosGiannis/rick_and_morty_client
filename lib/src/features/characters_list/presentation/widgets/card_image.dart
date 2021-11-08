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
      child: Hero(
        tag: url,
        child: Container(
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                url,
              ),
              fit: BoxFit.fill,
              // swallow error and keep showing decoration image
              onError: (object, stacktrace) {},
            ),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/sample-placeholder.jpeg',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
