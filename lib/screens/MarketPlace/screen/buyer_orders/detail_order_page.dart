import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:market_place/helpers/format_currency.dart';
import 'package:market_place/helpers/routes.dart';
import 'package:market_place/providers/market_place_providers/products_provider.dart';
import 'package:market_place/screens/MarketPlace/screen/buyer_orders/status_timeline_page.dart';
import 'package:market_place/screens/MarketPlace/widgets/between_content.dart';
import 'package:market_place/screens/MarketPlace/widgets/classify_category_conponent.dart';
import 'package:market_place/screens/MarketPlace/widgets/simple_button_widget.dart';
import 'package:market_place/widgets/GeneralWidget/divider_widget.dart';
import 'package:market_place/widgets/GeneralWidget/information_component_widget.dart';
import 'package:market_place/widgets/GeneralWidget/spacer_widget.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_button.dart';
import 'package:market_place/widgets/back_icon_appbar.dart';
import 'package:market_place/widgets/cross_bar.dart';
import 'package:flutter/services.dart';
import 'package:market_place/widgets/GeneralWidget/text_content_widget.dart';
import 'package:market_place/widgets/image_cache.dart';

import '../../../../theme/colors.dart';
import '../../../../widgets/messenger_app_bar/app_bar_title.dart';

class DetailOrderPage extends ConsumerStatefulWidget {
  final dynamic data;
  const DetailOrderPage({super.key, required this.data});

  @override
  ConsumerState<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends ConsumerState<DetailOrderPage> {
  late double width = 0;
  late double height = 0;
  dynamic _mainData;
  bool _priceOpen = false;
  Future _initData() async {
    _mainData ??= widget.data["data"];
    setState(() {});
  }

  List<String> _getStatusOrder() {
    String paidTitle = '';
    String statusTitle = '';
    if (_mainData["payment_status"] == "paid") {
      paidTitle = "Đã thanh toán";
    } else {
      paidTitle = "Chưa thanh toán";
    }
    switch (_mainData["status"]) {
      case "pending":
        statusTitle = "Đơn hàng đang chờ xử lý";
        break;
      case "delivered":
        statusTitle = "Đơn hàng đang vận chuyển";
        break;
      case "shipping":
        statusTitle = "Đon hàng đang giao";
        break;
      case "finish":
        statusTitle = "Đơn hàng thành công";
        break;
      case "cancelled":
        statusTitle = "Đơn hàng đã bị hủy";
        break;
      case "return":
        statusTitle = "Đơn hàng bị trả lại";
        break;
    }
    return [statusTitle, paidTitle];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    Future.wait([_initData()]);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              BackIconAppbar(),
              AppBarTitle(text: "Thông tin đơn hàng"),
              SizedBox()
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // trang thai don hang
                  _buildStatusOrder(),
                  const CrossBar(
                    height: 5,
                  ),
                  _buildTransferWidget(),
                  buildDivider(height: 10, color: greyColor),
                  _buildAddressWidget(),
                  buildSpacer(height: 7),
                  const CrossBar(
                    margin: 0,
                    height: 5,
                  ),
                  // ten shop
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              FontAwesomeIcons.store,
                              size: 19,
                            ),
                          ),
                          SizedBox(
                              width: 180,
                              child: buildTextContent(
                                  _mainData["page"]["title"], true,
                                  fontSize: 17,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              buildTextContentButton("Xem shop", false,
                                  fontSize: 13, function: () {
                                pushToNextScreen(
                                    context, const StatusOrderTimelinePage());
                              }),
                              buildSpacer(width: 5),
                              const Icon(
                                FontAwesomeIcons.chevronRight,
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  buildDivider(
                    height: 1,
                    color: greyColor,
                  ),
                  // cac san pham
                  Column(
                      children: List.generate(_mainData["order_items"].length,
                          (index) {
                    return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            _buildChildPaymentProduct(
                                _mainData["order_items"][index])
                          ],
                        ));
                  })),
                  // tong tien
                  buildSpacer(height: 15),
                  Column(
                    children: [
                      _priceOpen
                          ? Column(
                              children: [
                                buildBetweenContent("Tổng tiền hàng",
                                    "₫${formatCurrency(_mainData["subtotal"])}"),
                                buildBetweenContent(
                                  "Phí vận chuyển",
                                  "₫${formatCurrency(_mainData["delivery_fee"])}",
                                ),
                                buildBetweenContent("Giả giá phí vận chuyển",
                                    "₫${formatCurrency(1000)}"),
                              ],
                            )
                          : const SizedBox(),
                      buildBetweenContent("Thành tiền",
                          "₫${formatCurrency(_mainData["order_total"] - 1000)}",
                          isBold: true, fontSize: 14, function: () {
                        setState(() {
                          _priceOpen = true;
                        });
                      },
                          additionalWidget: _priceOpen
                              ? const SizedBox()
                              : const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    FontAwesomeIcons.chevronDown,
                                    size: 9,
                                  ),
                                )),
                    ],
                  ),
                  const CrossBar(
                    height: 5,
                  ),
                  GeneralComponent(
                    [
                      buildTextContent(
                        "Phương thức thanh toán",
                        false,
                        fontSize: 13,
                      )
                    ],
                    prefixWidget: const Icon(
                      FontAwesomeIcons.locationCrosshairs,
                      size: 15,
                      color: red,
                    ),
                    isHaveBorder: false,
                    borderRadiusValue: 0,
                    changeBackground: transparent,
                    padding: const EdgeInsets.only(left: 10, bottom: 7),
                    function: () async {},
                  ),
                  GeneralComponent(
                    [_getPaymentMethod()],
                    prefixWidget: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: SizedBox(),
                    ),
                    isHaveBorder: false,
                    borderRadiusValue: 0,
                    changeBackground: transparent,
                    padding: const EdgeInsets.only(left: 10),
                    function: () async {},
                  ),
                  const CrossBar(
                    height: 5,
                  ),
                  _buildOrderCodeAndTime(),
                  buildDivider(height: 1, top: 7, bottom: 7),
                  _buildButtons(),
                  buildSpacer(height: 5),
                  const CrossBar(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildClassifyCategoryComponent(
                        context: context,
                        title: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                                flex: 1,
                                child: Container(
                                  color: greyColor,
                                  width: width,
                                  height: 1,
                                )),
                            Flexible(
                              flex: 2,
                              child: buildTextContent(
                                  "Có thể bạn cũng thích", false,
                                  fontSize: 13, isCenterLeft: false),
                            ),
                            Flexible(
                                flex: 1,
                                child: Container(
                                  color: greyColor,
                                  width: width,
                                  height: 1,
                                ))
                          ],
                        ),
                        contentList: ref.watch(productsProvider).list),
                  ),
                ],
              )),
        ));
  }

  // change
  Widget _buildStatusOrder() {
    return GeneralComponent(
      [
        buildTextContent(
          _getStatusOrder()[0],
          true,
          fontSize: 15,
        ),
        buildSpacer(height: 10),
        buildTextContent(
          _getStatusOrder()[1],
          false,
          fontSize: 13,
        ),
        buildSpacer(height: 10),
        buildTextContent(
          "Cảm ơn bạn đã mua sắm tại Emso !",
          false,
          fontSize: 13,
        ),
      ],
      suffixFlexValue: 8,
      suffixWidget: const ImageCacheRender(
        path:
            "https://snapi.emso.asia/system/media_attachments/files/109/311/682/380/490/462/original/e692f50e243bd484.png",
        height: 80.0,
        width: 80.0,
      ),
      isHaveBorder: false,
      borderRadiusValue: 0,
      changeBackground: Theme.of(context).colorScheme.background,
    );
  }

  Widget _buildTransferWidget() {
    return InkWell(
      onTap: () async {},
      child: Column(
        children: [
          GeneralComponent(
            [
              buildTextContent(
                "Thông tin vận chuyển",
                true,
                fontSize: 14,
              )
            ],
            prefixWidget: const Icon(
              FontAwesomeIcons.locationCrosshairs,
              size: 15,
              color: red,
            ),
            suffixWidget:
                buildTextContentButton("XEM", true, fontSize: 14, function: () {
              pushToNextScreen(context, const StatusOrderTimelinePage());
            }),
            isHaveBorder: false,
            borderRadiusValue: 0,
            changeBackground: transparent,
            padding: const EdgeInsets.only(left: 10, bottom: 7),
          ),
          buildSpacer(height: 5),
          GeneralComponent(
            [
              buildTextContent("${"Nhanh"}", false, fontSize: 13),
              buildSpacer(height: 5),
              buildTextContent("${"Emso Xpress - JSGJSJHFDKSKSDFH"}", false,
                  fontSize: 13),
            ],
            prefixWidget: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: SizedBox(),
            ),
            isHaveBorder: false,
            borderRadiusValue: 0,
            changeBackground: transparent,
            padding: const EdgeInsets.only(left: 10),
            function: () async {},
          ),
          buildSpacer(height: 7),
          GeneralComponent(
            [
              buildTextContent("${"Đơn hàng đã giao thành công"}", true,
                  fontSize: 13, colorWord: Colors.green),
              buildSpacer(height: 7),
              buildTextContent("${"3 - 3 - 2023 10:25"}", false, fontSize: 13),
            ],
            prefixWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.dotCircle,
                  size: 15,
                  color: Colors.green,
                ),
                Column(
                  children: [
                    Container(
                      height: 17,
                      width: 1,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        height: 1,
                        width: 9,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
            isHaveBorder: false,
            borderRadiusValue: 0,
            changeBackground: transparent,
            padding: const EdgeInsets.only(left: 10),
            function: () async {},
          ),
          buildSpacer(height: 7),
        ],
      ),
    );
  }

  Widget _buildAddressWidget() {
    return InkWell(
      onTap: () async {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            GeneralComponent(
              [
                buildTextContent(
                  "Địa chỉ nhận hàng",
                  true,
                  fontSize: 14,
                )
              ],
              prefixWidget: const Icon(
                FontAwesomeIcons.locationCrosshairs,
                size: 15,
                color: red,
              ),
              suffixFlexValue: 8,
              suffixWidget: buildTextContentButton("SAO CHÉP", true,
                  fontSize: 14, colorWord: Colors.green, function: () async {
                if (_mainData["delivery_address"] != null) {
                  final deli = _mainData["delivery_address"];
                  await Clipboard.setData(ClipboardData(
                      text: deli["name"] +
                          " " +
                          deli["phone_number"] +
                          " " +
                          deli["detail_addresses"] +
                          " " +
                          deli["addresses"]));
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sao chép thành công")));
                }
              }),
              isHaveBorder: false,
              borderRadiusValue: 0,
              changeBackground: transparent,
              padding: const EdgeInsets.only(left: 10, bottom: 7),
              function: () async {},
            ),
            buildSpacer(height: 5),
            GeneralComponent(
              [
                buildTextContent(
                    "${_mainData["delivery_address"]["name"]}", false,
                    fontSize: 13),
                buildSpacer(height: 5),
                buildTextContent(
                    "${_mainData["delivery_address"]["phone_number"]}", false,
                    fontSize: 13),
                buildSpacer(height: 5),
                buildTextContent(
                    "${_mainData["delivery_address"]["detail_addresses"]}, ${_mainData["delivery_address"]["addresses"]}",
                    false,
                    fontSize: 13),
              ],
              prefixWidget: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: SizedBox(),
              ),
              isHaveBorder: false,
              borderRadiusValue: 0,
              changeBackground: transparent,
              padding: const EdgeInsets.only(left: 10),
              function: () async {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildPaymentProduct(dynamic childItemData) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            ImageCacheRender(
              height: 80.0,
              width: 80.0,
              path: childItemData["product_variant"]["image"] != null
                  ? childItemData["product_variant"]["image"]["url"]
                  : "https://kynguyenlamdep.com/wp-content/uploads/2022/01/hinh-anh-meo-con-sieu-cute-700x467.jpg",
            ),
            buildSpacer(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTextContent(
                      childItemData["product_variant"]["title"], false,
                      fontSize: 15,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  buildSpacer(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTextContent(
                        "${childItemData["product_variant"]["option1"] ?? ""} ${childItemData["product_variant"]["option2"] != null ? " - ${childItemData["product_variant"]["option2"]}" : ""}",
                        false,
                        colorWord: greyColor[700],
                        fontSize: 13,
                      ),
                      buildTextContent(
                        "x${childItemData["quantity"]}",
                        false,
                        colorWord: greyColor[700],
                        fontSize: 13,
                      ),
                    ],
                  ),
                  buildSpacer(height: 10),
                  buildTextContent(
                    "₫${formatCurrency(childItemData["product_variant"]["price"])}",
                    false,
                    colorWord: red,
                    fontSize: 13,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getPaymentMethod() {
    return _mainData["shipping_method_id"] != null
        ? _mainData["shipping_method_id"] == "ECOIN"
            ? buildTextContent("${"Thanh toán bằng ECOIN"}", false,
                fontSize: 15)
            : buildTextContent("${"Thanh toán khi nhận hàng"}", false,
                fontSize: 15)
        : buildTextContent("${"Không có phương thức thanh toán"}", false,
            fontSize: 15);
  }

  Widget _buildOrderCodeAndTime() {
    return Column(
      children: [
        buildBetweenContent("Mã đơn hàng", "676SDF867876SDFS",
            isBold: true,
            fontSize: 14,
            additionalWidget: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: buildTextContent(
                "SAO CHÉP",
                true,
                fontSize: 14,
                colorWord: Colors.green,
              ),
            )),
        buildBetweenContent(
          "Thời gian đặt hàng",
          "${DateFormat("dd-MM-yyyy hh-mm").format(DateTime.parse(_mainData["created_at"]))}",
        ),
        buildBetweenContent(
          "Thời gian thanh toán",
          "${DateFormat("dd-MM-yyyy hh-mm").format(DateTime.now())}",
        ),
        buildBetweenContent(
          "Thời gian giao hàng cho vận chuyển",
          "${DateFormat("dd-MM-yyyy hh-mm").format(DateTime.now())}",
        ),
        buildBetweenContent(
          "Thời gian hoàn thành",
          "${DateFormat("dd-MM-yyyy hh-mm").format(DateTime.now())}",
        ),
      ],
    );
  }

  // change
  Widget _buildButtons() {
    List<Widget> buttons = [];
    if (_mainData["payment_status"] == "paid") {
      buttons = [
        buildSingleButton(context, "Liên hệ Shop", function: () {}),
        buildSingleButton(context, "Mua lại", function: () {}),
      ];
    } else {
      switch (_mainData["status"]) {
        case "pending":
          buttons = [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: buildSingleButton(context, "Liên hệ Shop",
                      width: width * 0.9, function: () {}),
                ),
                buildSpacer(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: buildSingleButton(context, "Xác nhận hủy",
                      width: width * 0.9, function: () {}),
                ),
              ],
            )
          ];
          break;
        case "delivered":
          buttons = [
            buildSingleButton(context, "Liên hệ Shop",
                width: width * 0.9, function: () {}),
          ];
          break;
        case "shipping":
          buttons = [
            buildSingleButton(context, "Liên hệ Shop", function: () {}),
          ];
          break;
        case "finish":
          buttons = [
            buildSingleButton(context, "Liên hệ Shop", function: () {}),
            buildSingleButton(context, "Mua lại", function: () {}),
          ];
          break;
        case "cancelled":
          buttons = [
            buildSingleButton(context, "Liên hệ Shop", function: () {}),
            buildSingleButton(context, "Xem thông tin hủy", function: () {}),
          ];
          break;
        case "return":
          buttons = [
            buildSingleButton(context, "Liên hệ Shop", function: () {}),
            buildSingleButton(context, "Mua lại", function: () {}),
          ];
          break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }

  Widget _buildContent(String day, String time, String title, String content,
      {Color titleColor = greyColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        buildTextContent(day, true, fontSize: 14, colorWord: greyColor),
        buildSpacer(height: 5),
        buildTextContent(time, false, fontSize: 14, colorWord: greyColor),
        buildSpacer(height: 15),
        buildTextContent(title, true, fontSize: 17, colorWord: titleColor),
        buildSpacer(height: 5),
        buildTextContent(content, false, fontSize: 16, colorWord: titleColor),
      ]),
    );
  }
}

List<Map<String, dynamic>> demoDelvered = [
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
  {
    "day": "18 tháng 3",
    "time": "15:34",
    "title": "Giao hàng không thành công",
    "content":
        "ĐƠn hngf hoàn trả về cho người dùng do gaio hàng không thành công"
  },
];
