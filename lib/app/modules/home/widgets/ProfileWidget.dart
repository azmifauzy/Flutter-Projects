import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          // appBar Home
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "username",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.add_box_outlined)),
                    SizedBox(width: 5),
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                )
              ],
            ),
          ),

          // profile info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  width: 95,
                  height: 95,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            gradient: LinearGradient(
                                colors: [Colors.red, Colors.amber],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(60)),
                      ),
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://picsum.photos/536/354")),
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(color: Colors.white, width: 4)),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DataProfile(title: "Posts", total: "23".toString()),
                    DataProfile(title: "Followers", total: "2.5K".toString()),
                    DataProfile(title: "Following", total: "754".toString())
                  ],
                ))
              ],
            ),
          ),
          SizedBox(height: 15),
          // username
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "username",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(height: 7),
          // username
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.grey[700]),
                    text:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    children: [
                  TextSpan(
                    style: TextStyle(color: Colors.blue[700]),
                    text: " #hashtag\n",
                  ),
                  TextSpan(
                    style: TextStyle(color: Colors.blue[700]),
                    text: "Link goes here",
                  ),
                ])),
          ),
          SizedBox(height: 15),
          // Button Edit Profile
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
          ),
          SizedBox(height: 5),
          // Stories
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 100,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              Container(
                                width: 71,
                                height: 71,
                                decoration: BoxDecoration(
                                    color: Colors.grey[700],
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://picsum.photos/id/${index + 544}/500/500"))),
                              ),
                            ],
                          ),
                        ),
                        Text("Story ${index + 1}")
                      ],
                    )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.grid_on)),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.person_pin_outlined))
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 50,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemBuilder: (context, index) => Image.network(
                  "https://picsum.photos/id/${64 + index}/500/500"))
        ],
      ),
    );
  }
}

class DataProfile extends StatelessWidget {
  const DataProfile({super.key, required this.title, required this.total});

  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          total,
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
        Text(title),
      ],
    );
  }
}
