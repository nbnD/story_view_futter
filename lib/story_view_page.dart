
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  final int index;
  final List<String> model;
  const StoryViewPage(this.model,this.index, {Key? key}) : super(key: key);

  @override
  State<StoryViewPage> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryViewPage> {
  final storyController = StoryController();

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          StoryView(
            controller: storyController,
            storyItems: [

              // int i = widget.index because we want to load the story just after the clicked item
              for (int i = widget.index; i < widget.model.length; i++)
                StoryItem.inlineImage(
                  imageFit: BoxFit.contain,
                  url: (widget.model[i]),
                  controller: storyController,
                  caption: const Text(
                  "Caption Here",
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                ),
                
            ],
            onStoryShow: (s) {

            },
            onComplete: () {
                
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            inline: true,
          ),
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child:const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            ),
        ],
      )),
    );
  }
}
