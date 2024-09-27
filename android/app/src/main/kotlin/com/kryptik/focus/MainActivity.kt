package com.kryptik.focus

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.accessibility.AccessibilityManager
import androidx.annotation.NonNull
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit


class MainActivity: FlutterActivity() {
    private val CHANNEL = "focus-native-kotlin-channel"
//    private lateinit var overlayService: OverlayService
//    private val overlayPermissionCode = 2084


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        overlayService = OverlayService(this)

//        val serviceIntent = Intent(this, AppBlockerService::class.java)
//        startForegroundService(serviceIntent)  // Updated to use AppBlockerService
        // service restart
//        val workRequest = PeriodicWorkRequestBuilder<ServiceCheckerWorker>(15, TimeUnit.MINUTES)
//            .build()
//        WorkManager.getInstance(this).enqueue(workRequest)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when(call.method) {
//                "startService" -> {
//                    startService(Intent(this, AppDetectionService::class.java))
//                    Log.d("Foreground service", "Started")
//                    result.success(null)
//                }
//                "getUnlockCount" -> result.success(getTodayUnlockCount())
//                "fullScreenOverlay" -> overlayService.showOverlay(fullScreen = true, message = "You can't use this app")
//                "hideOverlay" -> overlayService.hideOverlay()
                "isAccessibilityServiceEnabled" -> result.success(PermissionsHandler.isAccessibilityServiceEnabled(this, AppBlockerService::class.java))
                "requestAccessibilityPermission" -> {
                    PermissionsHandler.openAccessibilitySettings(this)
                    result.success(null)
                }
                "hasOverlayPermission" -> result.success(PermissionsHandler.isOverlayPermissionGranted(this))
                "requestOverlayPermission" -> PermissionsHandler.requestOverlayPermission(this)
                "hasUsageStatsPermission" -> result.success(PermissionsHandler.hasUsageStatsPermission(this))
                "requestUsageStatsPermission" -> PermissionsHandler.requestUsageStatsPermission(this)
                "startSchedule" -> {
                    val scheduleJson = call.arguments as Map<String, Any>
                    val name = scheduleJson["name"] as String
                    val startTime = scheduleJson["startTime"] as Long
                    val endTime = scheduleJson["endTime"] as Long
                    val blockedApps = scheduleJson["blockedApps"] as List<String>

                    Log.d("SCHEDULE", "Started: $name  $startTime $endTime $blockedApps");

                    currentSchedule = Schedule(name = name, startTime = startTime, endTime = endTime.toLong(), blockedApps = blockedApps)

                    result.success(null)
                }
                "endSchedule" -> {
                    currentSchedule = null

                    Log.d("SCHEDULE", "Ended");

                    result.success(null)
                }
                "disableBatteryOptimization" -> {
                   PermissionsHandler.openBatteryOptimizationSettings(this)

                    result.success(null)
                }
                "checkBatteryOptimization" -> result.success(PermissionsHandler.isIgnoringBatteryOptimizations(this))


//                "setScreenTimeLimit" -> requestOverlayPermission()
//                "setAppTimer" -> {
//                    val timers = call.arguments as List<Map<String, Any>>
//                    Log.d("received", timers.toString())
//
//                    appTimers = timers.toMutableList()
//                    result.success(true)
//                }
//                "openAutostartPermission" -> gotoAutostartSetting()
                else -> result.notImplemented()
            }
        }
    }

    private fun gotoAutostartSetting() {
        try {
            val intent = Intent()
            val manufacturer = Build.MANUFACTURER
            when {
                "xiaomi".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.miui.securitycenter",
                        "com.miui.permcenter.autostart.AutoStartManagementActivity"
                    )
                }
                "oppo".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.coloros.safecenter",
                        "com.coloros.safecenter.permission.startup.StartupAppListActivity"
                    )
                }
                "vivo".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.vivo.permissionmanager",
                        "com.vivo.permissionmanager.activity.BgStartUpManagerActivity"
                    )
                }
                "letv".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.letv.android.letvsafe",
                        "com.letv.android.letvsafe.AutobootManageActivity"
                    )
                }
                "honor".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.huawei.systemmanager",
                        "com.huawei.systemmanager.optimize.process.ProtectActivity"
                    )
                }
                "asus".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.asus.mobilemanager",
                        "com.asus.mobilemanager.powersaver.PowerSaverSettings"
                    )
                }
                "nokia".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.evenwell.powersaving.g3",
                        "com.evenwell.powersaving.g3.exception.PowerSaverExceptionActivity"
                    )
                }
                "huawei".equals(manufacturer, ignoreCase = true) -> {
                    intent.component = ComponentName(
                        "com.huawei.systemmanager",
                        "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity"
                    )
                }
            }
            startActivity(intent)
        } catch (e: Exception) {
            /*Timber.e(e)*/
            Log.e("AUTOSTART SETTING", "Error while opening autostart setting: $e")
        }
    }

}
