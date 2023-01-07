import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerCard extends StatelessWidget {
  const SellerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? const Color(0xff292d32) : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          Get.isDarkMode
              ? const BoxShadow(
                  color: Color(0xff474b50),
                  offset: Offset(5, 5),
                  spreadRadius: 1,
                  blurRadius: 15,
                )
              : BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 1,
                  blurRadius: 15,
                  offset: const Offset(5, 5),
                ),
          Get.isDarkMode
              ? const BoxShadow(
                  color: Color(0xff0b0f14),
                  offset: Offset(-5, -5),
                  blurRadius: 15,
                  spreadRadius: 1)
              : const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, -5),
                  blurRadius: 15,
                  spreadRadius: 1),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Image.asset("assets/profile.png"),
        ),
        title: const Text(
          "Shaffaan",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "SELLER",
          style: TextStyle(fontSize: 14.0),
        ),
        trailing: IconButton(
          onPressed: () async {
            String tel = 'tel:+918080386766';
            await launchUrl(Uri.parse(tel));
          },
          icon: const Icon(
            Icons.call,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
