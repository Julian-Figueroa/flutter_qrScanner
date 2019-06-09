import 'package:flutter/material.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final map = new MapController();

  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Coordinates'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createFlutterMap(context, scan),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFlutterMap(BuildContext context, ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0,
      ),
      layers: [
        _createMap(),
        _createMarkers(scan),
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: "https://api.mapbox.com/v4/"
          "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
      additionalOptions: {
        'accessToken':
            'XXX',
        'id': 'mapbox.$mapType', // dark, light, outdoors, satellite
      },
    );
  }

  _createMarkers(ScanModel scan) {
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 70.0,
                ),
              ),
        ),
      ],
    );
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (mapType == 'streets') {
          mapType = 'dark';
        } else if (mapType == 'dark') {
          mapType = 'light';
        } else if (mapType == 'light') {
          mapType = 'outdoors';
        } else if (mapType == 'outdoors') {
          mapType = 'satellite';
        } else {
          mapType = 'streets';
        }
        setState(() {});
      },
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
