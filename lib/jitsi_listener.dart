class JitsiListener {
  final Function(Map<dynamic, dynamic> message)? onConferenceWillJoin;

  final Function(Map<dynamic, dynamic> message)? onConferenceJoined;

  final Function(Map<dynamic, dynamic> message)? onConferenceTerminated;

  final Function(Map<dynamic, dynamic> message)? onPictureInPictureWillEnter;

  final Function(Map<dynamic, dynamic> message)? onPictureInPictureTerminated;

  final Function(dynamic error)? onError;

  JitsiListener(
      {this.onConferenceWillJoin,
      this.onConferenceJoined,
      this.onConferenceTerminated,
      this.onPictureInPictureTerminated,
      this.onPictureInPictureWillEnter,
      this.onError});
}
