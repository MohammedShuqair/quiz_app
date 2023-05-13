import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quize/controller/question_provider.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key, required this.onTap, required this.title,  this.padding,
  });
  final VoidCallback onTap;
  final String title;
   final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
          onPressed: onTap,
          child:  Text(title,style:const TextStyle(fontSize: 18) ,)),
    );
  }
}

showAlertDialog(BuildContext context,int id) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete question"),
    content: const Text("Are you sure you want to delete this question?"),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text("Delete"),
        onPressed: () {
          Provider.of<QuestionProvider>(context,listen: false).deleteFromDatabase(id);
          // perform delete operation here
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
