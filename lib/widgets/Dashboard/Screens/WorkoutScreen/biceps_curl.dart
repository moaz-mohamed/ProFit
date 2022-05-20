import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

class BicepCamera extends StatefulWidget {
  late final List<CameraDescription> cameras;

  BicepCamera({required this.cameras});

  @override
  BicepCameraState createState() => new BicepCameraState();
}

class BicepCameraState extends State<BicepCamera> {
  late CameraController cameraController;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      cameraController = new CameraController(
        widget.cameras[1],
        ResolutionPreset.high,
      );
      cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });

      cameraController.startImageStream((CameraImage image) {});
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    // tmp = cameraController.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(""),
      ),
      body: OverflowBox(
        maxHeight: screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
        child: CameraPreview(cameraController),
      ),
    );
  }
}
