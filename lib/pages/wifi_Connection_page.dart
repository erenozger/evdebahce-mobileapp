import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';

class WifiConnectionPage extends StatefulWidget {
  @override
  _WifiConnectionPageState createState() => _WifiConnectionPageState();
}

class _WifiConnectionPageState extends State<WifiConnectionPage> {
  String _wifiName = 'click button to get wifi ssid.';
  int level = 0;
  String _ip = 'click button to get ip.';
  List<WifiResult> ssidList = [];
  String ssid = '', password = '';
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                //Navigator.pop(context);
              },
            ),
            ListView.builder(
              padding: EdgeInsets.all(64.0),
              itemCount: ssidList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return itemSSID(index);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemSSID(index) {
    if (index == 0) {
      return Column(
        children: [
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('ssid'),
                onPressed: _getWifiName,
              ),
              Offstage(
                offstage: level == 0,
                child: Image.asset(
                    level == 0
                        ? 'assets/images/wifi1.png'
                        : 'assets/images/wifi$level.png',
                    width: 28,
                    height: 21),
              ),
              Text(_wifiName),
            ],
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('ip'),
                onPressed: _getIP,
              ),
              Text(_ip),
            ],
          ),
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.wifi),
              hintText: 'Your wifi ssid',
              labelText: 'ssid',
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              ssid = value;
            },
          ),
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              icon: Icon(Icons.lock_outline),
              hintText: 'Your wifi password',
              labelText: 'password',
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              password = value;
            },
          ),
          RaisedButton(
            child: Text('connection'),
            onPressed: connection,
          ),
        ],
      );
    } else {
      return Column(children: <Widget>[
        ListTile(
          leading: Image.asset(
              'assets/images/wifi${ssidList[index - 1].level}.png',
              width: 28,
              height: 21),
          title: Text(
            ssidList[index - 1].ssid,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
            ),
          ),
          dense: true,
        ),
        Divider(),
      ]);
    }
  }

  void loadData() async {
    Wifi.list('').then((list) {
      setState(() {
        ssidList = list;
      });
    });
  }

  Future<Null> _getWifiName() async {
    int l = await Wifi.level;
    String wifiName = await Wifi.ssid;
    setState(() {
      level = l;
      _wifiName = wifiName;
    });
  }

  Future<Null> _getIP() async {
    String ip = await Wifi.ip;
    setState(() {
      _ip = ip;
    });
  }

  Future<Null> connection() async {
    Wifi.connection(ssid, password).then((v) {
      print(v);
    });
  }
}