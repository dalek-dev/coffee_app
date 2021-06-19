import 'package:coffee_app/bloc/coffee_bloc.dart';
import 'package:coffee_app/mocks/coffees.dart';
import 'package:coffee_app/screens/coffee_main_screen.dart';
import 'package:flutter/material.dart';

class CoffeeHomeScreen extends StatefulWidget {
  const CoffeeHomeScreen({Key? key}) : super(key: key);

  @override
  _CoffeeHomeScreenState createState() => _CoffeeHomeScreenState();
}

class _CoffeeHomeScreenState extends State<CoffeeHomeScreen> {

  final bloc = CoffeeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose(){
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return CoffeeProvider(
      bloc:bloc,
      child: Scaffold(
        body: GestureDetector(
          onVerticalDragUpdate: (details){
            if(details.primaryDelta! < -20){
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 650),
                  pageBuilder:(context, animation, _){
                    return FadeTransition(
                        opacity: animation,
                      child: CoffeeMainScreen(),
                    );
                  }
              )
              );
            }
          },
          child: Stack(
            children: [
              SizedBox.expand(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFA89276),
                          Colors.white
                        ]
                      )
                    )
                ),
              ),
              Positioned(
                height: _size.height * 0.4,
                left: 0.0,
                right: 0.0,
                top: _size.height * 0.15,
                child: Hero(
                    tag: coffees[6].name,
                    child: Image.asset(coffees[6].image)
                ),
              ),
              Positioned(
                height: _size.height * 0.7,
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Hero(
                    tag: coffees[7].name,
                    child: Image.asset(coffees[7].image,
                    fit: BoxFit.cover,
                    )
                ),
              ),
              Positioned(
                height: _size.height,
                left: 0.0,
                right: 0.0,
                bottom: -_size.height * 0.8,
                child: Hero(
                    tag: coffees[9].name,
                    child: Image.asset(coffees[9].image,fit: BoxFit.cover,)
                ),
              ),
              Positioned(
                height: 140.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: _size.height * 0.25,
                  child: Image.asset('assets/logo.png')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
