import 'package:flutter/material.dart';

class CardSubtitle extends StatelessWidget {
  final String lastKnown;
  final String firstSeen;
  const CardSubtitle({
    Key? key,
    required this.lastKnown,
    required this.firstSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        _SubtitlePart(
          title: 'Last known location:',
          value: lastKnown,
        ),
        const SizedBox(
          height: 15,
        ),
        _SubtitlePart(
          title: 'First seen in:',
          value: firstSeen,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class _SubtitlePart extends StatelessWidget {
  final String title;
  final String value;
  const _SubtitlePart({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          // in order to break lines on letters and not on words
          //https://github.com/flutter/flutter/issues/18761
          value,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
