import 'package:coffee_app/mocks/coffees.dart';
import 'package:flutter/material.dart';

class CoffeeDetailsScreen extends StatefulWidget {
  const CoffeeDetailsScreen({Key? key, this.coffee}) : super(key: key);

  final Coffee? coffee;

  @override
  _CoffeeDetailsScreenState createState() => _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends State<CoffeeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _size.width * 0.2),
            child: Hero(
              tag: "text_${widget.coffee!.name}",
              child: Material(
                child: Text(
                  widget.coffee!.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(
            height: _size.height * 0.4,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Hero(
                        tag:  widget.coffee!.name,
                        child: Image.asset(widget.coffee!.image, fit: BoxFit.fitHeight,)
                    ),
                ),
                Positioned(
                  left: _size.width * 0.05,
                    bottom: 0.0,
                    child:TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: Duration(milliseconds: 500),
                        builder: (context, value, child){
                          return Transform.translate(
                            offset: Offset(-100 * value, 150 * value),
                            child: child,
                          );
                        },
                      child: Text(
                          '\$${widget.coffee!.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              spreadRadius: 20.0
                            )
                          ]
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
