

import 'dart:convert';

import 'package:curdopertation/screen/productlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'editscreen.dart';
class NewProdcutScreen extends StatefulWidget {
  const NewProdcutScreen({super.key});

  @override
  State<NewProdcutScreen> createState() => _NewProdcutScreenState();
}

class _NewProdcutScreenState extends State<NewProdcutScreen> {
  final TextEditingController imagecon=TextEditingController();
  final TextEditingController proNameductcon=TextEditingController();
  final TextEditingController quntiycon=TextEditingController();
  final TextEditingController unicon=TextEditingController();
  final TextEditingController qtycon=TextEditingController();
   final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
   bool inprogress=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New prodcut Screen"),
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

                   Visibility(
                     visible: inprogress=false,
                     replacement: Center(child: CircularProgressIndicator()),
                     child: SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(onPressed: (){
                           if(_formkey.currentState!.validate()){
                             CreateProduct();
                           }
                         }, child: Text('Add'))),
                   ),

                 ],
               ),
             ),
           ),
         ),
    );
  }
  
  Future<void>CreateProduct() async {
     inprogress=true;
    setState(() {

    });
    Uri uri =Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
    Map<String,dynamic>params={
      "Img":imagecon.text,
      "ProductCode":qtycon.text,
      "ProductName":proNameductcon.text,
      //"Qty":qtycon,
      "TotalPrice":quntiycon.text,
      "UnitPrice":unicon.text,
    };

   Response response= await post(uri,body:jsonEncode(params),headers: {
     "Content-Type":"application/json",
   });
   if(response.statusCode==200){
     imagecon.clear();
     qtycon.clear();
     proNameductcon.clear();
     //qtycon.clear();
     quntiycon.clear();
     unicon.clear();

   }
   inprogress=false;
   setState(() {

   });
  }
  
}


