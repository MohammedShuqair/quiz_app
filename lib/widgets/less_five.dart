import 'package:flutter/material.dart';
import 'package:quize/shared/colors.dart';

import '../shared/components.dart';

class LessFive extends StatelessWidget {
  const LessFive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Center(
      child: SizedBox(
        width: isPortrait ? sw * 0.8 : null,
        height: isPortrait ? null : 0.7 * sh,
        child: ListView(
          scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const Text(
                  'Sorry!',
                  style: TextStyle(
                      fontSize: 30,
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                const Text(
                  'You must add at least 5 questions to start',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10,),
                isPortrait?
                Image.asset('images/faq.png',)
                    :Expanded(child: Image.asset('images/faq.png',))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isPortrait ? 30 : 20,
                  vertical: isPortrait ? 20 : 30),
              child: PrimaryButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: "Back to home",
              ),
            )
          ],
        ),
      ),
    );
  }
}
