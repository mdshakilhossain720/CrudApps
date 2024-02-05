
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'add tonewproductscreen.dart';
import 'editscreen.dart';
import 'model_product/productrlist.dart';

enum PopMenuType{
  deleted,
  edit,
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product>ListProduct=[];
  bool inprogress=false;

  @override
  void initState() {
    getProductListAPi();
    //deletedGetApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("product List"),
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
         await getProductListAPi();
        },
        child: Visibility(
          visible: inprogress=false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: ListProduct.length,
              itemBuilder: (context,index)
          {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(ListProduct[index].Image?? ''),
              ),
                  title: Text(ListProduct[index].productName??""),
              subtitle:  Wrap(
                children: [
                  Text("Product COde${ListProduct[index].productCOde??""}"),
                  Text("Prodcut Prices${ListProduct[index].unitePrices??""}"),
                  //Text("Unite Prices${ListProduct[index].??""}"),
                  Text("Total prices${ListProduct[index].totalPrices??""}"),

                ],
              ),
              trailing: PopupMenuButton<PopMenuType>(
                  onSelected: (type)=>onTapMenuType,
                  itemBuilder: (context)=>[
                PopupMenuItem(child: Text("Edit"),value: PopMenuType.edit,),
                PopupMenuItem(child: Text("deleted"),value: PopMenuType.deleted,),
              ]),
            );
          }),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>NewProdcutScreen()));
      }, label:Row(
        children: [
          Icon(Icons.add),
          Text('Add'),
        ],
      )),

    );
  }

  void onTapMenuType(PopMenuType type,Product product){
    switch(type){
      case PopMenuType.edit:
        Navigator.push(context  as BuildContext, MaterialPageRoute(builder: (context)=>EditeProduct(product: product,)));
        break;
      case PopMenuType.deleted:
        showAlertDiaglog(Product().id!);
        break;
    }
  }

  void showAlertDiaglog(String productId){
    showDialog(context: context  as BuildContext, builder: (context){
      return AlertDialog(
        title: Text('SHow Alert Diaglog'),
        content: Text('Add to new Digalog'),
        actions: [
          TextButton(onPressed: (){}, child: Text('cancel')),
          TextButton(onPressed: (){
            deletedGetApi(productId);
          }, child: Text("Deleted")),

        ],
      );
    });
  }
 Future<void>deletedGetApi(String productId) async {
    inprogress=true;
    setState(() {

    });
    Uri uri=Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/${productId}");
    Response response=await get(uri);
    print(response);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      getProductListAPi();


      }else{
      inprogress=false;
      setState(() {

      });
    }

 }
  Future<void>getProductListAPi() async {
    inprogress=true;
    setState(() {

    });
    Uri uri=Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response=await get(uri);
    print(response);
    print(response.body);
    print(response.statusCode);
    if(response.statusCode==200){
      var decoderesponse=jsonDecode(response.body);
      if(decoderesponse['status']=='success'){
        var list=decoderesponse['data'];
        for(var item in list){
          Product product=Product(
            id: item['_id'],
            productCOde: item['productCOde'],
            productName: item['productName'],
            qty: item['qty'],
            createDate: item['createDate'],
            Image: item['Image'],
            unitePrices: item['unitePrices'],
            totalPrices: item['totalPrices'],
          );
          ListProduct.add(product);
        }
        inprogress=false;
        setState(() {

        });
      }
    }

  }



}

