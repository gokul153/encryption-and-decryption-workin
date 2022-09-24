import 'package:flutter/material.dart';
import 'package:ui/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      gotohome();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image.asset(
                "D:/PROJECT/Status@colorandbuttton/kryptit/assets/images'/slashsample.jpeg")));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotohome() async {
    print("delay function is intiated");
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      print("navigation");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => Home_screen()));
    });
    /*  await Future.delayed(Duration(seconds: 3));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => Home_screen()));*/
  }
}
