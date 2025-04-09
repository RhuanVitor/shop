import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget{
  const ProductFormPage({Key? key}) : super(key: key);  

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();

    if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;

      if(arg != null){
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose(){
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage(){
    setState(() {});
  }

  Future<void> _subtmitForm() async{
    final isValid = _formKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });
    try{
      await Provider.of<ProductList>(
      context, listen: false
      ).saveProduct(_formData);
    } catch(error){
      await showDialog<void>(
        context: context, 
        builder: (ctx) => AlertDialog(
          title: Text("Ocorreu um erro!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok")
            )
          ],
        )
      );
    } finally{
      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pop();
    }
  }
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de produto"),
        actions: [
          IconButton(
            onPressed: () => _subtmitForm(), 
            icon: Icon(Icons.save)
          )
        ],
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      )
      : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                crossAxisAlignment:CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(label: Text("Url da imagem")),
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl){
                        final imageUrl = _imageUrl ?? '';

                        if(imageUrl.trim().isEmpty){
                          return "A url da imagem do produto é obrigatória";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container( 
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey)
                    ),
                    child: _imageUrlController.text.isEmpty ? Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 30,
                      )
                    )
                    :
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                        _imageUrlController.text,
                        errorBuilder:(context, error, stackTrace) => Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                color: Colors.red,
                                size: 40,
                              ),
                              Text(
                                "Imagem invalida",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
              TextFormField(
                initialValue: _formData['title']?.toString(),
                decoration: InputDecoration(label: Text("Titulo")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (title) => _formData['title'] = title ?? '',
                validator: (_title){
                  final title = _title ?? '';

                  if(title.trim().isEmpty){
                    return "É obrigatório um nome para o produto";
                  }

                  if(title.trim().length < 5){
                    return "O nome preciso ter no minimo 5 caracteres";
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: InputDecoration(label: Text("Preço")),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true
                ),
                onSaved: (price) => _formData['price'] = double.parse(price ?? '0'),
                validator: (_price){
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if(priceString.trim().isEmpty){
                    return "É obrigatório um preço para o produto";
                  }
                  if(price <= 0){
                    return "O preço nao pode ser menor ou igual a 0";
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString() ,
                decoration: InputDecoration(label: Text("Descrição")),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 1500,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _subtmitForm(),
                onSaved: (description) => _formData['description'] = description ?? '',
                validator: (_description){
                  final description = _description ?? '';

                  if(description.trim().isEmpty){
                    return "É obrigatória uma descrição para o produto";
                  }

                  if(description.trim().length < 50){
                    return "A descrição precisa ter no minimo 50 caracteres";
                  }
                 return null;
                }
              )
            ],
          )
        ),
      )
    );
  }
}