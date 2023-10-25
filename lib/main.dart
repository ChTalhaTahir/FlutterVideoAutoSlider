import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui';

void main() => runApp(const VideoLoopApp());

class VideoLoopApp extends StatelessWidget {
  const VideoLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: VideoLoopScreen(),
      ),
    );
  }
}

class VideoLoopScreen extends StatefulWidget {
  const VideoLoopScreen({super.key});

  @override
  _VideoLoopScreenState createState() => _VideoLoopScreenState();
}

class _VideoLoopScreenState extends State<VideoLoopScreen> {
  late VideoPlayerController _controller;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video1.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _controller.seekTo(Duration.zero);
      _controller.play();

      _currentVideoIndex = (_currentVideoIndex + 1) % 3;
      _controller = VideoPlayerController.asset('assets/video${_currentVideoIndex + 1}.mp4')
        ..initialize().then((_) {
          _controller.play();
          _controller.addListener(_videoListener);
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayerWidget(_controller),
        Positioned(
          top: 100,
          left: 16,
          right: 16,
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Flutter Auto Slider ",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 16),
              const Text("Auto Background Videos",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )),
              const SizedBox(height: 340),
              SizedBox(height: 70, width: 320, child: richText()),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Center(
                    child: Text(
                      "Create account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              const Center(
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  VideoPlayerWidget(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(controller),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        ],
      ),
    );
  }
}

Widget richText() {
  return RichText(
    text: TextSpan(
      children: [
        const TextSpan(
          text: "By signing up for Hinge, you agree to our ",
        ),
        TextSpan(
          text: "Terms of Services ",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () => print("Terms and Services"),
        ),
        const TextSpan(text: "Learn how we process your data in our "),
        TextSpan(
          text: "Privacy Policy ",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () => print("Privacy Statement"),
        ),
        const TextSpan(text: "and "),
        TextSpan(
          text: "Cookies Policy",
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => print("Cookies Statement"),
        ),
        const TextSpan(text: "."),
      ],
    ),
  );
}
