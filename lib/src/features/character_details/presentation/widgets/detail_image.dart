
import 'package:flutter/material.dart';

class DetailImage extends StatelessWidget {
  final String url;
  const DetailImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
