import 'dart:collection';

import 'feature_flag_type.dart';

class JitsiOptions {
  JitsiOptions({
    required this.room,
  });

  String? serverURL;
  final String room;
  String? subject;
  String? token;
  String? userDisplayName;
  String? userEmail;
  String? iosAppBarRGBAColor;
  String? userAvatarURL;
  bool? audioMuted;

  Map<FeatureFlag, bool> featureFlags = HashMap();

  Map<String?, bool> getFeatureFlags() {
    Map<String?, bool> featureFlagsWithStrings = HashMap();

    featureFlags.forEach((key, value) {
      featureFlagsWithStrings[key.value] = value;
    });

    return featureFlagsWithStrings;
  }

  @override
  String toString() {
    return 'JitsiOptions{room: $room, serverURL: $serverURL, '
        'subject: $subject, token: $token, audioMuted: $audioMuted '
        'userDisplayName: $userDisplayName, userEmail: $userEmail, '
        'iosAppBarRGBAColor :$iosAppBarRGBAColor, featureFlags: $featureFlags }';
  }
}
