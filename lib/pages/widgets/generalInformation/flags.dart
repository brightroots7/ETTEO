import 'package:etteo_demo/helpers/string_helper.dart';
import 'package:etteo_demo/model/order_detail/flags_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_selectable_text/flutter_selectable_text.dart' as fst;

class Flags extends StatelessWidget {
  final FlagsModel flag;
  const Flags({@required this.flag});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: showFlagIcon(flag),
        ),
        Flexible(
          child: fst.SelectableText(checkNull(flag.flagTypeDescription),
              style: Theme.of(context).textTheme.subhead),
        ),
      ],
      // ),
    );
  }

  Widget showFlagIcon(FlagsModel flags) {
    MaterialColor iconColor;
    switch (flags.flagTypePriority) {
      case 1:
        iconColor = Colors.red;
        break;
      case 2:
        iconColor = Colors.green;
        break;
      case 3:
        iconColor = Colors.blue;
        break;
      case 4:
        iconColor = Colors.orange;
        break;
      case 5:
        iconColor = Colors.yellow;
        break;
    }

    return IconButton(
      icon: Icon(
        Icons.flag,
        color: iconColor,
        size: 30,
      ),
      onPressed: () {},
    );
  }
}
