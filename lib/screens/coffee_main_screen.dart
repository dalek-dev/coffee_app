import 'package:coffee_app/mocks/coffees.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class CoffeeMainScreen extends StatefulWidget {
  const CoffeeMainScreen({Key? key}) : super(key: key);

  @override
  _CoffeeMainScreenState createState() => _CoffeeMainScreenState();
}

class _CoffeeMainScreenState extends State<CoffeeMainScreen> {

  final _pageController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  final _pageTextController = PageController(initialPage: _initialPage.toInt());

  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeeScrollListener(){
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  void _textScrollListener() {
    setState(() {
      _textPage = _currentPage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pageController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageTextController.removeListener(_textScrollListener);
    _pageController.removeListener(_coffeeScrollListener);
    _pageTextController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20.0,
            right: 20.0,
              bottom: -_size.height * 0.42,
              top: _size.height * 0.33,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown,
                        blurRadius: 90,
                        spreadRadius: 15,
                      )
                    ]
                  )
              ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
              controller: _pageController,
              itemCount: coffees.length + 1,
                scrollDirection: Axis.vertical,
                onPageChanged: (value){
                  if(value < coffees.length){
                    _pageTextController.animateToPage(value, duration: _duration, curve: Curves.easeInOut);
                  }
                },
                itemBuilder:(context, index){
                if(index == 0){
                  return SizedBox.shrink();
                }
                  final coffee = coffees[index - 1];
                  final result = _currentPage - index + 1;
                  final value  = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  print(result);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(0.0,_size.height/2.6 * (1 - value).abs())
                      ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                          child: Image.asset(coffee.image, fit: BoxFit.fitHeight,)),
                    ),
                  );
                }
            ),
          ),
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 100,
                child: Column(
                  children: [
                    Expanded(
                        child: PageView.builder(
                          itemCount: coffees.length,
                            controller: _pageTextController,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                            final opacity = 1- (index - _textPage).abs().clamp(0.0, 1.0);
                            return Opacity(
                              opacity: opacity,
                                child: Text(coffees[index].name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),));
                            }
                        )
                    ),
                    if(_currentPage < coffees.length)
                    AnimatedSwitcher(
                      duration: _duration,
                        child: Text(
                            '\$${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 30.0
                          ),
                        ),
                      key: Key(coffees[_currentPage.toInt()].name),
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
