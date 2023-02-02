import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage("assets/images/logo.png")),
                  SizedBox(
                    width: 5,
                  ),
                  Image(image: AssetImage("assets/icons/arrow-down.png"))
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: ImageIcon(AssetImage("assets/icons/heart.png"))),
                  SizedBox(width: 5),
                  IconButton(
                      onPressed: () {},
                      icon: ImageIcon(AssetImage("assets/icons/msg.png"))),
                  SizedBox(width: 5),
                  IconButton(
                      onPressed: () {},
                      icon: ImageIcon(AssetImage("assets/icons/plus.png"))),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10),
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
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  gradient: LinearGradient(
                                      colors: [Colors.red, Colors.amber],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.circular(60)),
                            ),
                            Container(
                              width: 71,
                              height: 71,
                              decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.white, width: 3),
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
        Divider(
          height: 20,
          color: Colors.grey,
        ),
        SizedBox(height: 10),
        PostsWidget(),
        PostsWidget(),
      ],
    ));
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              gradient: LinearGradient(
                                  colors: [Colors.red, Colors.amber],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(60)),
                        ),
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 3),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://picsum.photos/id/1/500/500"))),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Muhammad Azmi Fauzi",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Bekasi, Jawa Barat",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: ImageIcon(AssetImage("assets/icons/threedot.png")))
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 390,
          child: Image(
            image: NetworkImage("https://picsum.photos/500/500"),
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon:
                        ImageIcon(AssetImage("assets/icons/heart-active.png"))),
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage("assets/icons/comment.png"))),
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(AssetImage("assets/icons/reply.png"))),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: ImageIcon(AssetImage("assets/icons/archive.png"))),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "100 Likes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  text: "username ",
                  children: [
                TextSpan(
                    text:
                        "Username Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt... ",
                    style: TextStyle(fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                          text: "more",
                          style: TextStyle(color: Colors.grey[500])),
                    ])
              ])),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text("View all 16 comments",
              style: TextStyle(color: Colors.grey[500], fontSize: 16)),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
