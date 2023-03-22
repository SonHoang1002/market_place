import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:market_place/apis/api_root.dart';

class ProductCategoriesApi {
  Future getListProductCategoriesApi() async {
    return await Api().getRequestBase('/api/v1/product_categories', null);
  }
}
