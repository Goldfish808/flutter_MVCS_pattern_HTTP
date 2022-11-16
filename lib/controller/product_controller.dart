// VIEW -> Controller
// 요청만 함. 응답은 provider가 함
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:data_app/main.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../views/components/my_alert_dialog.dart';

// @Controller 느낌
final productController = Provider<ProductController>((ref) {
  return ProductController(ref);
});

/*
컨트롤러 ( Controller ) : 비즈니스 로직 담당
*/
class ProductController {
  final context = navigatorKey.currentContext!;
  final Ref _ref;
  ProductController(this._ref);

  //리프레시 할때 씀
  void findAll() {
    List<Product> productList = _ref.read(productHttpRepository).findAll();
    _ref.read(productListViewStore.notifier).onRefresh(productList);
  }

  void insert(Product productReqDto) {
    Product productRespDto =
        _ref.read(productHttpRepository).insert(productReqDto);
    _ref.read(productListViewStore.notifier).addProduct(productRespDto);
  }

  void deleteById(int id) {
    int result = _ref.read(productHttpRepository).deleteById(id);
    if (result == 1) {
      _ref.read(productListViewStore.notifier).removeProduct(id);
    } else {
      showCupertinoDialog(
          context: context, builder: (context) => MyAlertDialog(msg: "삭제 실패"));
      //값을 변경!! store에!!
      //_ref.listen(productListViewStore, (previous, next) {});
    }
  }

  void updateById(int id, Product productReqDto) {
    Product productRespDto =
        _ref.read(productHttpRepository).updateById(id, productReqDto);
    _ref.read(productListViewStore.notifier).updateProduct(productRespDto);
  }
}
