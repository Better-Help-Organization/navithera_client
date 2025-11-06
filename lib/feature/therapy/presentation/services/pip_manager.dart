import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/pip_call_widget.dart';

class PiPManager {
  static OverlayEntry? _overlayEntry;
  static bool _isActive = false;

  static bool get isActive => _isActive;

  /// Show PiP overlay
  static void showPiP({
    required BuildContext context,
    required String? roomName,
    required String? participantName,
    required bool isVideoCall,
    required String? chatId,
    required VoidCallback onExpand,
    required VoidCallback onClose,
  }) {
    if (_isActive) {
      hidePiP();
    }

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                PiPCallWidget(
                  roomName: roomName,
                  participantName: participantName,
                  isVideoCall: isVideoCall,
                  chatId: chatId,
                  onExpand: () {
                    hidePiP();
                    // Use a slight delay to ensure PiP is fully hidden before navigation
                    Future.microtask(() => onExpand());
                  },
                  onClose: () {
                    hidePiP();
                    onClose();
                  },
                ),
              ],
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isActive = true;
  }

  /// Hide PiP overlay
  static void hidePiP() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isActive = false;
    }
  }

  /// Update PiP content (if needed)
  static void updatePiP() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }
}

/// Provider for PiP state management
final pipManagerProvider =
    StateNotifierProvider<PiPManagerNotifier, PiPManagerState>((ref) {
      return PiPManagerNotifier();
    });

class PiPManagerState {
  final bool isActive;
  final String? roomName;
  final String? participantName;
  final bool isVideoCall;
  final String? chatId;

  const PiPManagerState({
    this.isActive = false,
    this.roomName,
    this.participantName,
    this.isVideoCall = false,
    this.chatId,
  });

  PiPManagerState copyWith({
    bool? isActive,
    String? roomName,
    String? participantName,
    bool? isVideoCall,
    String? chatId,
  }) {
    return PiPManagerState(
      isActive: isActive ?? this.isActive,
      roomName: roomName ?? this.roomName,
      participantName: participantName ?? this.participantName,
      isVideoCall: isVideoCall ?? this.isVideoCall,
      chatId: chatId ?? this.chatId,
    );
  }
}

class PiPManagerNotifier extends StateNotifier<PiPManagerState> {
  PiPManagerNotifier() : super(const PiPManagerState());

  void showPiP({
    required BuildContext context,
    required String? roomName,
    required String? participantName,
    required bool isVideoCall,
    required String? chatId,
    required VoidCallback onExpand,
    required VoidCallback onClose,
  }) {
    PiPManager.showPiP(
      context: context,
      roomName: roomName,
      participantName: participantName,
      isVideoCall: isVideoCall,
      chatId: chatId,
      onExpand: onExpand,
      onClose: onClose,
    );

    state = state.copyWith(
      isActive: true,
      roomName: roomName,
      participantName: participantName,
      isVideoCall: isVideoCall,
      chatId: chatId,
    );
  }

  void hidePiP() {
    PiPManager.hidePiP();
    state = state.copyWith(
      isActive: false,
      roomName: null,
      participantName: null,
      isVideoCall: false,
      chatId: null,
    );
  }

  void updatePiP() {
    PiPManager.updatePiP();
  }
}
