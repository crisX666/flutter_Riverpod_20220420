import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_20220420/providers.dart';

//widget modificado
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goofy Ahhh RiverPod',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ProductPage(),
    );
  }
}

void main() {
   runApp(
     const ProviderScope(
       child: MyApp(),
     ),
   );
 }

 //consumer
 class ProductPage extends ConsumerWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final productsProvider = ref.watch(futureProductsProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Lista (desde) provider"),
          actions: [
            DropdownButton<ProductSortType>(
              dropdownColor: Colors.white70,
              value: ref.watch(productSortTypeProvider),
                items: const [
                  DropdownMenuItem(
                    value: ProductSortType.name, 
                    child: Icon(Icons.sort_by_alpha, color: Colors.black54), 
                ),
                  DropdownMenuItem(
                    value: ProductSortType.price,
                    child: Icon(Icons.sort, color: Colors.black54),
                  ),
                ],
                onChanged: (value)=> ref.watch(productSortTypeProvider.notifier).state = value!
            ),
          ],
        ),
      backgroundColor: Colors.grey,
      body: Container(
        child: productsProvider.when(
            data: (products)=> ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Card(
                      color: Colors.blueGrey,
                      elevation: 3,
                      child: ListTile(
                        title: Text("Producto: ${products[index].name}",style: const TextStyle(
                            color: Colors.white,  fontSize: 15)),
                        subtitle: Text("Precio: \$${products[index].price}",style: const TextStyle(
                            color: Colors.white,  fontSize: 15)),
                      ),
                    ),
                  );
                }),
            error: (err, stack) => Text("Error: $err",style: const TextStyle(
                color: Colors.white,  fontSize: 15)),
            loading: ()=> const Center(child: CircularProgressIndicator(color: Colors.white,)),
        ),
      )
    );
  }
}

