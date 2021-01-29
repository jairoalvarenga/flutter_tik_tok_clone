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
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

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
                      color: Colors.red,
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
      child: PageView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return postBuilder(index);
        },
      ),
    );
  }
}
