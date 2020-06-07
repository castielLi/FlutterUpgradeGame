package com.example.upgradegame.adview;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.util.Log;
import android.view.ViewGroup;

import com.example.upgradegame.Constant;
import com.kuaiyou.open.AdManager;
import com.kuaiyou.open.InstlManager;
import com.kuaiyou.open.SpreadManager;
import com.kuaiyou.open.VideoManager;
import com.kuaiyou.open.interfaces.AdViewInstlListener;
import com.kuaiyou.open.interfaces.AdViewSpreadListener;
import com.kuaiyou.open.interfaces.AdViewVideoListener;

import io.flutter.plugin.common.EventChannel;

public class AdViewManager {
    private static final String TAG = "zhoux";

    private static AdViewManager instance;
    private EventChannel.EventSink sink;
    private VideoManager videoManager = null;
    private InstlManager instlManager = null;
    private Activity activity;
    public static AdViewManager getInstance(Activity activity,EventChannel.EventSink sink){
        if(instance == null){
            instance = new AdViewManager(activity,sink);
        }
        return instance;
    }
    private AdViewManager(Activity activity,EventChannel.EventSink sink){
        this.sink = sink;
        this.activity = activity;
        videoManager = AdManager.createVideoAd();
        instlManager = AdManager.createInstlAd();
    }
    // 插屏广告
    public void instlAd(){
        instlManager= AdManager.createInstlAd();
        instlManager.loadInstlAd(activity, Constant.APPID,Constant.INSTLPOSID, true);//有关闭按钮：true，无关闭按钮：false
        instlManager.setInstlListener(adViewInstlListener);
    }
    // 视频广告
    public void adView(){
        videoManager = AdManager.createVideoAd();
        videoManager.loadVideoAd(activity, Constant.APPID, Constant.VIDEOPOSID);
        videoManager.setVideoListener(adViewVideoListener);
        // 设置屏幕方向，取值可参照ActivityInfo.SCREEN_XXXXXX 定义的常量
        videoManager.setVideoOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }
    private AdViewInstlListener adViewInstlListener = new AdViewInstlListener() {
        @Override
        public void onAdClicked() {
            Log.i(TAG, "onAdClicked");
            sink.success(Constant.STATUS_CLICK);
        }

        @Override
        public void onAdClosed() {
            Log.i(TAG, "onAdClosedAd");
            sink.success(Constant.STATUS_CLOSE);
        }

        @Override
        public void onAdReady() {
            Log.i(TAG, "onAdReady");
            instlManager.showInstl(activity);
            sink.success(Constant.STATUS_READY);
        }

        @Override
        public void onAdDisplayed() {
            Log.i(TAG, "onDisplayed");
            sink.success(Constant.STATUS_DISPLAY);
        }

        @Override
        public void onAdFailedReceived( String arg1) {
            Log.i(TAG, "onAdRecieveFailed："+arg1);
            sink.success(Constant.STATUS_FAIL);
        }

        @Override
        public void onAdReceived() {
            Log.i(TAG, "onAdRecieved");
            sink.success(Constant.STATUS_RECEIVE);
        }
    };
    private AdViewVideoListener adViewVideoListener = new AdViewVideoListener() {
        @Override
        public void onReceivedVideo() {
            Log.i(TAG, "onReceivedVideo");
            sink.success(Constant.STATUS_RECEIVE);
        }

        @Override
        public void onFailedReceivedVideo(String error) {
            Log.i(TAG, "onFailedRecievedVideo:" + error);
            sink.success(Constant.STATUS_FAIL);
        }

        @Override
        public void onVideoStartPlayed() {
            Log.i(TAG, "onVideoStartPlayed");
            sink.success(Constant.STATUS_DISPLAY);
        }

        @Override
        public void onVideoFinished() {
            Log.i(TAG, "onVideoFinished");
            sink.success(Constant.STATUS_FINISH);
        }

        @Override
        public void onVideoClicked() {
            Log.i(TAG, "onVideoClicked");
            sink.success(Constant.STATUS_CLICK);
        }

        @Override
        public void onVideoClosed() {
            Log.i(TAG, "onVideoClosed");
            sink.success(Constant.STATUS_CLOSE);
        }

        @Override
        public void onPlayedError(String arg0) {
            Log.i(TAG, "onPlayedError:" + arg0);
            sink.success(Constant.STATUS_FAIL);
        }

        @Override
        public void onVideoReady() {
            Log.i(TAG, "onVideoReady");
            videoManager.playVideo(activity);
            sink.success(Constant.STATUS_READY);
        }
    };
    private AdViewSpreadListener adViewSpreadListener = new AdViewSpreadListener() {
        @Override
        public void onAdClicked() {
            Log.i("AdViewDemo", "onAdClicked");
        }

        @Override
        public void onAdClosed() {
            Log.i(TAG, "onAdClosedAd");
//            jump();
        }

        @Override
        public void onAdClosedByUser() {
            Log.i(TAG, "onAdClosedByUser");
//            jump();
        }

        @Override
        public void onRenderSuccess() {
            Log.i(TAG, "onRenderSuccess");
        }

        @Override
        public void onAdDisplayed() {
            Log.i(TAG, "onAdDisplayed");
        }

        @Override
        public void onAdFailedReceived(String arg1) {
            Log.i(TAG, "onAdRecieveFailed");
//            jump();
        }

        @Override
        public void onAdReceived() {
            Log.i(TAG, "onAdRecieved");
        }

        @Override
        public void onAdSpreadPrepareClosed() {
            Log.i(TAG, "onAdSpreadPrepareClosed");
//            jump();
        }
    };
}
