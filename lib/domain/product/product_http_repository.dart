import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider 창고에 넣음 HTTP 통신으로 받은 데이터를
final productHttpRepository = Provider((ref) {
  return ProductHttpRepository();
});

class ProductHttpRepository {
  List<Product> list = [
    Product(1, "바나나", 2000),
    Product(2, "딸기", 2000),
    Product(3, "야플", 2000)
  ];

  Product findById(int id) {
    //http 통신 코드 By 스프링의 API 문서에 따라서
    /*
    http 통신을 하는동안 CPU가 다음 코드로 넘어갈 수 있도록 스레드를 열어줄 수 있다
    스레드가 하나이면 통신이 되는동안 사용자는 다른 동작을 할 수 없다

    Future<Product> findById(int id){ return null; } 과 같은 Future 박스 문법으로
    HTTP 통신 하는동안 리턴이 안되어도 다음 코드로 넘어가서 스레드동작을 할 수 있음
    */
    Product product = list.singleWhere((product) => product.id == id);
    return product;
  }

  List<Product> findAll() {
    return list;
  }

  // name 과 price 만 입력 받게 됨
  Product insert(Product productDto) {
    productDto.id = 4; //http 통신에서 insert되고 부여받은 id (4)를 리턴 받았다고 가정
    list = [...list, productDto];
    return productDto;
  }

  Product updateById(int id, Product productDto) {
    List<Product> updatePList = list.map((product) {
      if (product.id == id) {
        product = productDto;
        return product;
      } else {
        return product;
      }
    }).toList();
    productDto.id;
    return productDto;
  }

  int deleteById(int id) {
    if (id == 4) {
      return -1;
    } else {
      return 1;
    }
    List<Product> deleteP = list.where((product) => product.id != id).toList();
    return 1;
  }
}
