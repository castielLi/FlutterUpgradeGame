package com.example.upgradegame;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.example.upgradegame.adview.AdSpreadActivity;
import com.example.upgradegame.adview.AdViewManager;
import com.example.upgradegame.adview.PermissionListener;
import com.example.upgradegame.baidu.BaiduManager;
import com.example.upgradegame.baidu.SplashActivity;
import com.example.upgradegame.tencent.TencentManager;
import com.example.upgradegame.tencent.TentcentSplashActivity;
import com.kuaiyou.open.InitSDKManager;
import com.kuaiyou.open.InstlManager;
import com.kuaiyou.open.VideoManager;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MyActivity extends FlutterActivity {
    private static final String TAG = "zhoux";
    private static final String METHODCHANNEL_NAME = "samples.flutter.ad";
    private static final String EVNETCHANNEL_NAME = "samples.flutter.ad.event";
    private EventChannel.EventSink sink;
    public String[] permissions = null;
    private PermissionListener mlistener;
    private VideoManager videoManager = null;
    private InstlManager instlManager = null;
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        Log.e(TAG, "configureFlutterEngine");
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
        // 直接 new MethodChannel，然后设置一个Callback来处理Flutter端调用
        new MethodChannel(flutterEngine.getDartExecutor(), METHODCHANNEL_NAME).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        try {
                            // 在这个回调里处理从Flutter来的调用
                            if (call.method.equals("showAd")) {
                                // type 1 adview 2-百度广告 3-广点通
                                int type = call.argument("type");
                                // showType 1 开屏 2 视频
                                int showType = call.argument("showType");
                                String posId = call.argument("posId");
                                if(type == 1){
                                    if(showType == 1){
                                        Intent intent = new Intent(MyActivity.this, AdSpreadActivity.class);
                                        intent.putExtra("posId",posId);
                                        startActivity(intent);
                                    } else  if(showType == 2){
                                        AdViewManager.getInstance(MyActivity.this,sink).adView(posId);
                                    }
                                } else if(type == 2){
                                    if(showType == 1){
                                        Intent intent = new Intent(MyActivity.this, SplashActivity.class);
                                        intent.putExtra("posId",posId);
                                        startActivity(intent);
                                    } else  if(showType == 2){
                                        BaiduManager.getInstance(MyActivity.this).showVideo(posId);
                                    }
                                } else if(type == 3){
                                    if(showType == 1){
                                        Intent intent = new Intent(MyActivity.this, TentcentSplashActivity.class);
                                        intent.putExtra("posId",posId);
                                        startActivity(intent);
                                    } else  if(showType == 2){
                                        TencentManager.getInstance(MyActivity.this).showVideo(posId);
                                    }
                                }

                            }
                        } catch (Exception e){

                        }
                    }
                });
        new EventChannel(flutterEngine.getDartExecutor(), EVNETCHANNEL_NAME).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object args, final EventChannel.EventSink events) {
                        Log.w(TAG, "adding listener");
                        sink = events;
                    }

                    @Override
                    public void onCancel(Object args) {
                        Log.w(TAG, "cancelling listener");
                    }
                }
        );
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.e(TAG, "onCreate");
        //下载类广告默认弹出二次确认框，如需关闭提示请设置如下；设置后对全部广告生效
        InitSDKManager.setDownloadNotificationEnable(false);
        //在调用SDK之前，如果您的App的targetSDKVersion >= 23，那么一定要把"READ_PHONE_STATE"、"WRITE_EXTERNAL_STORAGE"这几个权限申请到
        permissions = new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.READ_PHONE_STATE};
        if (Build.VERSION.SDK_INT >= 23) {
            requestRunTimePermission(permissions, new PermissionListener() {

                @Override
                public void onGranted(List<String> grantedPermission) {
                    this.onGranted();
                }

                @Override
                public void onGranted() {

                }

                @Override
                public void onDenied(List<String> deniedPermission) {
                    Toast.makeText(MyActivity.this, deniedPermission.get(0) + "权限被拒绝了", Toast.LENGTH_SHORT).show();
                }
            });
        }

    }

    /**
     * 权限申请
     *
     * @param permissions 待申请的权限集合
     * @param listener    申请结果监听事件
     */
    protected void requestRunTimePermission(String[] permissions,
                                            PermissionListener listener) {
        this.mlistener = listener;

        // 用于存放为授权的权限
        List<String> permissionList = new ArrayList<>();
        for (String permission : permissions) {
            // 判断是否已经授权，未授权，则加入待授权的权限集合中
            if (ContextCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
                permissionList.add(permission);
            }
        }

        // 判断集合
        if (!permissionList.isEmpty()) { // 如果集合不为空，则需要去授权
            ActivityCompat.requestPermissions(this,
                    permissionList.toArray(new String[permissionList.size()]),
                    1);
        } else { // 为空，则已经全部授权
            listener.onGranted();
        }
    }

    /**
     * 权限申请结果
     *
     * @param requestCode  请求码
     * @param permissions  所有的权限集合
     * @param grantResults 授权结果集合
     */
    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case 1:
                if (grantResults.length > 0) {
                    // 被用户拒绝的权限集合
                    List<String> deniedPermissions = new ArrayList<>();
                    // 用户通过的权限集合
                    List<String> grantedPermissions = new ArrayList<>();
                    for (int i = 0; i < grantResults.length; i++) {
                        // 获取授权结果，这是一个int类型的值
                        int grantResult = grantResults[i];

                        if (grantResult != PackageManager.PERMISSION_GRANTED) { // 用户拒绝授权的权限
                            String permission = permissions[i];
                            deniedPermissions.add(permission);
                        } else { // 用户同意的权限
                            String permission = permissions[i];
                            grantedPermissions.add(permission);
                        }
                    }

                    if (deniedPermissions.isEmpty()) { // 用户拒绝权限为空
                        mlistener.onGranted();
                    } else { // 不为空
                        Toast.makeText(this, "应用缺少必要的权限！请点击\"权限\"，打开所需要的权限。", Toast.LENGTH_LONG).show();
                        // 回调授权成功的接口
                        mlistener.onDenied(deniedPermissions);
                        // 回调授权失败的接口
                        mlistener.onGranted(grantedPermissions);
                        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                        intent.setData(Uri.parse("package:" + getPackageName()));
                        startActivity(intent);
                    }
                }
                break;
            default:
                break;
        }
    }
}
