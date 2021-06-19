import 'package:coffee_app/bloc/coffee_bloc.dart';
import 'package:coffee_app/mocks/coffees.dart';
import 'package:coffee_app/screens/coffee_details_screen.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);
const _initialPage = 8.0;

class CoffeeMainScreen extends StatefulWidget {
  const CoffeeMainScreen({Key? key}) : super(key: key);

  @override
  _CoffeeMainScreenState createState() => _CoffeeMainScreenState();
}

class _CoffeeMainScreenState extends State<CoffeeMainScreen> {

  final bloc = CoffeeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
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
            child: ValueListenableBuilder<double>(
              valueListenable: bloc.currentPage,
              builder: (context, currentPage, _){
                return PageView.builder(
                    controller: bloc.pageController,
                    itemCount: coffees.length + 1,
                    scrollDirection: Axis.vertical,
                    onPageChanged: (value){
                      if(value < coffees.length){
                        bloc.pageTextController.animateToPage(value, duration: _duration, curve: Curves.easeInOut);
                      }
                    },
                    itemBuilder:(context, index){
                      if(index == 0){
                        return SizedBox.shrink();
                      }
                      final coffee = coffees[index - 1];
                      final result = currentPage - index + 1;
                      final value  = -0.4 * result + 1;
                      final opacity = value.clamp(0.0, 1.0);
                      print(result);
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 650),
                              pageBuilder:(context, animation, _){
                                return FadeTransition(
                                  opacity: animation,
                                  child: CoffeeDetailsScreen(coffee: coffee,),
                                );
                              }
                          )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..translate(0.0,_size.height/2.6 * (1 - value).abs())
                              ..scale(value),
                            child: Opacity(
                                opacity: opacity,
                                child: Hero(
                                    tag: coffee.name,
                                    child: Image.asset(coffee.image, fit: BoxFit.fitHeight,))),
                          ),
                        ),
                      );
                    }
                );
              },
            ),
          ),
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              height: 100,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 0.0),
                builder: (context, value, child){
                  return Transform.translate(
                      offset: Offset(0.0, -100 * value),
                    child: child,
                  );
                },
                duration: _duration,
                child: ValueListenableBuilder<double>(
                  builder: (context, textPage,  _){
                    return  Column(
                      children: [
                        Expanded(
                            child: PageView.builder(
                                itemCount: coffees.length,
                                controller: bloc.pageTextController,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                                  final opacity = 1- (index - textPage).abs().clamp(0.0, 1.0);
                                  return Opacity(
                                      opacity: opacity,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: _size.width * 0.2),
                                        child: Hero(
                                          tag: "text_${coffees[index].name}",
                                          child: Material(
                                            child: Text(coffees[index].name,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                              ),),
                                          ),
                                        ),
                                      ));
                                }
                            )
                        ),
                        if(textPage < coffees.length)
                          AnimatedSwitcher(
                            duration: _duration,
                            child: Text(
                              '\$${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 30.0
                              ),
                            ),
                            key: Key(coffees[textPage.toInt()].name),
                          )
                      ],
                    );
                  },
                  valueListenable: bloc.textPage,
                ),
              )
          ),
        ],
      ),
    );
  }
}
