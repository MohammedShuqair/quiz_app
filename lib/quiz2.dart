import 'package:flutter/material.dart';

class Quize extends StatelessWidget {
  const Quize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.teal,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Name",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text("edit"),
                      SizedBox(
                        width: 20,
                      ),
                      Text("delete"),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Home Screen"))
              ],
            )
          ],
        ));
  }
}
