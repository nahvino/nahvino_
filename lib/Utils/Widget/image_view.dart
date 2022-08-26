import 'dart:io';

import 'package:Nahvino/config/main_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Imageview {
  image(String Img) {
    return Card(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        height: 50,
        width: 50,
        cacheManager: CacheManager(Config('customCacheKey',
            stalePeriod: Duration(days: 7), maxNrOfCacheObjects: 100)),
        imageUrl: MainConfig.fileurl + Img,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  image_assets() {
    return Image.asset(
      'assets/images/home/user.png',
      fit: BoxFit.cover,
      height: 50,
      width: 50,
    );
  }

  //test
  image_assetsa(String ass) {
    return Image.asset(
      ass,
      fit: BoxFit.cover,
      height: 50,
      width: 50,
    );
  }

  image_file(String? img) {
    return Card(
      shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
          height: 75,
          width: 75,
          child: Image.file(File(img!), fit: BoxFit.cover)),
    );
  }
}
