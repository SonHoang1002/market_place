import 'package:market_place/apis/api_root.dart';

class ProductRatingApis {
  Future getDeliveryAddressApi(dynamic id) async {
    return await Api().getRequestBase("/api/v1/products/$id/list_rating", null);
  }
}
