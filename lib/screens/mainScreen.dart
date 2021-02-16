import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/images/Logo.png',
                width: mediaQueryForWidth(_mediaQuery, 0.9),
                height: mediaQueryForHeight(_mediaQuery, 0.5),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: mediaQueryForWidth(_mediaQuery, 0.26),vertical: mediaQueryForHeight(_mediaQuery, 0.05)),
              height: mediaQueryForHeight(_mediaQuery, 0.085) +
                  (_mediaQuery.orientation == Orientation.landscape ? 15 : 0),
              width: mediaQueryForWidth(_mediaQuery, 0.44),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 1,
                //     blurRadius: 2,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
              ),
              child: CupertinoButton(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[700],
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/log');
                  }),
            ),
            Container(
              alignment: Alignment.center,
              height: mediaQueryForHeight(_mediaQuery, 0.085) +
                  (_mediaQuery.orientation == Orientation.landscape ? 15 : 0),
              width: mediaQueryForWidth(_mediaQuery, 0.44),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 3,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
              ),
              child: CupertinoButton(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.grey[700],
                  child: Container(
                    child: FittedBox(
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/reg');
                  }),
            ),
          ],
        ),
      ),
    );
  }

  mediaQueryForHeight(MediaQueryData mediaQuery, double ratio) {
    return (mediaQuery.size.height - mediaQuery.padding.top) * ratio;
  }

  mediaQueryForWidth(MediaQueryData mediaQuery, double ratio) {
    return (mediaQuery.size.width * ratio);
  }
}
