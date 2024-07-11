import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Avatars
                CircleAvatar(
                  backgroundImage: AssetImage("assets/avatar.png"),
                  radius: 50,
                ),

                Text(
                  '蒋佳一',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "LiuJianMaoCao",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '不世出的文学大师',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MaShanZheng",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                // divider
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),

                // phone
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Align(
                      alignment: Alignment(-1.0, 1.0),
                      child: Text('18796718486'),
                    ),
                  ),
                ),

                // email
                Card(
                  color: Colors.white,
                  shadowColor: Colors.black,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Align(
                      alignment: Alignment(-1.0, 1.0),
                      child: Text('jiangjiayi1005@gamil.com'),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
