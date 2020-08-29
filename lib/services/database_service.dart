import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story/homescreen.dart';
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
          //.post('http://192.168.88.17:8000/device/adddevice_api', body: {
          .post('http://sedefbostanci.pythonanywhere.com/device/adddevice_api',
              body: {
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
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(now);

    final response2 = await http.post(
      //'http://192.168.88.17:8000/userDevices/add_device_user',
      'http://sedefbostanci.pythonanywhere.com/userDevices/add_device_user',
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
      final jsonData = json.decode(response2.body);
      getuDeviceID getudeviceid = new getuDeviceID.fromJson(jsonData);
      int takenUDeviceID = getudeviceid.udevice_id;

      print("udevice ekleme gönderildi");

      add_DevicePlants(takenUDeviceID);
    } else {
      print("udevice gönderilme hata verdi ");
      throw Exception('udevice error verdi');
    }
    //print(response2.body);
  }

  static add_DevicePlants(int udevice_id) async {
    final response3 = await http.post(
      //'http://192.168.88.17:8000/devicePlants/devicePlants_add/',
      'http://sedefbostanci.pythonanywhere.com/devicePlants/devicePlants_add/',
      body: {
        "uDevice_ID": "$udevice_id",
        "spot_1_ID": "0",
        "spot_2_ID": "0",
        "spot_3_ID": "0",
        "spot_4_ID": "0",
        "spot_5_ID": "0",
        "spot_6_ID": "0",
        "spot_1_Name": "null",
        "spot_2_Name": "null",
        "spot_3_Name": "null",
        "spot_4_Name": "null",
        "spot_5_Name": "null",
        "spot_6_Name": "null",
        "currentSpotSize": "0"
      },
    );
    if (response3.statusCode == 200) {
      final jsonData = json.decode(response3.body);
      print("response 3 geldi ");
    } else {
      throw Exception("device plants not added!");
    }

    print(response3.body);
    print("--------------------------------------");
  }

  static addPlants(
      int devicePlantsID,
      int remainingTime,
      String startingDate,
      String plantName,
      int avgGrowTime,
      String plantDescription,
      String plantTips,
      String deviceInfo,
      int currentSpot) async {
    print(devicePlantsID);
    print(remainingTime);
    print(avgGrowTime);
    print(startingDate);
    print(plantName);
    print(plantDescription);
    print(plantTips);
    print(deviceInfo);
    try {
      final responsePlant = await http.post(
        //'http://192.168.88.17:8000/deviceSlots/deviceSlots_add/',
        'http://sedefbostanci.pythonanywhere.com/deviceSlots/deviceSlots_add/',
        body: {
          "devicePlants_ID": "$devicePlantsID",
          "remaining_Time": "$remainingTime",
          "starting_Date": startingDate,
          "plant_Name": plantName,
          "avg_GrowTime": "$avgGrowTime",
          "plant_Description": plantDescription,
          "plant_Tips": plantTips,
          "device_Info": deviceInfo
        },
      );
      if (responsePlant.statusCode == 200) {
        print("Spota plant eklendi");
        print(responsePlant.body);
        final jsonData = json.decode(responsePlant.body);
        getSpotID getspotID = new getSpotID.fromJson(jsonData);
        int takenSpotID = getspotID.spot_ID;
        print(takenSpotID);
        updateuDevice(currentSpot, takenSpotID, plantName);
      } else {
        print("spota plant eklenemedi");
      }
    } catch (e) {
      print("hata burda " + e.toString());
    }
  }

  static updateuDevice(
      int spotNumber, int newSpotID, String newPlantName) async {
    final responseUpdate = await http.post(
        //"http://192.168.88.17:8000/deviceSlots/deviceSlotsUpdate/?spot_Number=" +
        "http://sedefbostanci.pythonanywhere.com/deviceSlots/deviceSlotsUpdate/?spot_Number=" +
            "$spotNumber" +
            "&spot_ID=" +
            "$newSpotID" +
            "&spot_Name=" +
            newPlantName);
    if (responseUpdate.statusCode == 200) {
      print("basarıyla guncellendi!");
    } else {
      print("güncellenemedi!");
    }
  }

  static deletePlant(int spotID, int spotNumber) async {
    print("spot ID " + "$spotID");
    print("spot Number " + "$spotNumber");
    final responseDelete = await http.delete(
        //"http://192.168.88.17:8000/deviceSlots/delete_deviceSpots/$spotID/$spotNumber");
        "http://sedefbostanci.pythonanywhere.com/deviceSlots/delete_deviceSpots/$spotID/$spotNumber");
    if (responseDelete.statusCode == 200) {
      print("plant başarıyla silindi!");
    } else {
      print("plant silinemedi!");
    }
  }

  static deleteDevice(int deviceID) async {
    print("deviceID :" + "$deviceID");

    final responseDelete = await http.delete(
        "http://sedefbostanci.pythonanywhere.com/device/delete_Device/$deviceID ");
    if (responseDelete.statusCode == 200) {
      print("Device başarıyla silindi!");
    } else {
      print("Device silinemedi!");
    }
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

class getuDeviceID {
  final int udevice_id;

  getuDeviceID({
    this.udevice_id,
  });

  factory getuDeviceID.fromJson(Map<String, dynamic> jsonData) {
    return getuDeviceID(udevice_id: jsonData['uDevice_ID']);
  }
}

class getSpotID {
  final int spot_ID;

  getSpotID({
    this.spot_ID,
  });

  factory getSpotID.fromJson(Map<String, dynamic> jsonData) {
    return getSpotID(spot_ID: jsonData['spot_ID']);
  }
}
