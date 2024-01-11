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
    
  }

  goLogin () {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    List slideContents = [
      {
        "title": "Open Minded",
        "content":
            "Looks at matches for more personality and values/beliefs rather than just looks",
      },
      {
        "title": "Open Minded",
        "content":
            "Looks at matches for more personality and values/beliefs rather than just looks",
      },
      {
        "title": "Open Minded",
        "content":
            "Looks at matches for more personality and values/beliefs rather than just looks",
      }
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
                height: 90,
                fit: BoxFit.contain,
                alignment: Alignment(0, 0),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider.builder(
                itemCount: slideContents.length,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval:
                      Duration(seconds: 2), // Slide changes every 1 second
                  autoPlayAnimationDuration: Duration(
                      milliseconds: 800), // Slide animation lasts 0.8 seconds
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  enlargeFactor : 0.3,
                  aspectRatio: 1,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    index == 2 ? goLogin() : null;
                  },
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          slideContents[index]["title"].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.pink.shade700,
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          slideContents[index]["content"].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   onPressed :() { }, child: Text("Get Started")
            // )
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
