import 'package:market_place/apis/api_root.dart';

class ReviewProductApi {
  Future getReviewProductApi(dynamic id) async {
    return await Api()
        .getRequestBase('/api/v1/products/${id}/list_rating', null);
  }

  Future createReviewProductApi(dynamic id, dynamic data) async {
    return await Api()
        .postRequestBase('/api/v1/orders/$id/product_rating', data);
  }

  Future deleteReviewProductApi(dynamic productId, dynamic reviewId) async {
    return await Api().deleteRequestBase(
        '/api/v1/orders/$productId/product_rating/$reviewId', null);
  }
}
