package com.example.upgradegame.tencent;

import android.app.Activity;
import android.os.SystemClock;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.baidu.mobads.rewardvideo.RewardVideoAd;
import com.qq.e.ads.rewardvideo.RewardVideoAD;
import com.qq.e.ads.rewardvideo.RewardVideoADListener;
import com.qq.e.comm.util.AdError;

import java.util.Date;
import java.util.Locale;
import java.util.Map;

public class TencentManager {
    private static final String TAG = "zhoux";

    // 线上广告位id
    private static final String AD_PLACE_ID = "5925490";
    private RewardVideoAD rewardVideoAD;
    private Activity activity;

    private static TencentManager instance;

    public static TencentManager getInstance(Activity activity){
        if(instance == null){
            instance = new TencentManager(activity);
        }
        return instance;
    }
    private TencentManager(Activity activity){
        this.activity = activity;
    }
    public void showVideo(String posId){
        if(TextUtils.isEmpty(posId)){
            posId = "6040295592058680";
        }
        rewardVideoAD = new RewardVideoAD(activity, TConstant.APPID,posId, rewardVideoADListener,true);
        // 2. 加载激励视频广告
        rewardVideoAD.loadAD();
        rewardVideoAD.showAD();
    }
    private RewardVideoADListener rewardVideoADListener = new RewardVideoADListener() {
        /**
         * 广告加载成功，可在此回调后进行广告展示
         **/
        @Override
        public void onADLoad() {
            Log.d(TAG, "eCPMLevel = " + rewardVideoAD.getECPMLevel());
        }

        /**
         * 视频素材缓存成功，可在此回调后进行广告展示
         */
        @Override
        public void onVideoCached() {
            rewardVideoAD.showAD();
            Log.i(TAG, "onVideoCached");
        }

        /**
         * 激励视频广告页面展示
         */
        @Override
        public void onADShow() {
            Log.i(TAG, "onADShow");
        }

        /**
         * 激励视频广告曝光
         */
        @Override
        public void onADExpose() {
            Log.i(TAG, "onADExpose");
        }

        /**
         * 激励视频触发激励（观看视频大于一定时长或者视频播放完毕）
         */
        @Override
        public void onReward() {
            Log.i(TAG, "onReward");
        }

        /**
         * 激励视频广告被点击
         */
        @Override
        public void onADClick() {
            Map<String, String> map = rewardVideoAD.getExts();
            String clickUrl = map.get("clickUrl");
            Log.i(TAG, "onADClick clickUrl: " + clickUrl);
        }

        /**
         * 激励视频播放完毕
         */
        @Override
        public void onVideoComplete() {
            Log.i(TAG, "onVideoComplete");
        }

        /**
         * 激励视频广告被关闭
         */
        @Override
        public void onADClose() {
            Log.i(TAG, "onADClose");
        }

        /**
         * 广告流程出错
         */
        @Override
        public void onError(AdError adError) {
            String msg = String.format(Locale.getDefault(), "onError, error code: %d, error msg: %s",
                    adError.getErrorCode(), adError.getErrorMsg());
            Log.i(TAG, "onError, adError=" + msg);
        }
    };
}
