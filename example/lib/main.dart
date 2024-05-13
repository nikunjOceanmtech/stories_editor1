import 'package:flutter/material.dart';
import 'package:stories_editor/stories_editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter stories editor Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: 1 == 1
            ? StoriesEditor(
                videoView: Container(color: Colors.white),
                onNextButtonTap: (imagePath) {
                  print("=========$imagePath");
                },
                onDownloadTap: () {},
                onEffectTap: () {},
                isShowFilterIcon: false,
                onFilterCancelTap: () {},
                onFilterDoneTap: () {},
                onMusicTap: () {},
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoriesEditor(
                        videoView: Container(
                          color: Colors.amber,
                        ),
                        onNextButtonTap: (imagePath) {
                          print("=========$imagePath");
                        },
                        onDownloadTap: () {},
                        onEffectTap: () {},
                        isShowFilterIcon: true,
                        onFilterCancelTap: () {},
                        onFilterDoneTap: () {},
                        onMusicTap: () {},
                      ),
                    ),
                  );
                },
                child: const Text('Open Stories Editor'),
              ),
      ),
    );
  }
}
