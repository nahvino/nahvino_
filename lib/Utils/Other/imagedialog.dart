import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import '../../Services/config.dart';
import '../../Data/Local/viewprofial_data.dart';
import '../Text/TextField.dart';
import '../Text/Text.dart';

class ImageDialog extends StatelessWidget {
  //const ArshadDialog({Key? key}) : super(key: key);
  ViewProfileController databox = Get.put(ViewProfileController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    return (databox.imageUrl.value != null && databox.imageUrl.value != "")
        ? Card(
            shape: CircleBorder(),
            child: CachedNetworkImage(
              width: 500,
              height: 500,
              cacheManager: CacheManager(Config('customCacheKey',
                  stalePeriod: Duration(days: 7), maxNrOfCacheObjects: 100)),
              imageUrl: Configss.fileurl +
                  databox.imageUrl.value /*resultResponse!.imageUrl!*/,
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
          )
        : Image.asset(
            'assets/images/home/user.png',
            fit: BoxFit.cover,
            height: 75,
            width: 75,
          );
  }
}
