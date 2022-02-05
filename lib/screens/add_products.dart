import 'dart:io';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  File imagefile;
  //String location = '';
  String finalDate = '';

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imagefile = File(imagepath);
        getCurrentDate();
        //Position position = await _getGeoLocationPosition();
        //location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Open Image"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                imagepath != ""
                    ? Image.file(imagefile)
                    : Container(
                        child: Text("No Image selected."),
                      ),
                Center(child: Text("$imagefile" ?? "")),
                SizedBox(
                  height: 20,
                ),
                Center(child: Text("$finalDate" ?? "")),
                ElevatedButton(
                  onPressed: () {
                    openImage();
                  },
                  child: Text("Open Image"),
                ),
              ],
            ),
          ),
        ));
  }
}

// Future<Position> _getGeoLocationPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     await Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
// }
// onPressed: () async {
//   Uint8List bytes = await imagefile.readAsBytes();
//   var result = await ImageGallerySaver.saveImage(
//       bytes,
//       quality: 60,
//       name: "new_mage.jpg");
//   print(result);

// },