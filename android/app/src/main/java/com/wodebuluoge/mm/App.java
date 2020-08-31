package com.wodebuluoge.mm;

import android.annotation.SuppressLint;
import android.app.ActivityManager;
import android.content.Context;
import android.os.Build;
import android.util.Log;
import android.webkit.WebView;

import com.bun.miitmdid.core.IIdentifierListener;
import com.bun.miitmdid.core.JLibrary;
import com.bun.miitmdid.core.MdidSdkHelper;
import com.bun.miitmdid.supplier.IdSupplier;
import com.bytedance.sdk.openadsdk.TTAdConfig;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.kuaiyou.open.InitSDKManager;
import com.qq.e.comm.managers.GDTADManager;
import com.qq.e.comm.managers.setting.GlobalSetting;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;


import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @SuppressLint("StaticFieldLeak")
    private static final String PROCESS = "com.wodebuluoge.mm";

    private static Context mContext;
    @Override
    public void onCreate() {
        super.onCreate();
        this.initPieWebView();
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
        // 穿山甲广告 通过此方法初始化 SDK
        TTAdSdk.init(this,
                new TTAdConfig.Builder()
                        .appId("5102021")
                        .useTextureView(false) //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
                        .appName("我的部落格")
                        .titleBarTheme(TTAdConstant.TITLE_BAR_THEME_DARK)
                        .allowShowNotify(true) //是否允许sdk展示通知栏提示
                        .allowShowPageWhenScreenLock(true) //是否在锁屏场景支持展示广告落地页
                        .debug(true) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
                        .directDownloadNetworkType(TTAdConstant.NETWORK_STATE_WIFI, TTAdConstant.NETWORK_STATE_3G) //允许直接下载的网络状态集合
                        .supportMultiProcess(false) //是否支持多进程，true支持
                        //.httpStack(new MyOkStack3())//自定义网络库，demo中给出了okhttp3版本的样例，其余请自行开发或者咨询工作人员。
                        .build());


        GlobalSetting.setChannel(1);
        GlobalSetting.setEnableMediationTool(true);
    }


    private void initPieWebView() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            String processName = getProcessName(this);
            if (!PROCESS.equals(processName)) {
                WebView.setDataDirectorySuffix(getString(processName, "buluoge"));
            }
        }
    }


        public String getProcessName(Context context) {
        if (context == null) return null;
        ActivityManager manager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningAppProcessInfo processInfo : manager.getRunningAppProcesses()) {
            if (processInfo.pid == android.os.Process.myPid()) {
                return processInfo.processName;
            }
        }
        return null;
    }

    public String getString(String s, String defValue) {
        return isEmpty(s) ? defValue : s;
    }

    public boolean isEmpty(String s) {
        return s == null || s.trim().length() == 0;
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
