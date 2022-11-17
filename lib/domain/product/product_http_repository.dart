import 'dart:convert';

import 'package:data_app/domain/http_connector.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// Provider 창고에 넣음 HTTP 통신으로 받은 데이터를
final productHttpRepository = Provider<ProductHttpRepository>((ref) {
  return ProductHttpRepository(ref);
});

class ProductHttpRepository {
  final Ref _ref;
  ProductHttpRepository(this._ref);

  List<Product> list = [
    Product(id: 1, name: "바나나", price: 2000),
    Product(id: 2, name: "사과", price: 2000),
    Product(id: 3, name: "애플", price: 2000)
  ];

  Future<List<Product>> findAll() async {
    Response response = await _ref.read(httpConnector).get("/api/product");
    List<dynamic> dataList = jsonDecode(response.body)["data"];
    return dataList.map((productMap) => Product.fromJson(productMap)).toList();

    // Response response = await _ref.read(httpConnector).get("/api/product");
    // //Future 로 받기 때문에 await 가 필요함 ( 요청 대기까진 NULL 이기 때문에 )
    // print("${response.statusCode}");
    //
    // Map<String, dynamic> body = jsonDecode(response.body);
    // //언제 어떤 데이터의 타입일줄 모르니까 dynamic 타입으로 받음 (자바의 OBject)
    // print("${body}");
    // if (body["code"] == 1) {
    //   print("통신성공");
    //   List<dynamic> dataList = body["data"];
    //
    //   List<Product> productList = //for문 돌면서 타입에 맞게 매핑 해줌
    //       dataList.map((productMap) => Product.fromJson(productMap)).toList();
    // } else {
    //   print("통신실패");
    // }
  }

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

  // name 과 price 만 입력 받게 됨
  Future<Product> insert(Product productDto) async {
    // productDto.id = 4; //http 통신에서 insert되고 부여받은 id (4)를 리턴 받았다고 가정
    // list = [...list, productDto];
    String body = jsonEncode(productDto.toJson());
    Response response =
        await _ref.read(httpConnector).post("/api/product", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  Future<int> deleteById(int id) async {
    Response response =
        await _ref.read(httpConnector).delete("/api/product/${id}");
    return jsonDecode(response.body)["code"];
  }

  Future<Product> updateById(int id, Product productReqDto) async {
    String body = jsonEncode(productReqDto.toJson());
    Response response =
        await _ref.read(httpConnector).put("/api/product/${id}", body);
    Product product = Product.fromJson(jsonDecode(response.body)["data"]);
    return product;
  }

  // Product updateById(int id, Product productDto) { //통신 전
  //   List<Product> updatePList = list.map((product) {
  //     if (product.id == id) {
  //       product = productDto;
  //       return product;
  //     } else {
  //       return product;
  //     }
  //   }).toList();
  //   productDto.id;
  //   return productDto;
  // }

  // int deleteById(int id) { //통신 전
  //   // if (id == 4) { // 4 인 요소는 삭제 안되게 하려했던 실습
  //   //   return -1;
  //   // } else {
  //   //   return 1;
  //   // }
  //
  //   // List<Product> deleteP = list.where((product) => product.id != id).toList();
  //   // return 1;
  // }
}
