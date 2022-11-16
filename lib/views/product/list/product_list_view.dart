import 'package:data_app/controller/product_controller.dart';
import 'package:data_app/domain/product/product.dart';
import 'package:data_app/views/components/my_alert_dialog.dart';
import 'package:data_app/views/product/list/product_list_view_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListView extends ConsumerWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pM = ref.watch(productListViewStore);
    final pC = ref.read(productController);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          pC.insert(Product(4, "비둘기", 8888));
        },
      ),
      appBar: AppBar(
        title: Text("product_list_page"),
      ),
      body: ListView.builder(
        itemCount: pM.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(pM[index].id),
          onTap: () {
            pC.deleteById(pM[index].id);
          },
          onLongPress: () {
            // update 하기
            pC.updateById(pM[index].id, pM[index]);
          },
          leading: Icon(Icons.wallet_giftcard),
          title: Text("${pM[index].name}",
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${pM[index].price}" + " 원"),
        ),
      ),
    );
  }
}
