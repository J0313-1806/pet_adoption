import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PinchToZoom extends StatelessWidget {
  const PinchToZoom({Key? key, required this.image}) : super(key: key);

  final String image;
  final double minScale = 1.0;
  final double maxScale = 4.0;

  static final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Get.isDarkMode ? null : Colors.white,
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          PhotoViewGallery.builder(
            itemCount: 3,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(image),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            onPageChanged: _productController.onPhotoViewChange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(3, (index) {
              return Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  key: ValueKey<int>(index),
                  width:
                      _productController.photoIndex.value == index ? 12.0 : 8.0,
                  height:
                      _productController.photoIndex.value == index ? 12.0 : 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
