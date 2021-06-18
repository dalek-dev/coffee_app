import 'dart:math';

double _doubleInRange(Random source,num start, num end) => source.nextDouble() * (end - start) + start;

class Coffee{
  final String name;
  final String image;
  final double price;
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

final random = Random();
final coffees = List.generate(
    _names.length, (index) => Coffee(
  name: _names[index],
  image: 'assets/coffee_list/${index + 1}.png',
  price: _doubleInRange(random, 3, 7) )
);


final _names = [
  'CaramelCold drink',
  'Iced Coffee Mocka ',
  'Caramelized Pecan Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Caramel Machiatto',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
  'Coffeeee'
];