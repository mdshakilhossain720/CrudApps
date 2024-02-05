import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'model_product/productrlist.dart';
class EditeProduct extends StatefulWidget {
  const EditeProduct({super.key, required this.product});

  final Product product;

  @override
  State<EditeProduct> createState() => _EditeProductState();
}

class _EditeProductState extends State<EditeProduct> {
  final TextEditingController imagecon=TextEditingController();
  final TextEditingController proNameductcon=TextEditingController();
  final TextEditingController quntiycon=TextEditingController();
  final TextEditingController unicon=TextEditingController();
  final TextEditingController qtycon=TextEditingController();
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
bool inprogress=false;
  @override
  void initState() {
    imagecon.text=widget.product.Image?? "";
    quntiycon.text=widget.product.qty?? "";
    unicon.text=widget.product.unitePrices?? "";
    qtycon.text=widget.product.totalPrices?? "";
    //.text=widget.product.Image?? "";
    proNameductcon.text=widget.product.productName??"";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit prodcut Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                    controller: proNameductcon,
                    decoration: InputDecoration(
                      hintText: 'ProductName',
                      labelText: 'Producr name',
                    ),
                    validator: (String?value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'enter your Prodcu Name';
                      }
                    }
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: imagecon,
                  decoration: InputDecoration(
                    hintText: 'Product Image',
                    labelText: 'Product Image',
                  ),
                  validator: (String ? value){
                    if(value?.trim().isEmpty?? true){
                      return 'enter your image';
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: quntiycon,
                  decoration: InputDecoration(
                      hintText: 'Product qunty',
                      labelText: 'Prodcut quntiy'
                  ),

                  validator: (String?value){
                    if(value?.trim().isEmpty?? true){
                      return 'enter your qunity';
                    }
                  },
                ),

                SizedBox(height: 10,),
                TextFormField(
                  controller: unicon,
                  decoration: InputDecoration(
                      hintText: 'Unite Prices',
                      labelText: 'Uniteprices'
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty??true){
                      return 'enter your prices';
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: qtycon,
                  decoration: InputDecoration(
                    hintText: 'qty',
                    labelText: 'qty',
                  ),
                  validator: (String?value){
                    if(value?.trim().isEmpty?? true){
                      return 'enter your qty';
                    }
                  },
                ),
                SizedBox(height: 10,),

                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      if(_formkey.currentState!.validate());
                    }, child: Text('Edit'))),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future <void> UpdateProduct() async {
    inprogress=true;
    Uri uri=Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}");
    Map<String,dynamic>params={
      "Img":imagecon.text,
      "ProductCode":quntiycon.text,
      "ProductName":proNameductcon.text,
      "Qty":qtycon.text,
     // "TotalPrice":,
      "UnitPrice":unicon.text,
      '_id':widget.product.id,

    };
  final Response response=await post(uri,body:jsonEncode(params) ,headers: {

  });
  if(response.statusCode==200){
    final decoed=jsonDecode(response.body);
    if(decoed['status']=='success'){
     Navigator.pop(context);
    }else{

    }
  }

    
  }

}