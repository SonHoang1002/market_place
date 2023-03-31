import 'package:market_place/apis/api_root.dart';

class SearchProductsApi {
  Future searchProduct(dynamic data) async {
    return await Api().getRequestBase("/api/v1/product_search", data);
  }

  Future searchHistoryProduct({dynamic data}) async {
    return await Api().getRequestBase("/api/v1/search_histories?limit=10", data ?? null);
  }
}
