import 'dart:async';

import 'package:qrreader/src/bloc/validator.dart';
import 'package:qrreader/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    fetchScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController?.close();
  }

  fetchScans() async {
    _scansController.sink.add(
      await DBProvider.db.getAllScans(),
    );
  }

  addNewScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    fetchScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    fetchScans();
  }

  deleteAllScans() async {
    await DBProvider.db.clear();
    fetchScans();
  }
}
