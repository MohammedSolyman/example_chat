import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  const TimeTile({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(date),
        ));
  }
}
