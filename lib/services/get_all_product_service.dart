import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:store/helper/api.dart';
import 'package:store/models/product_model.dart';



class GetAllProductsService{

  Future<List<ProductModel>> getAllProduct() async{

   //http.Response response=await http.get(Uri.parse('https://fakestoreapi.com/products'));
     List<dynamic> data = await Api().get(url:'https://fakestoreapi.com/products' );
    //if(response.statusCode==200){
    //List<dynamic> data =jsonDecode(response.body);
    List<ProductModel> productList=[];

    for(int i=0;i<data.length;i++){
           productList.add(ProductModel.fromjson(data[i]));
    }
     return productList;
    
    
  // }else{
  //   throw Exception(
  //     'there is a problem with ststus code ${response.statusCode}'); 
  // }

  }
}