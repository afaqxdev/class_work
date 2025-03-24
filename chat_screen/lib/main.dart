import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception
        .toString()
        .contains('_pressedKeys.containsKey(event.physicalKey)')) {
      // Ignore this specific error
      return;
    }
    FlutterError.dumpErrorToConsole(details);
  };

  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp-Style Chat',
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF075E54),
          secondary: const Color(0xFF128C7E),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];
  final Record _audioRecorder = Record();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isRecording = false;
  String? _currentRecordingPath;
  Timer? _recordingTimer;
  int _recordingDuration = 0;
  bool _isPlaying = false;
  int? _currentlyPlayingIndex;
  String _currentlyPlayingId = '';

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _currentlyPlayingIndex = null;
        _currentlyPlayingId = '';
      });
    });
  }

  Future<void> _requestPermissions() async {
    // Check current permission status first
    var status = await Permission.microphone.status;

    // If not determined yet, request it
    if (status.isDenied) {
      status = await Permission.microphone.request();
    }

    // If still not granted after request, show instructions
    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Microphone permission is required for voice messages'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _focusNode.requestFocus();

    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isVoiceMessage: false,
          audioPath: null,
          timestamp: DateTime.now(),
          isMe: true,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        ),
      );

      // Simulate a response after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add(
              ChatMessage(
                text: "Thanks for your message!",
                isVoiceMessage: false,
                audioPath: null,
                timestamp: DateTime.now(),
                isMe: false,
                id: DateTime.now().millisecondsSinceEpoch.toString(),
              ),
            );
          });
        }
      });
    });
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // Stop any playing audio
        await _audioPlayer.stop();
        setState(() {
          _isPlaying = false;
          _currentlyPlayingIndex = null;
          _currentlyPlayingId = '';
        });

        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        _currentRecordingPath = '${directory.path}/audio_$timestamp.m4a';

        await _audioRecorder.start(
          path: _currentRecordingPath!,
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );

        setState(() {
          _isRecording = true;
          _recordingDuration = 0;
        });

        _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _recordingDuration++;
          });
        });
      }
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    _recordingTimer?.cancel();

    try {
      final path = await _audioRecorder.stop();

      setState(() {
        _isRecording = false;

        if (path != null) {
          final messageId = DateTime.now().millisecondsSinceEpoch.toString();
          _messages.add(
            ChatMessage(
              text: "Voice message",
              isVoiceMessage: true,
              audioPath: path,
              timestamp: DateTime.now(),
              isMe: true,
              duration: _recordingDuration,
              id: messageId,
            ),
          );

          // Simulate a response after a short delay
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _messages.add(
                  ChatMessage(
                    text: "I received your voice message!",
                    isVoiceMessage: false,
                    audioPath: null,
                    timestamp: DateTime.now(),
                    isMe: false,
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                  ),
                );
              });
            }
          });
        }
      });
    } catch (e) {
      print('Error stopping recording: $e');
      setState(() {
        _isRecording = false;
      });
    }
  }

  Future<void> _playVoiceMessage(String path, String messageId) async {
    try {
      if (_isPlaying && _currentlyPlayingId == messageId) {
        // If this message is already playing, stop it
        await _audioPlayer.stop();
        setState(() {
          _isPlaying = false;
          _currentlyPlayingId = '';
        });
      } else {
        // If another message is playing, stop it first
        if (_isPlaying) {
          await _audioPlayer.stop();
        }

        // Play the new message
        await _audioPlayer.play(DeviceFileSource(path));
        setState(() {
          _isPlaying = true;
          _currentlyPlayingId = messageId;
        });
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  String _formatDuration(int seconds) {
    final mins = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${mins.toString().padLeft(1, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _recordingTimer?.cancel();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
            ),
            const SizedBox(width: 8),
            const Text('Chat'),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/originals/97/c0/07/97c00759d90d786d9b6096d274ad3e07.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, int index) {
                  final message = _messages[_messages.length - index - 1];
                  return _buildMessage(message);
                },
              ),
            ),
            const Divider(height: 1.0, color: Colors.transparent),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color(0xFFDCF8C6) // Light green for sender
              : Colors.white, // White for receiver
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            message.isVoiceMessage
                ? _buildVoiceMessageContent(message)
                : Text(
                    message.text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
            const SizedBox(height: 3.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey[600],
                  ),
                ),
                if (message.isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Icon(
                      Icons.done_all,
                      size: 14.0,
                      color: Colors.blue[400],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoiceMessageContent(ChatMessage message) {
    final isThisPlaying = _isPlaying && _currentlyPlayingId == message.id;

    return GestureDetector(
      onTap: () {
        if (message.audioPath != null) {
          _playVoiceMessage(message.audioPath!, message.id);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isThisPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 5),
          WaveformDisplay(
            isPlaying: isThisPlaying,
            duration: message.duration ?? 0,
          ),
          const SizedBox(width: 5),
          Text(
            _formatDuration(message.duration ?? 0),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              !_isRecording
                  ? Container(
                      width: 320,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      // padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.emoji_emotions_outlined),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 170,
                            child: TextField(
                              controller: _textController,
                              focusNode: _focusNode,
                              decoration: const InputDecoration(
                                hintText: 'Message',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.attach_file),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            color: Colors.grey[600],
                            onPressed: () {},
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        // If the user drags left more than 50 pixels, cancel recording
                        if (details.delta.dx < -2 && !_isCancelling) {
                          setState(() {
                            _isCancelling = true;
                          });
                          _cancelRecording();
                        }
                      },
                      child: Container(
                        width: 320,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFE0E0),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.mic,
                                color: Colors.red,
                                size: 24.0,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Audio waveform animation
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: AudioWaveform(isRecording: _isRecording),
                            ),
                            const SizedBox(width: 8),
                            // Slide to cancel text
                            Text(
                              'Slide to cancel',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$_recordingDuration s',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onLongPress: () {
                  setState(() {
                    _isRecording = true;
                    _isCancelling = false;
                    _startRecording();
                  });
                },
                onLongPressEnd: (_) {
                  if (!_isCancelling) {
                    _stopRecording();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF128C7E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isCancelling = false;

  void _cancelRecording() {
    _isRecording = false;
    _recordingTimer?.cancel();

    // Implement logic to discard the recording
    setState(() {
      _isCancelling = false;
    });

    // Optional: Show a toast or feedback that recording was cancelled
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recording cancelled'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isVoiceMessage;
  final String? audioPath;
  final DateTime timestamp;
  final bool isMe;
  final int? duration;
  final String id;

  ChatMessage({
    required this.text,
    required this.isVoiceMessage,
    required this.audioPath,
    required this.timestamp,
    required this.isMe,
    this.duration,
    required this.id,
  });
}

class WaveformDisplay extends StatefulWidget {
  final bool isPlaying;
  final int duration; // in seconds

  const WaveformDisplay({
    super.key,
    required this.isPlaying,
    required this.duration,
  });

  @override
  State<WaveformDisplay> createState() => _WaveformDisplayState();
}

class _WaveformDisplayState extends State<WaveformDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<double> _waveformHeights;
  final int _waveformBars = 20;

  @override
  void initState() {
    super.initState();
    // Generate random heights for the waveform bars
    _waveformHeights = List.generate(
        _waveformBars, (index) => 0.1 + _random.nextDouble() * 0.9);

    // Create animation controller for the playing animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(WaveformDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 25,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              _waveformBars,
              (index) {
                double animatedHeight = widget.isPlaying
                    ? _waveformHeights[index] * (0.6 + 0.4 * _controller.value)
                    : _waveformHeights[index] * 0.6;

                return Container(
                  width: 2,
                  height: 20 * animatedHeight,
                  decoration: BoxDecoration(
                    color: widget.isPlaying ? Colors.blue : Colors.grey[700],
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class AudioWaveform extends StatefulWidget {
  final bool isRecording;

  const AudioWaveform({super.key, required this.isRecording});

  @override
  _AudioWaveformState createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveform>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  final int _barsCount = 12;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _barsCount,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300 + _random.nextInt(700)),
      )..repeat(reverse: true),
    );

    // Start the animation if recording
    if (widget.isRecording) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(AudioWaveform oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecording != oldWidget.isRecording) {
      if (widget.isRecording) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
  }

  void _startAnimation() {
    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }

  void _stopAnimation() {
    for (var controller in _controllers) {
      controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        _barsCount,
        (index) => AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, child) {
            return Container(
              width: 5,
              height: 10.0 + 30.0 * _controllers[index].value,
              decoration: BoxDecoration(
                color: Color.lerp(
                  const Color(0xFF128C7E).withOpacity(0.5),
                  const Color(0xFF128C7E),
                  _controllers[index].value,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
