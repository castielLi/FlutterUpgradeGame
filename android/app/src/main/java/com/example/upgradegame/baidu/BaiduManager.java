package com.example.upgradegame.baidu;

import android.app.Activity;
import android.text.TextUtils;
import android.util.Log;

import com.baidu.mobads.rewardvideo.RewardVideoAd;
import com.example.upgradegame.Constant;

public class BaiduManager {
    private static final String TAG = "zhoux";

    public RewardVideoAd mRewardVideoAd;
    private Activity activity;

    private static BaiduManager instance;

    public static BaiduManager getInstance(Activity activity){
        if(instance == null){
            instance = new BaiduManager(activity);
        }
        return instance;
    }
    private BaiduManager(Activity activity){
        this.activity = activity;
    }
    public void showVideo(String posId){
        if(TextUtils.isEmpty(posId)){
            posId = Constant.BAIDU_VIDEOPOSID;
        }
        // 激励视屏产品可以选择是否使用SurfaceView进行渲染视频
        mRewardVideoAd = new RewardVideoAd(activity,
                posId, rewardVideoAdListener, true);
        mRewardVideoAd.load();
        mRewardVideoAd.show();
    }
    private RewardVideoAd.RewardVideoAdListener rewardVideoAdListener = new RewardVideoAd.RewardVideoAdListener() {
        @Override
        public void onVideoDownloadSuccess() {
            // 视频缓存成功
            // 说明：如果想一定走本地播放，那么收到该回调之后，可以调用show
            Log.i(TAG, "onVideoDownloadSuccess,isReady=" + mRewardVideoAd.isReady());
        }

        @Override
        public void onVideoDownloadFailed() {
            // 视频缓存失败，如果想走本地播放，可以在这儿重新load下一条广告，最好限制load次数（4-5次即可）。
            Log.i(TAG, "onVideoDownloadFailed");
        }

        @Override
        public void playCompletion() {
            // 播放完成回调，媒体可以在这儿给用户奖励
            Log.i(TAG, "playCompletion");
        }

        @Override
        public void onAdShow() {
            // 视频开始播放时候的回调
            Log.i(TAG, "onAdShow");
        }

        @Override
        public void onAdClick() {
            // 广告被点击的回调
            Log.i(TAG, "onAdClick");
        }

        @Override
        public void onAdClose(float playScale) {
            // 用户关闭了广告
            // 说明：关闭按钮在mssp上可以动态配置，媒体通过mssp配置，可以选择广告一开始就展示关闭按钮，还是播放结束展示关闭按钮
            // 建议：收到该回调之后，可以重新load下一条广告,最好限制load次数（4-5次即可）
            // playScale[0.0-1.0],1.0表示播放完成，媒体可以按照自己的设计给予奖励
            Log.i(TAG, "onAdClose" + playScale);
        }

        @Override
        public void onAdFailed(String arg0) {
            // 广告失败回调 原因：广告内容填充为空；网络原因请求广告超时
            // 建议：收到该回调之后，可以重新load下一条广告，最好限制load次数（4-5次即可）
            Log.i(TAG, "onAdFailed");

        }
    };
}
