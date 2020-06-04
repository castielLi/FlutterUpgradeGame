package com.example.upgradegame;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MyActivity extends FlutterActivity {
    private static final String TAG = "zhoux";
    private static final String METHODCHANNEL_NAME = "samples.flutter.ad";
    private static final String EVNETCHANNEL_NAME = "samples.flutter.ad.event";
    private EventChannel.EventSink sink;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 直接 new MethodChannel，然后设置一个Callback来处理Flutter端调用
        new MethodChannel(getFlutterView(), METHODCHANNEL_NAME).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        // 在这个回调里处理从Flutter来的调用
                        if(call.method.equals("toast")){
                            Toast.makeText(MyActivity.this, "失败是你的妈妈", Toast.LENGTH_SHORT).show();
                            sink.success("");
                        }
                    }
                });

        eventChanel();
    }
    private void eventChanel(){
        new EventChannel(getFlutterView(), EVNETCHANNEL_NAME).setStreamHandler(
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
}
