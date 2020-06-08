package com.example.upgradegame.baidu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.RelativeLayout;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.baidu.mobads.SplashAd;
import com.baidu.mobads.SplashLpCloseListener;
import com.example.upgradegame.R;

public class SplashActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.spread_layout);
        fetchSplashAD(getIntent().getStringExtra("posId"));
    }
    private void fetchSplashAD(String posId) {
        if(TextUtils.isEmpty(posId)){
            posId = "2058622";
        }
        // 默认请求https广告，若需要请求http广告，请设置AdSettings.setSupportHttps为false
        // AdSettings.setSupportHttps(false);
        // 设置视频广告最大缓存占用空间(15MB~100MB),默认30MB,单位MB
        // SplashAd.setMaxVideoCacheCapacityMb(30);
        // adUnitContainer
        RelativeLayout adsParent = findViewById(R.id.spreadlayout);


//        AdSettings.setSupportHttps(false);
        // 如果开屏需要支持vr,needRequestVRAd(true)
//        SplashAd.needRequestVRAd(true);
        // 等比缩小放大，裁剪边缘部分
//        SplashAd.setBitmapDisplayMode(BitmapDisplayMode.DISPLAY_MODE_CENTER_CROP);
        new SplashAd(this, adsParent, listener, posId, true);
    }
    // 增加lp页面关闭回调，不需要该回调的继续使用原来接口就可以
    SplashLpCloseListener listener = new SplashLpCloseListener() {
        @Override
        public void onLpClosed() {
            Log.i("RSplashActivity", "onLpClosed");
            jump();
        }

        @Override
        public void onAdDismissed() {
            Log.i("RSplashActivity", "onAdDismissed");
            jump();
        }

        @Override
        public void onAdFailed(String arg0) {
            jump();
            Log.i("RSplashActivity", arg0);
        }

        @Override
        public void onAdPresent() {
            Log.i("RSplashActivity", "onAdPresent");
        }

        @Override
        public void onAdClick() {
            Log.i("RSplashActivity", "onAdClick");
            // 设置开屏可接受点击时，该回调可用
        }
    };
    /**
     * 不可点击的开屏，使用该jump方法，而不是用jumpWhenCanClick
     */
    private void jump() {
        this.finish();
    }
}
