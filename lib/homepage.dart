import "package:flutter/material.dart";
import 'package:dashed_circle/dashed_circle.dart';
import 'package:story_view_flutter/story_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// It is configured to only tick when the current tree is enabled.

// SingleTickerProviderStateMixin is used when there is only a single Animation COntoller.
/// AnimationControllers can be created with vsync: this because of TickerProviderStateMixin.

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //gap between the dots
  late Animation<double> gap;

// the point of animation
  late Animation<double> base;

  // it  reverse the animation
  late Animation<double> reverse;

  // constructor whenever you create a new animation controller.
  late AnimationController controller;

  var model = [
    "https://images-static.nykaa.com/uploads/f5a1d948-7947-4241-a08e-caac8d991c48.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/c622c7aa-7cdb-43ba-98b7-acb48df7f7c5.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/fea188e3-9067-4c1f-a3a3-07560f60d73d.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/2f2275d3-0b85-4189-8fb3-7318ca1c3bec.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/9a4d3606-9aeb-4285-8db1-4918428a1c76.jpg?tr=w-300,cm-pad_resize",
    "https://images-static.nykaa.com/uploads/455bf3cd-82d4-4b2c-ab5d-e56491edc0f1.jpg?tr=w-300,cm-pad_resize",
  ];

  @override
  void initState() {
    super.initState();

// We pass vsync: this to the animation controller to create an Animation controller in a class
// that uses this mixin
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
// curved animation  applies curves to animation
//it is especially used if we want different curves when animation is moving forward or backward

    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
// A linear interpolation between a beginning and ending value.
    //to revert the animation of the image when borders are animating
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);

    gap = Tween<double>(begin: 15.0, end: 0.0)
        .animate(base) //the gap between the dots
      ..addListener(() {
        //.. This syntax means that the addListener() method is called
        // with the return value from animate().
        setState(() {});
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Story View")),
        body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: model.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(context,
                          // A modal route that replaces the entire screen with a platform-specific transition.
                          // For Android, the entrance transition for the
                          // page zooms in and fades in while the exiting page zooms out and fades out.
                          // The exit transition is similar, but in reverse.

                          // For iOS, the page slides in from the right and exits in reverse.

                          MaterialPageRoute(builder: (_) {
                        return StoryViewPage(model, index);
                      })),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: RotationTransition(
                                //it animates the rotation of widget
                                turns: base,
                                child: DashedCircle(
                                  gapSize: gap.value,
                                  dashes: 20,
                                  color: Theme.of(context).primaryColor,
                                  child: RotationTransition(
                                    turns: reverse,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage:
                                            NetworkImage(model[index]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )));
  }
}
