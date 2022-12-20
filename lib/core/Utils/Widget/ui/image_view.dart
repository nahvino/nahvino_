import 'dart:io';

import 'package:Nahvino/config/main_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter/material.dart';

class Imageview {
  ///test
  image(String? Img) {
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
            imageUrl:  Img!,
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
      ],
    );
  }

  imageProfile({required String Img, required bool flag}) {
    return Stack(
      children: [
        Card(
          shape: CircleBorder(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: CachedNetworkImage(
            height: 70,
            width: 70,
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
        )
      ],
    );
  }

  imageAssetProfile({required bool flag}) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/home/user.png',
          fit: BoxFit.cover,
          height: 70,
          width: 70,
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
        )
      ],
    );
  }

  image_assets() {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        elevation: 0,
          shape: CircleBorder(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(Icons.group,size: 35,),
      )),
    );
  }

  image_assetsa(String ass) {
    return Padding(
      padding:  EdgeInsets.only(right: 5,top: 5,bottom: 5),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          //  color: Colors.white,
          shape: BoxShape.circle,
          //border: Border.all(width: 2, color: Colors.cyan)
        ),
        child: Image.asset(ass),
      ),
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
