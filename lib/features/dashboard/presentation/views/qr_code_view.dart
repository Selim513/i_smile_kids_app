import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/helper/asset_helper.dart';
import 'package:i_smile_kids_app/core/widgets/custom_primary_appbar.dart';

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomPrimaryAppbar(title: 'Confirm Visit'),
      body: Center(child: AssetHelper.imageAsset(name: 'qr_code')),
    );
  }
}
