import 'package:flutter/material.dart';

//static resources
import '../constants/posts_json.dart';
import '../constants/textStyles.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    posts.addAll(arrayOfposts);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    Widget iconBuilder({IconData icon, String label, double iconSize = 45.0}) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Colors.white,
            ),
            SizedBox(
              height: 3.0,
            ),
            Text(
              label,
              style: heartTextStyle,
            )
          ],
        ),
      );
    }

    Widget postBuilder(int index) {
      return Stack(
        children: [
          Container(
            width: screenWidth,
            height: double.infinity,
            child: Image.network(
              posts[index]['backgroundUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: screenWidth,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                //Right Panel
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      height: 380.0,
                      width: 80.0,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //profile image with follow button
                          Container(
                            height: 73.0,
                            width: 65.0,
                            // color: Colors.green,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60.0,
                                    width: 60.0,
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.network(
                                        posts[index]['profileImg'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 18.0,
                                  child: Container(
                                    height: 28.0,
                                    width: 28.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      color: Colors.red,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 23.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //favorites button and info
                          iconBuilder(
                            icon: Icons.favorite,
                            label: posts[index]['likes'],
                          ),
                          iconBuilder(
                              icon: Icons.chat,
                              label: posts[index]['comments'],
                              iconSize: 40.0),
                          iconBuilder(icon: Icons.reply, label: 'Share'),
                        ],
                      ),
                    )
                  ],
                ),
                //Bottom Panel
                Container(
                  width: screenWidth,
                  padding:
                      EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      //left side
                      //user information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              '@${posts[index]['name']}',
                              style: userNameTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              posts[index]['caption'],
                              style: descriptionTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              posts[index]['songName'],
                              style: songTextStyle,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      //right side
                      //album with image
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15.0),
                            margin: EdgeInsets.only(top: 10.0),
                            height: 65.0,
                            width: 65.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF000000),
                                    const Color(0xFF292929),
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                posts[index]['albumImg'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
          //builder
          //shows individual post
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              var nextPage = index + 2;
              var postsLength = posts.length;

              if (nextPage > postsLength) {
                setState(() {
                  posts.addAll(arrayOfposts);
                });
                print('Total Posts ${posts.length}');
              }
            },
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return postBuilder(index);
            },
          ),
          //page top tab bar
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Following',
                      style: pageTabBarUnselectedStyle,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    SizedBox(
                      height: 18.0,
                      child: VerticalDivider(
                        thickness: 1.0,
                        color: Colors.white38,
                      ),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      'For You',
                      style: pageTabBarSelectedStyle,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
