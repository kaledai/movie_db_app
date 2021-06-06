import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';

mixin AvatarBuilderMixin {
  Widget avatarBuilder() => Container(
        height: 68,
        width: 68,
        color: primaryDarkBlue.withOpacity(0.4),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              bottom: -26,
              child: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryDarkBlue.withOpacity(0.4)),
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryDarkBlue.withOpacity(0.4)),
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      );
}