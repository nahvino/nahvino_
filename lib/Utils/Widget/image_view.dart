import 'dart:io';

import 'package:Nahvino/config/main_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Imageview {
  image(String Img) {
    return Stack(
      children: [
        Card(
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
        ),
        Positioned(
            child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 4, color: Colors.white)),
        ))
      ],
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
    return
        Container(
          width: 60,
          height: 60,
          child: Image.asset(ass),



    );
  }

  //test user
  image_asset_user(String ass, bool flag) {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          child: Image.asset(
            "assets/images/home/user.png",
          ),
        ),
        Visibility(
          visible: flag,
          child: Positioned(
            bottom: 0,
            right: 0,
            left: 30,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                //  color: Colors.white,
                  shape: BoxShape.circle,
                  //border: Border.all(width: 2, color: Colors.cyan)
              ),
              child: Image(
                image: NetworkImage(
                    "https://hospitalnews.com/wp-content/uploads/2013/07/red-flag.png"),
              ),
            ),
          ),
        ),
      ],
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
