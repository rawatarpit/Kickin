import 'package:collection/collection.dart';

enum UserType {
  Player,
  Coach,
  Club,
  Academy,
  Agent,
  Agency,
}

enum MediaType {
  Image,
  Video,
  Audio,
  Doc,
}

enum NotificationType {
  Like,
  Comment,
  Message,
  Request,
  Invite,
  Fixture,
  Match_update,
  Event_update,
}

enum Status {
  accepted,
  pending,
  read,
  sent,
}

enum MenItems {
  home,
  search,
  upload,
  shots,
  jobs,
  profile,
}

enum InviteUsertype {
  Player,
  Coach,
  Club,
  Academy,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (UserType):
      return UserType.values.deserialize(value) as T?;
    case (MediaType):
      return MediaType.values.deserialize(value) as T?;
    case (NotificationType):
      return NotificationType.values.deserialize(value) as T?;
    case (Status):
      return Status.values.deserialize(value) as T?;
    case (MenItems):
      return MenItems.values.deserialize(value) as T?;
    case (InviteUsertype):
      return InviteUsertype.values.deserialize(value) as T?;
    default:
      return null;
  }
}
