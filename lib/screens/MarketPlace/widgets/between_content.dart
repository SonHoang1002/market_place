 import 'package:flutter/material.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';

Widget buildBetweenContent(String title, String content,
      {bool isBold = false,
      Widget? additionalWidget,
      double? fontSize = 13,
      Function? function}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTextContent(
            title,
            isBold,
            fontSize: fontSize,
          ),
          GestureDetector(
            onTap: () {
              function != null ? function() : null;
            },
            child: Row(
              children: [
                buildTextContent(
                  content,
                  isBold,
                  fontSize: fontSize,
                ),
                additionalWidget ?? const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }