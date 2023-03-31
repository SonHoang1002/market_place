import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:market_place/helpers/format_currency.dart';
import 'package:market_place/screens/MarketPlace/widgets/simple_button_widget.dart';
import 'package:market_place/screens/MarketPlace/widgets/voucher_widget.dart';
import 'package:market_place/theme/colors.dart'; 
import 'package:market_place/widgets/GeneralWidget/spacer_widget.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';
import 'package:market_place/widgets/image_cache.dart';

Widget buildReviewShop(
    BuildContext context, String title, String onlineTime, String location) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const ImageCacheRender(
                    path:
                        'https://thumbs.dreamstime.com/z/meat-store-badges-logos-labels-any-use-example-to-design-your-58408646.jpg',
                    height: 60.0,
                    width: 60.0,
                  ),
                ),
                buildSpacer(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTextContent(title, false, fontSize: 14),
                    buildSpacer(height: 5),
                    buildTextContent(onlineTime, false, fontSize: 14),
                    buildSpacer(height: 5),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.mapLocation,
                          size: 13,
                        ),
                        buildSpacer(width: 5),
                        buildTextContent(location, false, fontSize: 14),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 100, child: buildSingleButton(context, "Xem Shop")),
          ],
        ),
        buildSpacer(height: 10),
        Row(
          children: [
            _buildDescription(100, "sản phẩm"),
            buildSpacer(width: 15),
            _buildDescription(4.8, "đánh giá"),
            buildSpacer(width: 15),
            _buildDescription('96%', "phản hồi chat"),
          ],
        ),
        buildSpacer(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: buildNonImageVoucherWidget(
              "Giảm 6%",
              "Đơn tối thiểu ₫${formatCurrency(120000)}. Giảm tối da ₫${formatCurrency(12000088)}",
              DateFormat("dd-MM-yyyy").format(DateTime.now())),
        ),
        buildSpacer(height: 10),
        buildTextContent("* Áp dụng cho tất cả sản phẩm của Shop", false,
            colorWord: greyColor, fontSize: 13)
      ],
    ),
  );
}

Widget _buildDescription(dynamic count, String title) {
  return Row(
    children: [
      buildTextContent(
        count.toString(),
        false,
        fontSize: 12,
        colorWord: red,
      ),
      buildSpacer(width: 5),
      buildTextContent(
        title,
        false,
        fontSize: 12,
      ),
    ],
  );
}
