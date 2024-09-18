import 'package:flutter/material.dart';
import 'package:nova/pages/paymentdetails_page.dart';
import 'package:nova/pages/settings_page.dart';

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 30,
          height: 20,
          child: Image.asset("lib/images/menu.png"),
        ),
        const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        SizedBox(
          width: 30,
          height: 20,
          child: Image.asset("lib/images/more.png"),
        ),
      ],
    ),
    backgroundColor: Colors.grey[300],
  );
}

var imagesInfo = <String, String>{
  "Settings": "settings.png",
  "Payment Details": "credit-card.png",
};

Widget buildListView(BuildContext context) {
  return Column(
    children: [
      ...List.generate(
        imagesInfo.length,
        (index) => GestureDetector(
          onTap: () {
            String tappedItem = imagesInfo.keys.elementAt(index);
            if (tappedItem == "Settings") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            } else if (tappedItem == "Payment Details") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PaymentDetailsPage()),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Image.asset(
                      "lib/images/${imagesInfo.values.elementAt(index)}"),
                ),
                const SizedBox(width: 15),
                Text(
                  imagesInfo.keys.elementAt(index),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}
