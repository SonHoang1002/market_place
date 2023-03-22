import 'package:market_place/apis/api_root.dart';

class DiscoverProductsApi {
  Future getListDiscoverProductsApi() async {
    return await Api().getRequestBase('/api/v1/products', null);
  }
}
