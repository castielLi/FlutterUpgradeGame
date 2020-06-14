package com.example.upgradegame;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;

import com.bun.miitmdid.core.IIdentifierListener;
import com.bun.miitmdid.core.JLibrary;
import com.bun.miitmdid.core.MdidSdkHelper;
import com.bun.miitmdid.supplier.IdSupplier;
import com.kuaiyou.open.InitSDKManager;
import com.qq.e.comm.managers.GDTADManager;
import com.qq.e.comm.managers.setting.GlobalSetting;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @SuppressLint("StaticFieldLeak")
    private static Context mContext;
    @Override
    public void onCreate() {
        super.onCreate();
        mContext = this;
        // adView 初始化
        InitSDKManager.getInstance().init(getApplicationContext());

        //集成信通院MSA http://msa-alliance.cn/
        try {
            // 初始化MSA SDK
            JLibrary.InitEntry(this);
            //获取OAID
            int sdkState = MdidSdkHelper.InitSdk(getApplicationContext(), true, new IIdentifierListener() {
                @Override
                public void OnSupport(boolean b, IdSupplier idSupplier) {
                    if (idSupplier != null) {
                        String oaid = idSupplier.getOAID();
                        Log.e("oaid","oaid=" + oaid);
                    }
                }
            });
            Log.e("mdidsdk","初始化" + sdkState);
        } catch (Throwable tr) {
            tr.printStackTrace();
        }
        // 腾讯广告 通过调用此方法初始化 SDK。如果需要在多个进程拉取广告，每个进程都需要初始化 SDK。
        GDTADManager.getInstance().initWith(this, Constant.TENCENT_APPID);

        GlobalSetting.setChannel(1);
        GlobalSetting.setEnableMediationTool(true);
    }
    public static Context getContext() {
        return mContext;
    }
    private void initProperties(){
        Properties properties = new Properties();
        try {
            InputStream in = getAssets().open("test.properties");
            properties.load(in);
            in.close();

            Constant.ADVIEW_APPID = properties.getProperty("ADVIEW_APPID");
            Constant.ADVIEW_SPREADPOSID = properties.getProperty("ADVIEW_SPREADPOSID");
            Constant.ADVIEW_VIDEOPOSID = properties.getProperty("ADVIEW_VIDEOPOSID");
            Constant.TENCENT_APPID = properties.getProperty("TENCENT_APPID");
            Constant.TENCENT_SPREADPOSID = properties.getProperty("TENCENT_SPREADPOSID");
            Constant.TENCENT_VIDEOPOSID = properties.getProperty("TENCENT_VIDEOPOSID");
            Constant.BAIDU_APPID = properties.getProperty("BAIDU_APPID");
            Constant.BAIDU_SPREADPOSID = properties.getProperty("BAIDU_SPREADPOSID");
            Constant.BAIDU_VIDEOPOSID = properties.getProperty("BAIDU_VIDEOPOSID");

        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
