import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class OpenPdf extends StatefulWidget {
  final String licenseUrl;
  final String ownerName;
  const OpenPdf({super.key, required this.licenseUrl,required this.ownerName});

  @override
  State<OpenPdf> createState() => _OpenPdfState();
}

class _OpenPdfState extends State<OpenPdf> {
  @override
  void initState() {
    super.initState();
    getDeviceInfo();
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var info;
    if (Platform.isAndroid) {
      info = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      info = await deviceInfoPlugin.iosInfo;
    }
    print(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('${widget.ownerName} ( License proof )'),
      ),
      body: SfPdfViewer.network(widget.licenseUrl),
    );
  }
}


