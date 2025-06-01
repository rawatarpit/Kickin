import '/components/image_preview_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'message_image_model.dart';
export 'message_image_model.dart';

class MessageImageWidget extends StatefulWidget {
  const MessageImageWidget({
    super.key,
    required this.imagePath,
  });

  final List<String>? imagePath;

  @override
  State<MessageImageWidget> createState() => _MessageImageWidgetState();
}

class _MessageImageWidgetState extends State<MessageImageWidget> {
  late MessageImageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessageImageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(),
      child: Builder(
        builder: (context) {
          final image = widget.imagePath!.toList();

          return Container(
            width: double.infinity,
            height: 200.0,
            child: CarouselSlider.builder(
              itemCount: image.length,
              itemBuilder: (context, imageIndex, _) {
                final imageItem = image[imageIndex];
                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'MESSAGE_IMAGE_COMP_Image_x8vbi8bm_ON_TAP');
                    logFirebaseEvent('Image_bottom_sheet');
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return WebViewAware(
                          child: Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.85,
                              child: ImagePreviewWidget(
                                imagepath: imageIndex.toString(),
                                url: imageItem,
                                isPlayer: false,
                              ),
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageItem,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              carouselController: _model.carouselController ??=
                  CarouselSliderController(),
              options: CarouselOptions(
                initialPage: max(0, min(0, image.length - 1)),
                viewportFraction: 0.9,
                disableCenter: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.25,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                autoPlay: false,
                onPageChanged: (index, _) =>
                    _model.carouselCurrentIndex = index,
              ),
            ),
          );
        },
      ),
    );
  }
}
