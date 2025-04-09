import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget{
  final Product product;

  const ProductItem({required this.product});

  @override
  Widget build(BuildContext context){
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(
        product.title,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        width: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product
                );
              },
              icon: Icon(Icons.edit) 
            ),
            IconButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (ctx) => AlertDialog(
                    title: Text("Excluir o produto"),
                    content: Text("Tem certeza?"),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(ctx).pop();
                        }, 
                        child: Text("Não"),
                      ),
                      TextButton(
                        onPressed: () async {
                          try{
                            Navigator.of(ctx).pop();
                            Provider.of<ProductList>(context, listen: false).removeProduct(product);
                          } catch(error){
                            msg.showSnackBar(
                              SnackBar(
                                content: Text(error.toString()) 
                              )
                            );
                          }
                        }, 
                        child: Text("Sim"),
                      ),
                    ],
                  )
                );
              }, 
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ) 
            )
          ],
        ),
      ),
    );
  }
}