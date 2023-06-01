import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../data/models/user.dart';

class PhotoViewDialog {
  final User user;

  PhotoViewDialog(this.user);

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ImageViewer(
          user: user,
        );
      },
    );
  }
}

class ImageViewer extends StatefulWidget {
  const ImageViewer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  double progress = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withOpacity(progress),
          ),
          backgroundColor: Theme.of(context)
              .appBarTheme
              .copyWith()
              .backgroundColor!
              .withOpacity(progress),
          centerTitle: true,
          title: Text(
            widget.user.getFullName(),
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withOpacity(progress),
            ),
          ),
        ),
        Expanded(
          child: Dismissible(
            onUpdate: (details) {
              setState(() {
                if (1 - details.progress * 2.4 >= 0) {
                  progress = 1 - details.progress * 2.4;
                }
              });
            },
            key: Key(widget.user.image!),
            direction: DismissDirection.vertical,
            background: Container(color: Colors.black.withOpacity(progress)),
            onDismissed: (direction) {
              Navigator.of(context).pop();
            },
            child: PhotoView(
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 1.5,
              imageProvider: NetworkImage(widget.user.image!),
              backgroundDecoration:
                  BoxDecoration(color: Colors.black.withOpacity(progress)),
            ),
          ),
        ),
      ],
    );
  }
}
