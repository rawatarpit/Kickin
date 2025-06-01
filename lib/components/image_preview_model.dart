import '/flutter_flow/flutter_flow_util.dart';
import 'image_preview_widget.dart' show ImagePreviewWidget;
import 'package:flutter/material.dart';

class ImagePreviewModel extends FlutterFlowModel<ImagePreviewWidget> {
  ///  Local state fields for this component.

  List<String> imageslist = [];
  void addToImageslist(String item) => imageslist.add(item);
  void removeFromImageslist(String item) => imageslist.remove(item);
  void removeAtIndexFromImageslist(int index) => imageslist.removeAt(index);
  void insertAtIndexInImageslist(int index, String item) =>
      imageslist.insert(index, item);
  void updateImageslistAtIndex(int index, Function(String) updateFn) =>
      imageslist[index] = updateFn(imageslist[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
