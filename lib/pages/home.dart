import 'package:flutter/material.dart';
import 'package:datingapp/pages/login.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      // After 3 seconds, navigate to the login page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> slideContents = [
      'Open Minded\nLooks at matches for more personality and values/beliefs rather than just looks',
      // Add more slide text contents here
    ];
    return Scaffold(
      body: // Generated code for this PlaceholderWidget Widget...
          Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/initial.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logo.png',
                width: 300,
                height: 155,
                fit: BoxFit.contain,
                alignment: Alignment(0, 0),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.121,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider.builder(
                itemCount: slideContents.length,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval:
                      Duration(seconds: 1), // Slide changes every 1 second
                  autoPlayAnimationDuration: Duration(
                      milliseconds: 800), // Slide animation lasts 0.8 seconds

                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 0,
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        slideContents[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContentPage(String title, String content) {
    return Container(
      // width : double.infinity / 3,
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
          // color: Colors.white
          ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24),
            ),
            Text(
              content,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: EdgeInsets.all(8),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
