import 'package:flutter/material.dart';

import '../../data/models/user.dart';

class ProfileAvatarSmall extends StatelessWidget {
  const ProfileAvatarSmall(
      {Key? key, required this.user, this.minRadius, this.maxRadius})
      : super(key: key);
  final User user;
  final double? minRadius;
  final double? maxRadius;

  @override
  Widget build(BuildContext context) {
    return user.image == null
        ? CircleAvatar(
            minRadius: minRadius ?? 2,
            maxRadius: maxRadius ?? 20,
            child: Text(
              user.getInitials(),
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            ),
          )
        : CircleAvatar(
            minRadius: minRadius ?? 2,
            maxRadius: maxRadius ?? 20,
            backgroundImage: NetworkImage(user.image!),
          );
  }
}
