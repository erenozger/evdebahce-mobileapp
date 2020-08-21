import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story/models/user_model.dart';
import 'package:story/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

/*class DatabaseService{
  static Future<User> getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }
}*/
class DatabaseService {
  static getUserWithId(String userId) async {
    DocumentSnapshot userDocSnapshot = await usersRef.document(userId).get();
    if (userDocSnapshot.exists) {
      return User.fromDoc(userDocSnapshot);
    }
    return User();
  }

  static addDevice(
      String deviceName, String deviceType, int takenUserID) async {
    try {
      final response = await http
          .post('http://192.168.88.21:8000/device/adddevice_api', body: {
        "device_type": deviceType,
        "device_picture":
            "https://assets.wsimgs.com/wsimgs/ab/images/dp/wcm/202012/0988/img26c.jpg",
        "device_description":
            "This is detailed description of evdebahce device,Infina intern project automatic grow plant system.",
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        getDeviceID getdeviceid = new getDeviceID.fromJson(jsonData);
        int takenDeviceID = getdeviceid.device_id;

        add_uDevice(takenUserID, takenDeviceID, deviceName);
      } else {
        print("device gönderilme hata verdi ");
        throw Exception('Device ID gelmedi');
      }
      //print(response.body);
    } catch (e) {
      print(e);
    }
  }

  static add_uDevice(takenUserID, takenDeviceID, deviceName) async {
    print("--------------------------------------");
    print("add_udevice");
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(now);
    print("formatted date " + formattedDate);
    print("user id -> : " + '$takenUserID');
    print("--------------------------------------");
    final response2 = await http.post(
      'http://192.168.88.21:8000/userDevices/add_device_user',
      body: {
        "user_ID": "$takenUserID",
        "device_ID": "$takenDeviceID",
        "connection_Date": formattedDate,
        "wifi_name": "default",
        "wifi_password": "default",
        "device_WaterLevel": "0.0",
        "device_Name": deviceName,
      },
    );

    if (response2.statusCode == 200) {
      print("udevice ekleme gönderildi");
    } else {
      print("udevice gönderilme hata verdi ");
      throw Exception('udevice error verdi');
    }
    print(response2.body);
  }
}

class getDeviceID {
  final int device_id;

  getDeviceID({
    this.device_id,
  });

  factory getDeviceID.fromJson(Map<String, dynamic> jsonData) {
    return getDeviceID(device_id: jsonData['device_id']);
  }
}
