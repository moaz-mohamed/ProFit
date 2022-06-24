import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:video_compress/video_compress.dart';

const baseWorkoutAPI = "https://profit-workout-counter.herokuapp.com/";

class WorkoutServices {
  getFile() async {
    final pickedFile = await FilePicker.platform.pickFiles();
    if (pickedFile != null) {
      return File(pickedFile.files.single.path!);
    } else {
      // User cancelled the picker
      throw Exception("No file selected");
    }
  }

  uploadFile(File workoutVideo, String workoutName) async {
    final String URI = baseWorkoutAPI + workoutName;
    final request = http.MultipartRequest('POST', Uri.parse(URI));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'workoutVideo',
        workoutVideo.readAsBytes().asStream(),
        workoutVideo.lengthSync(),
        filename: workoutVideo.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response httpResponse = await http.Response.fromStream(response);
    final jsonResponse = jsonDecode(httpResponse.body);
    return jsonResponse['message'];
  }
}
