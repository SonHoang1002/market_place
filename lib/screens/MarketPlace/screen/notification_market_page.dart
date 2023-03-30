import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:market_place/constant/marketPlace_constants.dart';
import 'package:market_place/helpers/format_currency.dart';
import 'package:market_place/helpers/routes.dart';
import 'package:market_place/providers/market_place_providers/page_list_provider.dart';
import 'package:market_place/screens/MarketPlace/screen/review_product_page.dart';
import 'package:market_place/screens/MarketPlace/screen/see_review_market.dart';
import 'package:market_place/screens/MarketPlace/screen/seller_orders/prepare_product_market_page.dart';
import 'package:market_place/screens/MarketPlace/widgets/between_content.dart';
import 'package:market_place/screens/MarketPlace/widgets/cart_widget.dart';
import 'package:market_place/screens/MarketPlace/widgets/circular_progress_indicator.dart';
import 'package:market_place/screens/MarketPlace/widgets/market_button_widget.dart';
import 'package:market_place/apis/market_place_apis/order_product_apis.dart';
import 'package:market_place/widgets/GeneralWidget/divider_widget.dart';
import 'package:market_place/widgets/GeneralWidget/information_component_widget.dart';
import 'package:market_place/widgets/GeneralWidget/show_bottom_sheet_widget.dart';
import 'package:market_place/widgets/GeneralWidget/show_message_dialog_widget.dart';
import 'package:market_place/widgets/GeneralWidget/spacer_widget.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_button.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';
import 'package:market_place/widgets/back_icon_appbar.dart';
import 'package:market_place/widgets/cross_bar.dart';
import 'package:market_place/widgets/image_cache.dart';
import 'package:market_place/widgets/messenger_app_bar/app_bar_title.dart';
import '../../../../theme/colors.dart';

class NotificationMarketPage extends ConsumerStatefulWidget {
  const NotificationMarketPage({super.key});

  @override
  ConsumerState<NotificationMarketPage> createState() =>
      _OrderProductMarketPageState();
}

const List<String> tabList = ["Thông báo của tôi", "Cập nhật Người bán"];

class _OrderProductMarketPageState
    extends ConsumerState<NotificationMarketPage> {
  late double width = 0;
  late double height = 0;
  Color? colorTheme;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final a = await ref.read(pageListProvider.notifier).getPageList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<int> _initData() async {
    // setState(() {});
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    colorTheme = ThemeMode.dark == true
        ? Theme.of(context).cardColor
        : const Color(0xfff1f2f5);
    Color colorWord = ThemeMode.dark == true
        ? white
        : true == ThemeMode.light
            ? blackColor
            : greyColor;
    Future.wait([_initData()]);
    return DefaultTabController(
        length: tabList.length,
        initialIndex: 0,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackIconAppbar(),
                  const AppBarTitle(text: "Thông báo"),
                  CartWidget()
                ],
              ),
              bottom: TabBar(
                isScrollable: true,
                tabs: tabList.map((e) {
                  return Tab(
                      child: SizedBox(
                    width: width * 0.43,
                    child: Row(
                      children: [
                        buildTextContent(e, false,
                            isCenterLeft: false,
                            colorWord: colorWord,
                            fontSize: 14),
                        buildSpacer(width: 5),
                        _buildNotiIcon()
                      ],
                    ),
                  ));
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: [_buildMyNoti(), _buildSellerNoti()],
            )));
  }

  Widget _buildMyNoti() {
    BoxDecoration boxDecoration = BoxDecoration(
        border: Border.all(color: greyColor, width: 0.2),
        borderRadius: BorderRadius.circular(18));
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(children: [
        const CrossBar(
          height: 7,
          margin: 0,
        ),
        _customGeneralComponent([
          buildTextContent("Khuyến mãi", false, fontSize: 16),
          buildTextContent("Nhanh lưu mã Freeship Xtra 1 tỷ", false,
              colorWord: greyColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontSize: 14),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(height: 10, color: greyColor),
        _customGeneralComponent([
          buildTextContent("Hoạt động", false, fontSize: 16),
          buildTextContent(
            "Chưa có hoạt động nào",
            false,
            colorWord: greyColor,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(height: 10, color: greyColor),
        _customGeneralComponent([
          buildTextContent("Cập nhật Emso", false, fontSize: 16),
          buildTextContent(
              "Bạn ơi, hãy dành vài phút tham gia khảo sát tại đây", false,
              colorWord: greyColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontSize: 14),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 10),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(
          height: 1,
          color: greyColor,
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          color: greyColor[300],
          height: 40,
          width: width,
          child: buildBetweenContent("Câp nhật đơn hàng", "Đọc tất cả"),
        ),
        Column(
          children: List.generate(10, (index) => _buildNotiContentItem()),
        )
      ]),
    );
  }

  Widget _buildSellerNoti() {
    BoxDecoration boxDecoration = BoxDecoration(
        border: Border.all(color: greyColor, width: 0.2),
        borderRadius: BorderRadius.circular(18));
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(children: [
        const CrossBar(
          height: 7,
          margin: 0,
        ),
        _customGeneralComponent([
          buildTextContent("Cập nhật đơn hàng", false, fontSize: 16),
          buildTextContent("Chưa có cập nhật đơn hàng", false,
              colorWord: greyColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontSize: 14),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 10, 7, 5),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(height: 10, color: greyColor),
        _customGeneralComponent([
          buildTextContent("Ví người bán", false, fontSize: 16),
          buildTextContent(
            "Chưa có cập nhật ví người bán",
            false,
            colorWord: greyColor,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 5),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(height: 10, color: greyColor),
        _customGeneralComponent([
          buildTextContent("Kênh Marketing", false, fontSize: 16),
          buildTextContent("Chưa có cập nhật kênh Marketing", false,
              colorWord: greyColor,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontSize: 14),
        ],
            prefixWidget: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration,
              child: const Icon(
                FontAwesomeIcons.moneyBill,
                size: 14,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(7, 5, 7, 10),
            suffixWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNotiIcon(),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                ),
              ],
            )),
        buildDivider(
          height: 1,
          color: greyColor,
        ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          color: greyColor[300],
          height: 40,
          width: width,
          child: buildBetweenContent("Câp nhật Shoppee", "Đọc tất cả"),
        ),
        Column(
          children: List.generate(10, (index) => _buildNotiContentItemDemo()),
        )
      ]),
    );
  }

  //general

  Widget _customGeneralComponent(List<Widget> listWidget,
      {Widget? prefixWidget,
      Widget? suffixWidget,
      int? suffixFlexValue,
      Color? bgColor,
      int? preffixFlexValue,
      EdgeInsets? padding,
      Function? function}) {
    return GeneralComponent(
      listWidget,
      prefixWidget: prefixWidget,
      suffixWidget: suffixWidget,
      preffixFlexValue: preffixFlexValue,
      suffixFlexValue: suffixFlexValue,
      isHaveBorder: false,
      borderRadiusValue: 0,
      changeBackground: bgColor ?? transparent,
      padding: padding ?? const EdgeInsets.only(top: 10, left: 10),
      function: function,
    );
  }

  Widget _buildNotiContentItem() {
    return Column(
      children: [
        _customGeneralComponent(
          [buildTextContent("đã xác nhận thanh toán COD", false, fontSize: 14)],
          padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
          prefixWidget: const ImageCacheRender(
            path:
                "https://snapi.emso.asia/system/media_attachments/files/110/027/944/508/904/841/original/6420c28ae44ca425.jpg",
            height: 40.0,
            width: 40.0,
          ),
        ),
        _customGeneralComponent(
          [
            buildTextContent(
                "Trong phần Stack, TabBar được đặt lên trên cùng với một container để tạo background trắng và đổ bóng. Positioned được sử dụng để đặt container cho hiệu ứng chuyển đổi tab. Thay vì di chuyển toàn bộ TabBar, chúng ta di chuyển một container có chiều rộng bằng với một tab item, để tạo hiệu",
                false,
                fontSize: 12,
                colorWord: greyColor),
            buildSpacer(height: 5),
            buildTextContent(
                DateFormat("hh:mm dd-MM-yyyy").format(DateTime.now()), false,
                fontSize: 12, colorWord: greyColor),
          ],
          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
          prefixWidget: Container(
            width: 40.0,
          ),
        ),
        buildDivider(color: greyColor)
      ],
    );
  }

  Widget _buildNotiContentItemDemo() {
    return Column(
      children: [
        _customGeneralComponent(
          [buildTextContent("đã xác nhận thanh toán COD", false, fontSize: 14)],
          padding: const EdgeInsets.fromLTRB(7, 7, 0, 0),
          prefixWidget: const ImageCacheRender(
            path:
                "https://snapi.emso.asia/system/media_attachments/files/110/027/944/508/904/841/original/6420c28ae44ca425.jpg",
            height: 40.0,
            width: 40.0,
          ),
        ),
        _customGeneralComponent(
          [
            buildTextContent(
                "Trong phần Stack, TabBar được đặt lên trên cùng với một container để tạo background trắng và đổ bóng. Positioned được sử dụng để đặt container cho hiệu ứng chuyển đổi tab. Thay vì di chuyển toàn bộ TabBar, chúng ta di chuyển một container có chiều rộng bằng với một tab item, để tạo hiệu",
                false,
                fontSize: 12,
                colorWord: greyColor),
            buildSpacer(height: 5),
            Row(
              children: const [
                Expanded(
                  child: ImageCacheRender(
                    path:
                        "https://snapi.emso.asia/system/media_attachments/files/110/027/944/508/904/841/original/6420c28ae44ca425.jpg",
                    height: 200.0,
                  ),
                ),
              ],
            ),
            buildSpacer(height: 5),
            buildTextContent(
                DateFormat("hh:mm dd-MM-yyyy").format(DateTime.now()), false,
                fontSize: 12, colorWord: greyColor),
          ],
          padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
          prefixWidget: Container(
            width: 40.0,
          ),
        ),
        buildDivider(color: greyColor)
      ],
    );
  }

  Widget _buildNotiIcon() {
    return Container(
      // padding: const EdgeInsets.all(4),
      height: 16, width: 16,
      decoration: BoxDecoration(
          border: Border.all(color: red, width: 0.2),
          borderRadius: BorderRadius.circular(8),
          color: red),
      child: buildTextContent(Random().nextInt(99).toString(), true, fontSize: 9, isCenterLeft: false),
    );
  }
}
