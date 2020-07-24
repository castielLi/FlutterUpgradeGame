import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/httpManager.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/team/model/qrCodeModel.dart';
import 'dart:async';
import 'package:upgradegame/Src/service/serviceUrl.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

class TeamService {
  static Future<ResultData> getTeamList(callback) async {
    var response = await httpManager.request(ServiceUrl.getTeamList(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      callback(response.data);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }

  static Future<ByteData> shareImageToWeChat(GlobalKey repaintWidgetKey,callback) async {
    try {
      RenderRepaintBoundary boundary = repaintWidgetKey.currentContext
          .findRenderObject();
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData _byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List sourceBytes = _byteData.buffer.asUint8List();
      Directory tempDir = await getTemporaryDirectory();

      String storagePath = tempDir.path;
      File file = new File('$storagePath/二维码截图.png');

      if (!file.existsSync()) {
        file.createSync();
      }else{
        file.delete();
      }
      file.writeAsBytesSync(sourceBytes);

      callback(file,"二维码截图");

    } catch (e) {
      print(e);
    }
    return null;
  }


  static Future<ResultData> getQRCode(callback) async {
    var response = await httpManager.request(ServiceUrl.getQRCode(), {}, null, null);
    if (ConfigSetting.SUCCESS == response.code) {
      QRCodeModel model = QRCodeModel.fromJson(response.data);
      callback(model);
    } else {
      CommonUtils.showErrorMessage(msg: '网络请求失败，请重试');
      callback(null);
    }
    return response;
  }
}
