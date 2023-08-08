import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/domains/account/domain/entities/response/user_response_entity.dart';
import 'package:chat_app/shared_libraries/component/loading/shimmer_loading.dart';
import 'package:chat_app/shared_libraries/utils/extensions/name_extension.dart';
import 'package:chat_app/shared_libraries/utils/resources/assets.gen.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Photo extends StatelessWidget {
  final UserResponseEntity data;
  final double size;
  const Photo({
    super.key,
    required this.data,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: data.photo.isEmpty
            ? Assets.images.icons.account.emptyPhoto.svg(
                height: size.h,
                width: size.h,
              )
            : CachedNetworkImage(
                height: size.h,
                width: size.h,
                imageUrl: data.photo,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    ShimmerLoading(
                  child: Container(
                    height: size.h,
                    width: size.h,
                    decoration: const BoxDecoration(
                      color: ColorName.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: size.h,
                  width: size.h,
                  color: ColorName.main.withOpacity(0.12),
                  child: Center(
                    child: Text(
                      data.username.getInitials(),
                      style: TextStyle(
                        color: ColorName.main,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.sp,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
