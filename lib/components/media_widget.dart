import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'media_model.dart';
export 'media_model.dart';

class MediaWidget extends StatefulWidget {
  const MediaWidget({
    super.key,
    this.media,
  });

  final List<String>? media;

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  late MediaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaModel());

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
      decoration: BoxDecoration(),
      child: Builder(
        builder: (context) {
          final media = (widget.media?.toList() ?? []).take(5).toList();

          return Container(
            width: double.infinity,
            height: 500.0,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _model.pageViewController ??= PageController(
                      initialPage: max(0, min(0, media.length - 1))),
                  onPageChanged: (_) => safeSetState(() {}),
                  scrollDirection: Axis.horizontal,
                  itemCount: media.length,
                  itemBuilder: (context, mediaIndex) {
                    final mediaItem = media[mediaIndex];
                    return Container(
                      width: double.infinity,
                      height: 400.0,
                      child: custom_widgets.DisplayMedia(
                        width: double.infinity,
                        height: 400.0,
                        url: mediaItem,
                      ),
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller: _model.pageViewController ??= PageController(
                          initialPage: max(0, min(0, media.length - 1))),
                      count: media.length,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) async {
                        await _model.pageViewController!.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        safeSetState(() {});
                      },
                      effect: smooth_page_indicator.SlideEffect(
                        spacing: 8.0,
                        radius: 8.0,
                        dotWidth: 8.0,
                        dotHeight: 8.0,
                        dotColor: FlutterFlowTheme.of(context).accent4,
                        activeDotColor:
                            FlutterFlowTheme.of(context).secondaryText,
                        paintStyle: PaintingStyle.stroke,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
