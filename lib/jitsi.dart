import 'room_name_constraint.dart';
import 'room_name_constraint_type.dart';

import 'package:jitsi/jitsi_platform_interface.dart';
export 'package:jitsi/jitsi_platform_interface.dart'
    show JitsiOptions, JitsiResponse, JitsiListener, FeatureFlag;

class Jitsi {
  static bool _hasInitialized = false;

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      defaultRoomNameConstraints = {
    RoomNameConstraintType.MIN_LENGTH: RoomNameConstraint((value) {
      return value.trim().length >= 3;
    }, "Minimum room length is 3"),
    RoomNameConstraintType.ALLOWED_CHARS: RoomNameConstraint((value) {
      return RegExp(r"^[a-zA-Z0-9-_]+$", caseSensitive: false, multiLine: false)
          .hasMatch(value);
    }, "Only alphanumeric, dash, and underscore chars allowed"),
  };

  Future<String?> getPlatformVersion() {
    return JitsiPlatform.instance.getPlatformVersion();
  }

  /// Joins a meeting based on the JitsiOptions passed in.
  /// A JitsiListener can be attached to this meeting that will automatically
  /// be removed when the meeting has ended
  static Future<JitsiResponse> joinMeeting(JitsiOptions options,
      {JitsiListener? listener,
      Map<RoomNameConstraintType, RoomNameConstraint>?
          roomNameConstraints}) async {
    assert(options.room.trim().isNotEmpty, "room is empty");

    // If no constraints given, take default ones
    // (To avoid using constraint, just give an empty Map)
    roomNameConstraints ??= defaultRoomNameConstraints;

    // Check each constraint, if it exist
    // (To avoid using constraint, just give an empty Map)
    if (roomNameConstraints.isNotEmpty) {
      for (RoomNameConstraint constraint in roomNameConstraints.values) {
        assert(
            constraint.checkConstraint(options.room), constraint.getMessage());
      }
    }

    // Validate serverURL is absolute if it is not null or empty
    if (options.serverURL?.isNotEmpty ?? false) {
      assert(Uri.parse(options.serverURL!).isAbsolute,
          "URL must be of the format <scheme>://<host>[/path], like https://someHost.com");
    }

    return await JitsiPlatform.instance
        .joinMeeting(options, listener: listener);
  }

  static _initialize() {
    if (!_hasInitialized) {
      JitsiPlatform.instance.initialize();
      _hasInitialized = true;
    }
  }

  static closeMeeting() => JitsiPlatform.instance.closeMeeting();

  static addListener(JitsiListener listener) {
    JitsiPlatform.instance.addListener(listener);
    _initialize();
  }

  static removeListener(JitsiListener listener) {
    JitsiPlatform.instance.removeListener(listener);
  }

  static removeAllListeners() {
    JitsiPlatform.instance.removeAllListeners();
  }
}
