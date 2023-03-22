import 'package:market_place/apis/api_root.dart';

class PageListApi {
  Future getPageListApi() async {
    return await Api().getRequestBase('/api/v1/pages', null);
  }
}
