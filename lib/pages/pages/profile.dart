import 'package:flutter/material.dart';
import 'sidemenu.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final List<String> imageUrls = [
    'assets/profile1.png',
    'assets/profile2.png',
    'assets/profile3.png',
    // Add more image URLs as needed
  ];

  int _currentImageIndex = 0;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String aboutUsPreview =
        "Here are the first few lines of the About Us content...";
    String aboutUsFull =
        "Here is the full About Us content with all the details that you want to show when the card is expanded...";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 40),
            child: Text(
              'Profile Details',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.black), // Set the back arrow color to black
            onPressed: () {},
          ),
          // backgroundColor: Color(0xFF6a9739),
        ),
        drawer: Sidemenu(),
        body: Column(
          children: [
            Expanded(
                // This will contain the stack
                child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 500,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: imageUrls.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  top: 250.0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Nira Manisha,',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(
                              width: 10), // Spacing between the text widgets
                          Text(
                            '23',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D6D6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Vadalia NYC',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageUrls.map((url) {
                          int index = imageUrls.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == index
                                  ? Colors.red // Active dot color
                                  : Colors.grey, // Inactive dot color
                            ),
                          );
                        }).toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: () {},
                            child: Image.asset('call.png',
                                width: 20, height: 20, color: Colors.white),
                            backgroundColor: Color(0xFFff0068),
                            elevation: 6.0,
                            highlightElevation: 8.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Image.asset('zoom.png',
                                width: 20, height: 20, color: Colors.white),
                            backgroundColor: Color(0xFFff0068),
                            elevation: 6.0,
                            highlightElevation: 8.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {},
                            child: Image.asset('chat.png',
                                width: 20, height: 20, color: Colors.white),
                            backgroundColor: Color(0xFFff0068),
                            elevation: 6.0,
                            highlightElevation: 8.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
            GestureDetector(
              onTap: () => setState(() {
                isExpanded = !isExpanded;
              }),
              child: Card(
                elevation: 4.0, // Adjust the elevation as needed
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      isExpanded
                          ? Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.email),
                                  title: Text('Email'),
                                  subtitle: Text('nira.manisha@example.com'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.phone),
                                  title: Text('Phone'),
                                  subtitle: Text('+1234567890'),
                                ),
                                // Add more ListTiles or other widgets as needed
                              ],
                            )
                          : Text(
                              aboutUsPreview,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ExpandIcon(
                          isExpanded: isExpanded,
                          onPressed: (bool isExpanded) => setState(() {
                            this.isExpanded = !this.isExpanded;
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
