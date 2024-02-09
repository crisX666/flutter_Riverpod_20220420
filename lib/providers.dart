//We can put the title provider in a different file, and still be able to access it on the Titlepage
//proveedor de... cosas
import 'package:flutter_riverpod/flutter_riverpod.dart';

final title = Provider<String>((ref) => "RAAAWWR");
class Product{
  Product({required this.name, required this.price});

  final String name;
  final double price;
}

final _products = [
    Product(name: "Spaghetti", price: 10),
    Product(name: "Indomie", price: 6),
    Product(name: "Fried Yam", price: 9),
    Product(name: "Beans", price: 10),
    Product(name: "Red Chicken Feet", price: 2),
    Product(name: "Lasagna", price: 12),
    Product(name: "Ramen Noodles", price: 8),
    Product(name: "Sweet Potato Fries", price: 7),
    Product(name: "Black Beans", price: 11),
    Product(name: "Grilled Chicken Wings", price: 5),
    Product(name: "Spicy Meatballs", price: 13),
    Product(name: "Rice Vermicelli", price: 9),
    Product(name: "Plantain Chips", price: 4),
    Product(name: "Chickpeas", price: 8),
    Product(name: "BBQ Chicken Skewers", price: 15),
];
enum ProductSortType{
  name,
  price,
}
//This is the default sort type when the app is run
final productSortTypeProvider = StateProvider<ProductSortType>((ref) => 
ProductSortType.name);
final futureProductsProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final sortType = ref.watch(productSortTypeProvider);
switch (sortType) {
    case ProductSortType.name:
       _products.sort((a, b) => a.name.compareTo(b.name));
       break;
    case ProductSortType.price:
       _products.sort((a, b) => a.price.compareTo(b.price));
}
  return _products;
});
