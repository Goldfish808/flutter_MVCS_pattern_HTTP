import 'package:data_app/domain/product/product.dart';
import 'package:data_app/domain/product/product_http_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListViewStore =
    StateNotifierProvider<ProductListViewStore, List<Product>>((ref) {
  return ProductListViewStore(ref.read(productHttpRepository).list);
});

class ProductListViewStore extends StateNotifier<List<Product>> {
  ProductListViewStore(super.state);

  //컨트롤러에서 이것을 호출 함
  void onRefresh(List<Product> productList) {
    state = productList;
  }

  void addProduct(Product productRespDto) {
    state = [...state, productRespDto]; //깊은 복사
    //state.add(productRespDto); //기존값을 변경, 이는 작동하지 않음
  }

  void removeProduct(int id) {
    state = state.where((product) => product.id != id).toList(); //깊은 복사
  }

  void updateProduct(productRespDto) {
    state = state.map((product) {
      if (product.id == productRespDto.id) {
        product.price = 8888888;
        return product;
      } else {
        return product;
      }
    }).toList();
  }
}
