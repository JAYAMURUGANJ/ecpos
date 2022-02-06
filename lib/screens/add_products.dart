import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  File imagefile;
  Location location = Location();
  LocationData _currentPosition;
  String _dateTime;

  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imagefile = File(imagepath);
        getLoc();
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
                if (_dateTime != null)
                  Text(
                    "Date/Time: $_dateTime",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                SizedBox(
                  height: 3,
                ),
                if (_currentPosition != null)
                  Text(
                    "Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
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

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
      });
    });
  }
}
