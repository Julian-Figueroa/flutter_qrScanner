import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/directions_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      body: _loadPage(currIndex),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index) {
        setState(() {
          currIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Maps'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Directions'),
        ),
      ],
    );
  }

  Widget _loadPage(int currPage) {
    switch (currPage) {
      case 0:
        return MapsPage();
      case 1:
        return DirectionsPage();

        break;
      default:
        return MapsPage();
    }
  }

  void _scanQR() async {
    String futureString = '';

    // https://fernando-herrera.com
    // geo:40.67425780940018,-73.69557753046877

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    print('Future String: $futureString');
    if (futureString != null) {
      print("There's data");
    }
  }
}

// brew update
// brew uninstall --ignore-dependencies libimobiledevice
// brew uninstall --ignore-dependencies usbmuxd
// brew install --HEAD usbmuxd
// brew unlink usbmuxd
// brew link usbmuxd
// brew install --HEAD libimobiledevice
// brew uninstall --ignore-dependencies ideviceinstaller
// brew install ideviceinstaller

// brew uninstall --ignore-dependencies ios-deploy
// brew install ios-deploy

// <key>NSCameraUsageDescription</key>
// <string>camera description.</string>

// <key>NSPhotoLibraryUsageDescription</key>
// <string> photos description.</string>