// Enhanced version with more features
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatefulWidget {
  final String imageUrl;
  final String? heroTag;
  final bool isAsset;

  const FullScreenImageViewer({
    super.key,
    required this.imageUrl,
    this.heroTag,
    this.isAsset = false,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  bool _showAppBar = true;

  void _toggleAppBar() {
    setState(() {
      _showAppBar = !_showAppBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleAppBar,
        child: Stack(
          children: [
            Positioned.fill(
              child: PhotoView(
                imageProvider: widget.isAsset
                    ? AssetImage(widget.imageUrl) as ImageProvider
                    : NetworkImage(widget.imageUrl),
                heroAttributes:
                    widget.heroTag != null
                        ? PhotoViewHeroAttributes(tag: widget.heroTag!)
                        : null,
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 4,
                onTapUp: (context, details, value) {
                  _toggleAppBar();
                },
              ),
            ),
            if (_showAppBar)
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.download,
                    //     color: Colors.white,
                    //     size: 30,
                    //   ),
                    //   onPressed: () {
                    //     // Implement download functionality
                    //     _downloadImage(widget.imageUrl);
                    //   },
                    // ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // void _downloadImage(String url) {
  //   // Implement your download logic here

  // }
}
