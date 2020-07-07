package com.example.upgradegame.adview;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.text.TextUtils;
import android.util.Log;

import com.example.upgradegame.Constant;
import com.kuaiyou.open.AdManager;
import com.kuaiyou.open.InstlManager;
import com.kuaiyou.open.VideoManager;
import com.kuaiyou.open.interfaces.AdViewInstlListener;
import com.kuaiyou.open.interfaces.AdViewSpreadListener;
import com.kuaiyou.open.interfaces.AdViewVideoListener;

import org.greenrobot.eventbus.EventBus;

import io.flutter.plugin.common.EventChannel;

public class AdViewManager {
    private static final String TAG = "zhoux";

    private static AdViewManager instance;
    private VideoManager videoManager = null;
    private InstlManager instlManager = null;
    private Activity activity;
    public static AdViewManager getInstance(Activity activity){
        if(instance == null){
            instance = new AdViewManager(activity);
        }
        return instance;
    }
    private AdViewManager(Activity activity){
        this.activity = activity;
        videoManager = AdManager.createVideoAd();
        instlManager = AdManager.createInstlAd();
    }
    // 视频广告
    public void adView(String postId){
        if(TextUtils.isEmpty(postId)){
            postId = Constant.ADVIEW_VIDEOPOSID;
        }
        videoManager = AdManager.createVideoAd();
        videoManager.loadVideoAd(activity, Constant.ADVIEW_APPID, postId);
        videoManager.setVideoListener(adViewVideoListener);
        // 设置屏幕方向，取值可参照ActivityInfo.SCREEN_XXXXXX 定义的常量
        videoManager.setVideoOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }
    private AdViewVideoListener adViewVideoListener = new AdViewVideoListener() {
        @Override
        public void onReceivedVideo() {
            Log.i(TAG, "onReceivedVideo");
        }

        @Override
        public void onFailedReceivedVideo(String error) {
            Log.i(TAG, "onFailedRecievedVideo:" + error);
        }

        @Override
        public void onVideoStartPlayed() {
            Log.i(TAG, "onVideoStartPlayed");
        }

        @Override
        public void onVideoFinished() {
            Log.i(TAG, "onVideoFinished");
            EventBus.getDefault().post(Constant.STATUS_FINISH);
        }

        @Override
        public void onVideoClicked() {
            Log.i(TAG, "onVideoClicked");
        }

        @Override
        public void onVideoClosed() {
            Log.i(TAG, "onVideoClosed");

        }

        @Override
        public void onPlayedError(String arg0) {
            Log.i(TAG, "onPlayedError:" + arg0);
        }

        @Override
        public void onVideoReady() {
            Log.i(TAG, "onVideoReady");
            videoManager.playVideo(activity);
        }
    };
}
