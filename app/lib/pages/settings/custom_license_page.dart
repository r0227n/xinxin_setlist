import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CustomLicensePage extends StatefulWidget {
  const CustomLicensePage({
    required String applicationName,
    String? applicationVersion,
    String? applicationLegalese,
    super.key,
  }) : _applicationName = applicationName,
       _applicationVersion = applicationVersion,
       _applicationLegalese = applicationLegalese;

  final String _applicationName;
  final String? _applicationVersion;

  final String? _applicationLegalese;

  @override
  State<CustomLicensePage> createState() => _CustomLicensePageState();
}

class _CustomLicensePageState extends State<CustomLicensePage> {
  late final Future<PackageInfo> _packageInfoFuture;

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _packageInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final packageInfo = snapshot.data!;

          // 引数がある場合は優先し、ない場合はPackageInfoから取得
          final name = widget._applicationName;
          final version = widget._applicationVersion ?? packageInfo.version;
          final legalese =
              widget._applicationLegalese ?? '© ${DateTime.now().year} $name';

          return LicensePage(
            applicationName: name,
            applicationVersion: version,
            applicationLegalese: legalese,
          );
        }

        return const LicensePage();
      },
    );
  }
}
