// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:market_place/apis/market_place_apis/page_list_api.dart';

// final pagesProvider = StateNotifierProvider<ListPageController, ListPageState>(
//     (ref) => ListPageController());

// class ListPageController extends StateNotifier<ListPageState> {
//   ListPageController() : super(ListPageState());

//   getListPageItem() async {
//     final response = await PageListApi().getPageListApi();
//     state = state.copyWith(response);
//   }
// }

// class ListPageState {
//   List<dynamic> listPage;
//   ListPageState({this.listPage = const []});
//   ListPageState copyWith(List<dynamic> list) {
//     return ListPageState(listPage: list);
//   }
// }
