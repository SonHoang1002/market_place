import 'package:flutter/material.dart';
import 'package:market_place/theme/colors.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';

Widget buildSingleButton(BuildContext context, String title,
    {double? width, Function? function}) {
  return GestureDetector(
    onTap: () {
      function != null ? function() : null;
    },
    child: Container(
      width: width ?? MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: greyColor, width: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: buildTextContent(title, false, fontSize: 13, isCenterLeft: false),
    ),
  );
}
