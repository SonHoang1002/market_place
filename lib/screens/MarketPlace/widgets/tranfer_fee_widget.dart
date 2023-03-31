import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:market_place/theme/colors.dart';
import 'package:market_place/widgets/GeneralWidget/spacer_widget.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';

Widget buildTranferFee() {
  return GestureDetector(
    onTap: () {},
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 20,
                    width: 15,
                    child: const Icon(
                      FontAwesomeIcons.car,
                      size: 16,
                      color: Colors.green,
                    ),
                  ),
                  buildTextContent("Miễn phí vận chuyển", false, fontSize: 14)
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 20,
                    width: 15,
                  ),
                  Expanded(
                    child: buildTextContent(
                        "Miễn phí vận chuyển cho đơn hàng trên ₫250.000", false,
                        fontSize: 14, maxLines: 2, colorWord: greyColor),
                  )
                ],
              ),
              buildSpacer(height: 5),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 20,
                    width: 15,
                    child: const Icon(
                      FontAwesomeIcons.car,
                      size: 16,
                    ),
                  ),
                  buildTextContent("Phí vận chuyển từ ₫1.500-₫22.000", false,
                      fontSize: 14)
                ],
              ),
            ],
          ),
        ),
        const Icon(
          FontAwesomeIcons.chevronRight,
          size: 17,
        )
      ],
    ),
  );
}
