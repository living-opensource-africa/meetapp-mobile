import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'dart:async';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingTab extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MeetingTab> {
  static String displayName = 'LOSF Mobile User';
  static String room = 'TestRoom';
  static String subject = '';
  static String email = '';
  final serverText = "https://meetapp.livingopensource.africa";
  TextEditingController roomText = TextEditingController(text: room);
  TextEditingController subjectText = TextEditingController(text: subject);
  TextEditingController nameText = TextEditingController(text: displayName);
  TextEditingController emailText = TextEditingController(text: email);
  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  Map<FeatureFlagEnum, bool> jitsiFlags = {
    FeatureFlagEnum.CALL_INTEGRATION_ENABLED: false,
    FeatureFlagEnum.CHAT_ENABLED: true
  };

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    nameText.addListener(_setDisplayName);
    emailText.addListener(_setEmail);
    subjectText.addListener(_setSubjectName);
    roomText.addListener(_setRoomName);
    _getDisplayData();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: roomText..text = room,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Room",
                  icon: Icon(Icons.video_call)),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: subjectText..text = subject,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Subject",
                  icon: Icon(Icons.subject)),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: nameText..text = displayName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Display Name",
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: emailText..text = email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  icon: Icon(Icons.email)),
            ),
            SizedBox(
              height: 16.0,
            ),
            CheckboxListTile(
              title: Text("Audio Muted"),
              value: isAudioMuted,
              onChanged: _onAudioMutedChanged,
            ),
            SizedBox(
              height: 16.0,
            ),
            CheckboxListTile(
              title: Text("Video Muted"),
              value: isVideoMuted,
              onChanged: _onVideoMutedChanged,
            ),
            Divider(
              height: 10.0,
              thickness: 2.0,
            ),
            SizedBox(
              height: 54.0,
              child: RaisedButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: Text(
                  "Join Meeting",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
          ],
        ),
      ),
    );
  }

  // Get the persisted username from disk
  Future<void> _getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
    debugPrint("getting value $displayName");
  }

  Future<void> _getRoomName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      room = prefs.getString('roomName');
    });
  }

  Future<void> _getSubjectName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subject = prefs.getString('subject');
    });
  }

  Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  // Get all data to display
  _getDisplayData() {
    _getDisplayName();
    _getEmail();
    _getRoomName();
    _getSubjectName();
  }

  // Save the current field input to disk
  Future<void> _setDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('displayName', "${nameText.text}");
    debugPrint("setting value ${nameText.text}");
  }

  Future<void> _setRoomName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('roomName', "${roomText.text}");
  }

  Future<void> _setEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', "${emailText.text}");
  }

  Future<void> _setSubjectName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('subject', "${subjectText.text}");
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverText
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags = jitsiFlags;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
