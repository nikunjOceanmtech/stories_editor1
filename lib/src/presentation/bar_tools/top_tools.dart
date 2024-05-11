// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/utils/modal_sheets.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';
import 'package:stories_editor/src/presentation/widgets/tool_button.dart';

class TopTools extends StatefulWidget {
  final GlobalKey contentKey;
  final BuildContext context;
  const TopTools({super.key, required this.contentKey, required this.context});

  @override
  TopToolsState createState() => TopToolsState();
}

class TopToolsState extends State<TopTools> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<ControlNotifier, PaintingNotifier, DraggableWidgetNotifier>(
      builder: (_, controlNotifier, paintingNotifier, itemNotifier, __) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ToolButton(
                //   backGroundColor: Colors.black12,
                //   onTap: () async {
                //     var res = await exitDialog(context: widget.context, contentKey: widget.contentKey);
                //     if (res) {
                //       Navigator.pop(context);
                //     }
                //   },
                //   child: Image(
                //     height: 100.h,
                //     image: const AssetImage(
                //       'assets/icons/back_arrow.png',
                //       package: 'stories_editor',
                //     ),
                //   ),
                // ),
                Row(
                  children: [
                    ToolButton(
                      backGroundColor: Colors.black12,
                      onTap: () => createGiphyItem(context: context, giphyKey: controlNotifier.giphyKey),
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/stickers.png',
                          package: 'stories_editor',
                        ),
                        height: 100.h,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    ToolButton(
                      backGroundColor: Colors.black12,
                      onTap: () => controlNotifier.isTextEditing = !controlNotifier.isTextEditing,
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/text.png',
                          package: 'stories_editor',
                        ),
                        height: 100.h,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    ToolButton(
                      backGroundColor: Colors.black12,
                      onTap: () async {
                        if (paintingNotifier.lines.isNotEmpty || itemNotifier.draggableWidget.isNotEmpty) {
                          var response =
                              await takePicture(contentKey: widget.contentKey, context: context, saveToGallery: true);
                          if (response) {
                            Fluttertoast.showToast(msg: 'Successfully saved');
                          } else {
                            Fluttertoast.showToast(msg: 'Error');
                          }
                        }
                      },
                      child: Image(
                        image: const AssetImage(
                          'assets/icons/download.png',
                          package: 'stories_editor',
                        ),
                        height: 100.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// gradient color selector
  Widget selectColor({onTap, controlProvider}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
      child: AnimatedOnTapButton(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: controlProvider.gradientColors![controlProvider.gradientIndex]),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
