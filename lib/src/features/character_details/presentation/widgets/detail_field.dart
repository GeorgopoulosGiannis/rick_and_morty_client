import 'package:flutter/material.dart';

class DetailField extends StatelessWidget {
  final String title;
  final String value;
  const DetailField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          value.isEmpty ? ' - ' : value,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
