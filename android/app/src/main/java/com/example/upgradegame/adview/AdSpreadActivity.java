package com.example.upgradegame.adview;

import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Window;
import android.view.WindowManager;
import android.widget.RelativeLayout;

import com.example.upgradegame.Constant;
import com.example.upgradegame.R;
import com.kuaiyou.open.AdManager;
import com.kuaiyou.open.SpreadManager;
import com.kuaiyou.open.interfaces.AdViewSpreadListener;

/**
 * 开屏
 */
public class AdSpreadActivity extends Activity implements AdViewSpreadListener {
    private SpreadManager spreadManager = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.spread_layout);
        requestSpreadAd(getIntent().getStringExtra("posId"));
    }

    private void requestSpreadAd(String posId) {
        if(TextUtils.isEmpty(posId)){
            posId = Constant.ADVIEW_SPREADPOSID;
        }
        spreadManager = AdManager.createSpreadAd();
        spreadManager.loadSpreadAd(this, Constant.ADVIEW_APPID, posId,
                (RelativeLayout) findViewById(R.id.spreadlayout));
        spreadManager.setBackgroundColor(Color.WHITE);
        spreadManager.setSpreadNotifyType(AdManager.NOTIFY_COUNTER_NUM);
        spreadManager.setSpreadListener(this);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK)
            return false;
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onAdClicked() {
        Log.i("AdViewDemo", "onAdClicked");
    }

    @Override
    public void onAdClosed() {
        Log.i("AdViewDemo", "onAdClosedAd");
        jump();
    }

    @Override
    public void onAdClosedByUser() {
        Log.i("AdViewDemo", "onAdClosedByUser");
        jump();
    }

    @Override
    public void onRenderSuccess() {

    }

    @Override
    public void onAdDisplayed() {
        Log.i("AdViewDemo", "onAdDisplayed");
    }

    @Override
    public void onAdFailedReceived(String arg1) {
        Log.i("AdViewDemo", "onAdRecieveFailed");
        jump();
    }

    @Override
    public void onAdReceived() {
        Log.i("AdViewDemo", "onAdRecieved");
    }

    @Override
    public void onAdSpreadPrepareClosed() {
        Log.i("AdViewDemo", "onAdSpreadPrepareClosed");
        jump();
    }

    private void jump() {
        this.finish();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (null != spreadManager)
            spreadManager.destroy();
    }
}
