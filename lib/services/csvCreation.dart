import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateCSV {

  
  
  late String filePath;

  Future<int> getcsv(int index) async {
    var version;

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
      version = androidInfo.version.release;
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      print('$systemName $version, $name $model');
      // iOS 13.1, iPhone 11 Pro Max iPhone
      version = iosInfo.systemVersion;
    }

    List<List<dynamic>> rows = <List<List<dynamic>>>[];

    var cloud = await FirebaseFirestore.instance
        .collection("Quran $index")
        .orderBy('ID')
        .get();

    rows.add([
      "Paraa No.",
      "Taker Name",
      "Status",
    ]);

    if (cloud.docs != null) {
      for (int i = 0; i < cloud.size; i++) {
        List<dynamic> row = <List<dynamic>>[];
        
        row.add(cloud.docs[i]['ID']);
        row.add(cloud.docs[i]['taker']);
        if(cloud.docs[i]['taker'] != 'None'){
          if(cloud.docs[i]['completed'])
            row.add('Completed!');
          else
            row.add('In progress...');
        }
        else
          row.add('Not Taken');
        rows.add(row);
      }
    }
    
    var permission = await Permission.manageExternalStorage.request();

    String dir;

    if(PermissionStatus.granted == permission){
      if(Platform.isAndroid){  
        dir = '/storage/emulated/0/Download/';
      }
      else
        dir = (await getApplicationDocumentsDirectory()).path + "/Quran $index";

    File f = new File( dir + "Quran $index sheet ${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}.csv");
    

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
    }

    print(rows);
    return Future.value(1);
    }

}
