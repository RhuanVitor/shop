import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';
import 'package:shop/models/product.dart';

class OrderWidget extends StatefulWidget{
  final Order order;

  const OrderWidget({Key ? key, required this.order}) : super(key:key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context){
    return Card(

      child: Column(
        children: [
          ListTile(
            onTap: (){
              setState(() {
                _expanded = !_expanded;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 27,
                      width: 94,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 145, 145, 145)
                      ),
                      child: Text(
                        widget.order.id,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 15
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd/mm/yyyy hh:mm').format(widget.order.date),
                      style: TextStyle(
                      color: const Color.fromARGB(255, 90, 90, 90),
                      fontSize: 13
                      ),
                    ),
                  ],
                ),

                if(!_expanded) 
                Text(
                  'R\$ ${widget.order.total}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: const Color.fromARGB(255, 90, 90, 90)
                  ),
                ),
              ],
            ),

            trailing: IconButton(
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more)
            ),
          ),

          if(_expanded) Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4
            ),
            height: widget.order.products.length * 25 + 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: widget.order.products.map(
                      (product){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name
                            ),
                            Text(
                              '${product.quantity}x R\$ ${product.price}'),
                          ],
                        );
                      }
                    ).toList()
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text('Total: R\$ ${widget.order.total}'),
                    )
                  ],
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}