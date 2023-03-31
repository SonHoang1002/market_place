import 'package:flutter/material.dart';
import 'product_item_widget.dart';

Widget buildClassifyCategoryComponent(
    {required BuildContext context,
    required Widget title,
    required List<dynamic> contentList,
    Function? titleFunction,
    Axis? axis = Axis.vertical}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return Column(
    children: [
      title,
      SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          scrollDirection: axis!,
          child: GridView.builder(
              scrollDirection: axis,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  childAspectRatio: height > 800
                      ? 0.78
                      : (width / (height - 190) > 0
                          ? width / (height - 190)
                          : .81)),
              itemCount: contentList.length,
              itemBuilder: (context, index) {
                return buildProductItem(
                    context: context, data: contentList[index]);
              }))
    ],
  );
}

Widget buildHorizontalClassifyCategoryComponent(
    {required BuildContext context,
    required Widget title,
    required List<dynamic> contentList,
    Function? titleFunction,
    Axis? axis = Axis.vertical}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return Column(
    children: [
      title,
      SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 10),
          child: Row(
              children: List.generate(contentList.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {},
                child: buildProductItem(
                    context: context, data: contentList[index]),
              ),
            );
          })))
    ],
  );
}
