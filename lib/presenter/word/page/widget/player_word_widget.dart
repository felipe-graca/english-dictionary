import 'package:english_dictionary/core/feature/word_signification/cubit/word_signification_cubit.dart';
import 'package:english_dictionary/presenter/word/page/widget/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlayerWordWidget extends StatefulWidget {
  const PlayerWordWidget({Key? key}) : super(key: key);

  @override
  State<PlayerWordWidget> createState() => _PlayerWordWidgetState();
}

class _PlayerWordWidgetState extends State<PlayerWordWidget> with SingleTickerProviderStateMixin {
  final wordSignificationCubit = GetIt.I.get<WordSignificationCubit>();

  late AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Total duration of the progress bar
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _animationController.reset();
      wordSignificationCubit.pauseSpeak();
    } else {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        wordSignificationCubit.stopSpeak();
      }
      _animationController.forward();
      wordSignificationCubit.startSpeak(wordSignificationCubit.state.word.word);
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          PlayButtonWidget(onTap: _togglePlayPause, isPlayed: _isPlaying),
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        height: 5,
                        width: _animationController.value * MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
