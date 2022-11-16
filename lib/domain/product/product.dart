class Product {
  // int? _id; //변수명 앞에 언더스코어는 private
  // String? name;
  // int? price;
  //
  // Product({this.id, this.name, this.price}); //중괄호 쓸 때 위 Type 앞에 물음표 ( 널을 허용 )

  int id; //변수명 앞에 언더스코어는 private
  String name;
  int price;

  Product(this.id, this.name, this.price); //중괄호 쓸 때 위 Type 앞에 물음표 ( 널을 허용 )
}
