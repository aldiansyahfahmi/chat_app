import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    this.onTap,
    this.contentPadding,
    this.subTitle = true,
    this.photoSize = 50,
    this.horizontalTitleGap = 16,
    required this.user,
  });
  final GestureTapCallback? onTap;
  final UserDataEntity user;
  final EdgeInsetsGeometry? contentPadding;
  final bool subTitle;
  final double photoSize;
  final double horizontalTitleGap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: contentPadding,
        dense: true,
        minLeadingWidth: 0,
        horizontalTitleGap: horizontalTitleGap,
        leading: user.photo.isEmpty
            ? Assets.images.icons.account.emptyPhoto.svg(
                width: photoSize,
                height: photoSize,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  width: photoSize,
                  height: photoSize,
                  imageUrl: user.photo,
                  fit: BoxFit.cover,
                ),
              ),
        title: Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: subTitle == true
            ? Text(
                user.email,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              )
            : null,
      ),
    );
  }
}
