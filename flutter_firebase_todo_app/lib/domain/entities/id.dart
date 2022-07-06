import 'package:uuid/uuid.dart';

class UniqueID {
  final String value;

  const UniqueID._(this.value);

  factory UniqueID() {
    return UniqueID._(Uuid().v4());
  }

  factory UniqueID.fromString(String uniqueID) {
    return UniqueID._(uniqueID);
  }
}
