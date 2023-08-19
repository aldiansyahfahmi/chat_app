import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    this.onTap,
    this.contentPadding,
    this.showSubTitile = true,
    this.photoSize = 50,
    this.horizontalTitleGap = 16,
    required this.user,
    this.subTitle,
    this.totalUnread,
  });
  final GestureTapCallback? onTap;
  final UserDataEntity user;
  final EdgeInsetsGeometry? contentPadding;
  final bool showSubTitile;
  final double photoSize;
  final double horizontalTitleGap;
  final String? subTitle;
  final int? totalUnread;

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
        trailing: totalUnread == null || totalUnread == 0
            ? null
            : Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: ColorName.main,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  totalUnread.toString(),
                  style: const TextStyle(
                    color: ColorName.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        title: Text(
          user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: showSubTitile == true
            ? Text(
                subTitle ?? user.email,
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
