import 'package:flutter/material.dart';

const _initialPage = 8.0;

class CoffeeBloc{
  final pageController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  final pageTextController = PageController(initialPage: _initialPage.toInt());

  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void _coffeeScrollListener(){
      currentPage.value = pageController.page!;
  }

  void _textScrollListener() {
      textPage.value = pageTextController.page!;
  }

  void init(){
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollListener);
  }

  void dispose(){
    pageTextController.removeListener(_textScrollListener);
    pageController.removeListener(_coffeeScrollListener);
    pageTextController.dispose();
    pageController.dispose();
  }

}

class CoffeeProvider extends InheritedWidget{

  final CoffeeBloc bloc;

  CoffeeProvider({required this.bloc, required Widget child}) : super(child: child);

  static CoffeeProvider of(BuildContext context) => context.findAncestorWidgetOfExactType<CoffeeProvider>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget)  => false;
}