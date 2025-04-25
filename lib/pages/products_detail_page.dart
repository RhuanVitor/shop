import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/models/product.dart';

class ProductsDetailPage extends StatefulWidget{

  @override
  State<ProductsDetailPage> createState() => _ProductsDetailPageState();
}

class _ProductsDetailPageState extends State<ProductsDetailPage> {
  bool _addedToCart = false;
  
  @override
  Widget build(BuildContext context){
    final auth = Provider.of<Auth>(context);
    final String? auth_token = auth.token;
    final String? auth_uid = auth.uid;

    final Cart cart = Provider.of<Cart>(
      context,
      listen: false
    );

    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feira Da Madrugada SP",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          Consumer<Cart>(
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(
                    AppRoutes.CART_PAGE
                  );
                }, 
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )
              ),
            ),
          )
        ],
        backgroundColor: Colors.deepPurple
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      product.toggleFavorite(auth_token, auth_uid);
                    });
                  }, 
                  icon: product.isFavorite ? Icon(Icons.favorite, color: Colors.redAccent,) : Icon(Icons.favorite_border)
                )
              ],
            ),
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imageUrl, fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                product.title,
                softWrap: true,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            SizedBox(height:5),
            Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'R\$ ${product.price}',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  cart.addItem(product);
                  setState(() {
                    _addedToCart = true;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 45, 172, 49),
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    
                  )
                ),
                child: Text(
                  "Comprar agora",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            if(_addedToCart == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 300,
                  child: Text(
                    "Item adicionado ao carrinho!",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey
                    ),
                  )
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Detalhes do produto: ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                product.description
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}