import '/backend/api_requests/api_calls.dart';
import '/components/loading_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_location_widget.dart' show SearchLocationWidget;
import 'package:flutter/material.dart';

class SearchLocationModel extends FlutterFlowModel<SearchLocationWidget> {
  ///  Local state fields for this component.

  dynamic data;

  bool? searchResult = false;

  bool? loading = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for search_location widget.
  FocusNode? searchLocationFocusNode;
  TextEditingController? searchLocationTextController;
  String? Function(BuildContext, String?)?
      searchLocationTextControllerValidator;
  // Stores action output result for [Backend Call - API (PlaceSearch)] action in search_location widget.
  ApiCallResponse? apiResultft5;
  // Model for loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    searchLocationFocusNode?.dispose();
    searchLocationTextController?.dispose();

    loadingModel.dispose();
  }
}
