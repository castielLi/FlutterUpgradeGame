package com.wodebuluoge.mm.chuanshanjia;

import android.app.Activity;
import android.util.Log;


import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTAppDownloadListener;
import com.bytedance.sdk.openadsdk.TTRewardVideoAd;
import com.wodebuluoge.mm.Constant;

import org.greenrobot.eventbus.EventBus;

import java.util.Timer;
import java.util.TimerTask;

import okhttp3.internal.concurrent.Task;

public class CSJManager {
    private static final String TAG = "zhoux";

    private Activity activity;
    private TTAdNative mTTAdNative;
    public AdSlot adSlot;
    public TTRewardVideoAd mttRewardVideoAd;
    public boolean mIsLoaded;
    public int times = 0;
    public Timer timer;
    public TimerTask task;
    private static CSJManager instance;

    public static CSJManager getInstance(Activity activity){
        if(instance == null){
            instance = new CSJManager(activity);
            instance.mTTAdNative = TTAdSdk.getAdManager().createAdNative(activity);
        }
        return instance;
    }
    private CSJManager(Activity activity){
        this.activity = activity;
    }
    public void showVideo(String posId){
        adSlot = new AdSlot.Builder()
                .setCodeId(posId)
                .setSupportDeepLink(true)
                .setAdCount(1)
                //个性化模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可
                .setExpressViewAcceptedSize(500,500)
                .setImageAcceptedSize(1080, 1920)
                .setRewardName("金币") //奖励的名称
                .setRewardAmount(0)   //奖励的数量
                //必传参数，表来标识应用侧唯一用户；若非服务器回调模式或不需sdk透传
                //可设置为空字符串
                .setUserID("")
                .setOrientation(TTAdConstant.VERTICAL)  //设置期望视频播放的方向，为TTAdConstant.HORIZONTAL或TTAdConstant.VERTICAL
                .setMediaExtra("media_extra") //用户透传的信息，可不传
                .build();
        setListener();
        mttRewardVideoAd.showRewardVideoAd(activity);

    }

    private void setListener(){
        mTTAdNative.loadRewardVideoAd(adSlot, new TTAdNative.RewardVideoAdListener() {
            @Override
            public void onError(int code, String message) {
                Log.i(TAG, "onAdFailed");
                EventBus.getDefault().post(Constant.STATUS_FAIL);
            }
            //视频广告加载后的视频文件资源缓存到本地的回调
            @Override
            public void onRewardVideoCached() {

                timer = new Timer();
                task = new TimerTask(){
                    @Override
                    public void run() {
                        Log.i(TAG,"timer开始执行了");
                        if(times == 0){
                            EventBus.getDefault().post(Constant.STATUS_FAIL);
                            timer.cancel();
                            task = null;
                        }
                    }
                };
                timer.schedule(task,4000,4000);

                Log.i(TAG, "onRewardVideoCached");
            }
            //视频广告素材加载到，如title,视频url等，不包括视频文件
            @Override
            public void onRewardVideoAdLoad(TTRewardVideoAd ad) {
                mIsLoaded = false;
                mttRewardVideoAd = ad;
                mttRewardVideoAd.setRewardAdInteractionListener(new TTRewardVideoAd.RewardAdInteractionListener() {

                    @Override
                    public void onAdShow() {
                        times += 1;
                        timer.cancel();
                        task = null;
                        Log.i(TAG, "onAdShow");
                        EventBus.getDefault().post(Constant.STATUS_RECEIVE);
                    }

                    @Override
                    public void onVideoError(){
                        Log.i(TAG, "onAdFailed");
                        EventBus.getDefault().post(Constant.STATUS_FAIL);
                    }

                    @Override
                    public void onSkippedVideo(){
                        Log.i(TAG, "onSkippedVideo");
                    }

                    @Override
                    public void onAdVideoBarClick() {
                        Log.i(TAG, "onAdVideoBarClick");
                    }

                    @Override
                    public void onAdClose() {
                        times = 0;
                        EventBus.getDefault().post(Constant.STATUS_CLOSE);
                    }

                    @Override
                    public void onVideoComplete() {
                        Log.i(TAG, "playCompletion");
                        EventBus.getDefault().post(Constant.STATUS_FINISH);
                    }

                    @Override
                    public void onRewardVerify(boolean rewardVerify, int rewardAmount, String rewardName) {
                        if(rewardVerify){
                            EventBus.getDefault().post(Constant.STATUS_30_COMPLETE);
                        }
                    }
                });
                mttRewardVideoAd.setDownloadListener(new TTAppDownloadListener() {
                    @Override
                    public void onIdle() {
                        Log.i(TAG, "onIdle");
                    }

                    @Override
                    public void onDownloadActive(long totalBytes, long currBytes, String fileName, String appName) {
                        Log.i(TAG, "onDownloadActive");
                    }

                    @Override
                    public void onDownloadPaused(long totalBytes, long currBytes, String fileName, String appName) {
                        Log.i(TAG, "onDownloadPaused");
                    }

                    @Override
                    public void onDownloadFailed(long totalBytes, long currBytes, String fileName, String appName) {
                        Log.i(TAG, "onDownloadFailed");
                    }

                    @Override
                    public void onDownloadFinished(long totalBytes, String fileName, String appName) {
                        Log.i(TAG, "onDownloadFinished");
                    }

                    @Override
                    public void onInstalled(String fileName, String appName) {
                        Log.i(TAG, "onInstalled");
                    }
                });
            }
        });
    }

}
