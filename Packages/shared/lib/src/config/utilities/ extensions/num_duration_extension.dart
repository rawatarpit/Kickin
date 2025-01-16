// ignore: dangling_library_doc_comments
/// 200.ms // equivalent to Duration(miliseconds: 200)
/// 3.seconds // equivalent to Duration(miliseconds: 3000)
/// 1.5.days // equivalent to Duration(hours: 36)

// ignore_for_file: public_member_api_docs

extension NumDurationExtension on num {
  Duration get microseconds => Duration(microseconds: round());
  Duration get ms => (this * 1000).microseconds;
  Duration get milliseconds => (this * 1000).microseconds;
  Duration get seconds => (this * 1000 * 1000).microseconds;
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;
}
