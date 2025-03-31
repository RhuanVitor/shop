import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatefulWidget{
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  bool _addedToCart = false;

  Widget build(BuildContext context){
    final Product product = Provider.of<Product>(
      context,
      listen: false
    );

    final Cart cart = Provider.of<Cart>(
      context,
      listen: false
    );

    return InkWell(
      onTap: (){
      Navigator.of(context).pushNamed(
        AppRoutes.PRODUCT_DETAIL,
          arguments: product,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 238, 238, 238)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                product.imageUrl,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2,),
                child: Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  textAlign: TextAlign.start,
                  'R\$ ${product.price.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.deepPurple
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(_addedToCart == false)
                  TextButton(
                    onPressed: (){
                      cart.addItem(product);
                      setState(() {
                        _addedToCart = true;
                      });
                    }, 
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 45, 172, 49),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero
                      ),
                      minimumSize: Size(140, 20)
                    ),
                    child: Text(
                      "Adicionar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
      
                  if(_addedToCart == true)
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 140,
                    child: Text("Adicionado"),
                  )
                ],
              )
            ],
          ),
        ),
      
      
      
      
      
      
      
      
      
      
      
      
      
        // child: GridTile(
        //   footer: GridTileBar(
        //     title: Text(
        //       product.title, 
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white
        //       ),
        //       ),
        //     backgroundColor: const Color.fromARGB(190, 0, 0, 0),
            
        //     leading: Consumer<Product>(
        //       builder: (ctx, product, _) => IconButton(
        //         onPressed: (){
        //           product.toggleFavorite();
        //         }, 
        //         icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
        //         color: Colors.redAccent
        //       ),
        //     ),
      
        //     trailing: IconButton(
        //       onPressed: (){
        //         cart.addItem(product);
        //       }, 
        //       icon: Icon(Icons.shopping_cart),
        //       color: Colors.white
        //     ),
        //   ),
        //   child: GestureDetector(
        //     child: Image.network(
        //       product.imageUrl,
        //       fit: BoxFit.cover,
        //     ),
        //     onTap: (){
        //       Navigator.of(context).pushNamed(
        //         AppRoutes.PRODUCT_DETAIL,
        //         arguments: product,
        //       );
        //     },
        //   ),
        // ),
      
      
      
      
      
      ),
    );
  }
}