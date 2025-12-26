import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:livekit_client/livekit_client.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../exts.dart';

class ControlsWidget extends StatefulWidget {
  //
  final Room room;
  final LocalParticipant participant;
  final bool showVideoControl;

  const ControlsWidget(
    this.room,
    this.participant, {
    this.showVideoControl = true,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  //
  CameraPosition position = CameraPosition.front;

  StreamSubscription? _subscription;

  bool _speakerphoneOn = Hardware.instance.speakerOn ?? false;

  @override
  void initState() {
    super.initState();
    participant.addListener(_onChange);
    // _subscription = Hardware.instance.onDeviceChange.stream.listen((List<MediaDevice> devices) {
    //   _loadDevices(devices);
    // });
    // unawaited(Hardware.instance.enumerateDevices().then(_loadDevices));
  }

  @override
  void dispose() {
    unawaited(_subscription?.cancel());
    participant.removeListener(_onChange);
    super.dispose();
  }

  LocalParticipant get participant => widget.participant;

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  void _unpublishAll() async {
    final result = await context.showUnPublishDialog();
    if (result == true) await participant.unpublishAllTracks();
  }

  bool get isMuted => participant.isMuted;

  void _disableAudio() async {
    await participant.setMicrophoneEnabled(false);
  }

  Future<void> _enableAudio() async {
    await participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await participant.setCameraEnabled(false);
  }

  void _enableVideo() async {
    await participant.setCameraEnabled(true);
  }

  void _setSpeakerphoneOn() async {
    _speakerphoneOn = !_speakerphoneOn;
    await widget.room.setSpeakerOn(_speakerphoneOn, forceSpeakerOutput: false);
    setState(() {});
  }

  void _toggleCamera() async {
    final track = participant.videoTrackPublications.firstOrNull?.track;
    if (track == null) return;

    try {
      final newPosition = position.switched();
      await track.setCameraPosition(newPosition);
      setState(() {
        position = newPosition;
      });
    } catch (error) {
      print('could not restart track: $error');
      return;
    }
  }

  void _enableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          print('cancelled screenshare');
          return;
        }
        print('DesktopCapturerSource: ${source.id}');
        final track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            sourceId: source.id,
            maxFrameRate: 15.0,
          ),
        );
        await participant.publishVideoTrack(track);
      } catch (e) {
        print('could not publish video: $e');
      }
      return;
    }
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      final hasCapturePermission = await Helper.requestCapturePermission();
      if (!hasCapturePermission) {
        return;
      }

      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          bool hasPermissions = await FlutterBackground.hasPermissions;
          if (!isRetry) {
            const androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: 'Screen Sharing',
              notificationText: 'LiveKit Example is sharing the screen.',
              notificationImportance: AndroidNotificationImportance.normal,
              notificationIcon: AndroidResource(name: 'livekit_ic_launcher', defType: 'mipmap'),
            );
            hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
          }
          if (hasPermissions && !FlutterBackground.isBackgroundExecutionEnabled) {
            await FlutterBackground.enableBackgroundExecution();
          }
        } catch (e) {
          if (!isRetry) {
            return await Future<void>.delayed(const Duration(seconds: 1), () => requestBackgroundPermission(true));
          }
          print('could not publish video: $e');
        }
      }

      await requestBackgroundPermission();
    }

    if (lkPlatformIsWebMobile()) {
      if (!mounted) return;
      await context.showErrorDialog('Screen share is not supported on mobile web');
      return;
    }
    await participant.setScreenShareEnabled(true, captureScreenAudio: true);
  }

  void _disableScreenShare() async {
    await participant.setScreenShareEnabled(false);
    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      try {
        //   await FlutterBackground.disableBackgroundExecution();
      } catch (error) {
        print('error disabling screen share: $error');
      }
    }
  }

  void _onTapDisconnect() async {
    final result = await context.showDisconnectDialog();
    if (result == true) await widget.room.disconnect();
  }

  void _onTapUpdateSubscribePermission() async {
    final result = await context.showSubscribePermissionDialog();
    if (result != null) {
      try {
        widget.room.localParticipant?.setTrackSubscriptionPermissions(
          allParticipantsAllowed: result,
        );
      } catch (error) {
        if (!mounted) return;
        await context.showErrorDialog(error);
      }
    }
  }

  void _onTapSimulateScenario() async {
    final result = await context.showSimulateScenarioDialog();
    if (result != null) {
      print('${result}');

      if (SimulateScenarioResult.e2eeKeyRatchet == result) {
        await widget.room.e2eeManager?.ratchetKey();
      }

      if (SimulateScenarioResult.participantMetadata == result) {
        widget.room.localParticipant?.setMetadata('new metadata ${widget.room.localParticipant?.identity}');
      }

      if (SimulateScenarioResult.participantName == result) {
        widget.room.localParticipant?.setName('new name for ${widget.room.localParticipant?.identity}');
      }

      await widget.room.sendSimulateScenario(
        speakerUpdate: result == SimulateScenarioResult.speakerUpdate ? 3 : null,
        signalReconnect: result == SimulateScenarioResult.signalReconnect ? true : null,
        fullReconnect: result == SimulateScenarioResult.fullReconnect ? true : null,
        nodeFailure: result == SimulateScenarioResult.nodeFailure ? true : null,
        migration: result == SimulateScenarioResult.migration ? true : null,
        serverLeave: result == SimulateScenarioResult.serverLeave ? true : null,
        switchCandidate: result == SimulateScenarioResult.switchCandidate ? true : null,
      );
    }
  }

  void _onTapSendData() async {
    final result = await context.showSendDataDialog();
    if (result == true) {
      await widget.participant.publishData(
        utf8.encode('This is a sample data message'),
        reliable: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Speaker
          if (!kIsWeb && lkPlatformIsMobile())
            _buildControlButton(
              icon: _speakerphoneOn ? Icons.volume_up : Icons.volume_off,
              label: 'Speaker',
              onPressed: _setSpeakerphoneOn,
              isActive: _speakerphoneOn,
            )
          else if (!lkPlatformIsMobile())
             // Desktop/Web speaker selection placeholder or mute
             _buildControlButton(
                icon: Icons.volume_up,
                label: 'Speaker',
                onPressed: () {}, // popup logic could go here
                isActive: true,
             ),

          // Video
          if (widget.showVideoControl)
            _buildControlButton(
              icon: participant.isCameraEnabled() ? Icons.videocam : Icons.videocam_off, // Icon indicates action to take? Or state? Telegram shows "Stop Video" if on.
              // Telegram: "Start Video" (camera icon crossed out initially).
              // If on: "Stop Video" (camera icon).
              // Let's stick to state icon for now.
              label: participant.isCameraEnabled() ? 'Stop Video' : 'Start Video',
              onPressed: participant.isCameraEnabled() ? _disableVideo : _enableVideo,
              isActive: participant.isCameraEnabled(), // White if active/on?
              // Telegram style: White circle usually means "action available" or "on". 
              // In the screenshot:
              // Speaker: Blue/Cyan circle (Active?)
              // Start Video: White circle (Inactive?)
              // Mute: Cyan circle (Active?)
              // End Call: Red circle.
              
              // Let's use:
              // Active (On): Cyan/Blue background, White Icon.
              // Inactive (Off): White background, Black/Grey Icon? Or White background, Cyan icon?
              // Screenshot shows:
              // Speaker: Cyan bg, White icon.
              // Start Video: White bg, Black icon (crossed out camera).
              // Mute: Cyan bg, White icon (mic).
              // End Call: Red bg, White icon.
              
              // So:
              // Mic ON -> Cyan bg.
              // Mic OFF -> White bg.
              // Speaker ON -> Cyan bg.
              // Video ON -> Cyan bg? Or maybe White if it means "Stop Video"?
              // Let's assume "Active" state gets the Color.
            ),

          // Mic
          _buildControlButton(
            icon: participant.isMicrophoneEnabled() ? Icons.mic : Icons.mic_off,
            label: participant.isMicrophoneEnabled() ? 'Mute' : 'Unmute',
            onPressed: participant.isMicrophoneEnabled() ? _disableAudio : _enableAudio,
            isActive: participant.isMicrophoneEnabled(),
          ),

          // End Call
          _buildControlButton(
            icon: Icons.call_end,
            label: 'End Call',
            onPressed: _onTapDisconnect,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
    bool isDestructive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDestructive 
                  ? Colors.red.withOpacity(0.8) 
                  : Colors.white.withOpacity(0.2),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
