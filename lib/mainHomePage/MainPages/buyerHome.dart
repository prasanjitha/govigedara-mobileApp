import 'package:carousel_pro/carousel_pro.dart';
import 'package:e_shop/Store/afterAddingCart.dart';
import 'package:e_shop/Store/newSellerStoreHome.dart';
import 'package:e_shop/Store/newSellerUploadItems.dart';
import 'package:e_shop/mainHomePage/urlLaunch/appDetails.dart';
import 'package:e_shop/youtubeVideos/youtubeVideos.dart';
import 'package:flutter/material.dart';

class buyerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.white, Colors.lightGreen[50]],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: ListView(
        children: [
          imageSlider,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Category",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Category(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Articles",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              //child: videoPlayer(),
            ),
          ),
          Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_outline_sharp, color: Colors.white),
                      Icon(Icons.star_border_sharp, color: Colors.white),
                      Icon(Icons.star_half, color: Colors.white),
                      Icon(Icons.star, color: Colors.white)
                    ],
                  ),
                  Text(
                    "Govigedara, Shopping Online & stay safe.",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.green)
        ],
      ),
    ));
  }

  Widget imageSlider = Container(
      color: Colors.white,
      width: 140,
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Carousel(
          images: [
            AssetImage("assets/images/homeSlider/m1.jpg"),
            AssetImage("assets/images/homeSlider/m2.png"),
            AssetImage("assets/images/homeSlider/m5.jpg"),
            AssetImage("assets/images/homeSlider/m3.jpg"),
            AssetImage("assets/images/homeSlider/s6.jpg"),
          ],
          autoplay: true,
          boxFit: BoxFit.fill,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(seconds: 2),
          dotColor: Colors.black,
          dotSize: 5,
        ),
      ));
}

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => StoreHome(
                      passedTitle: 'Vegetables',
                    ));
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 300,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 120,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Vegetables",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/fruits.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => StoreHome(
                      passedTitle: 'Fruits',
                    ));
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 120,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Fruits",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/vegitable.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => StoreHome(
                      passedTitle: 'Seasonal Fruits',
                    ));
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 160,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Sesonal Fruits",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/sesonalFruits.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => StoreHome(
                      passedTitle: 'Seasonal Vegetables',
                    ));
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 160,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Sesonal Vegi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/sesonalVegi.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => StoreHome(
                      passedTitle: 'Seeds',
                    ));
            Navigator.pushReplacement(context, route);
          },
          child: Container(
            height: 200,
            width: 200,
            child: Center(
                child: Container(
                    height: 40,
                    width: 100,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                        child: Text(
                      "Seeds",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage("assets/images/Catagory/seeds.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
        ),
        SizedBox(
          width: 2.0,
        ),
      ],
    );
  }
}
