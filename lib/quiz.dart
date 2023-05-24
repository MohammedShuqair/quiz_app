import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.blue,
              size: 80,
            ),
            TextField(),
            TextFormField(),
            SizedBox(
              width: 100,
              child: Text(
                "Mohammed Naser",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            OutlinedButton(
                onPressed: () {
                  print("Mo");
                },
                child: Text("Print Your name")),
          ],
        ),
      ),
    );
  }
}
