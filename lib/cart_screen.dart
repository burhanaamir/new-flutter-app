import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final TextEditingController pName = TextEditingController();
  final TextEditingController pPrice = TextEditingController();
  List category = ["Shirts", "Glasses", "Caps", "Watches", "Bottles", "Shoes"];
  dynamic defaulValue = "Shirts";


  void addProduct()async{
    await FirebaseFirestore.instance.collection("Products").add({
      "producName" : pName.text,
      "productPrice" : pPrice.text,
      "productCate" : defaulValue
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Added")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text("Cart Screen"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: pName,
                    decoration: InputDecoration(
                        hintText: "Enter Product Name"
                    ),
                  ),

                  SizedBox(height: 10,),

                  TextFormField(
                    controller: pPrice,
                    decoration: InputDecoration(
                        hintText: "Enter Product Price"
                    ),
                  ),

                  SizedBox(height: 10,),

                  DropdownButton(
                    hint: Text('Please choose a Category'), // Not necessary for Option 1
                    value: defaulValue,
                    onChanged: (newValue) {
                      setState(() {
                        defaulValue = newValue;
                        debugPrint(defaulValue);
                      });
                    },
                    items: category.map((val) {
                      return DropdownMenuItem(
                        child: new Text(val),
                        value: val,
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 10,),

                  ElevatedButton(onPressed: (){
                    addProduct();
                  }, child: Text("Add Product"))
                ],
              ),
            );
          },);
        },);
      }, child: Icon(Icons.add),),
    );
  }
}