import 'package:flutter/material.dart';
import 'package:qrreader/src/bloc/scans_bloc.dart';
import 'package:qrreader/src/models/scan_model.dart';
import 'package:qrreader/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.fetchScans();
    
    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text("There's no data available"),
          );
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
                child: ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[i].value),
                  subtitle: Text('Id Scan: ${scans[i].id}'),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  onTap: () => utils.openScan(context, scans[i]),
                ),
              ),
        );
      },
    );
  }
}
