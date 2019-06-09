import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreader/src/pages/directions_page.dart';
import 'package:qrreader/src/pages/maps_page.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          ),
        ],
      ),
      body: _loadPage(currIndex),
      bottomNavigationBar: _createBottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
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

  void _scanQR(context) async {
    String futureString;

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scansBloc.addNewScan(scan);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
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
