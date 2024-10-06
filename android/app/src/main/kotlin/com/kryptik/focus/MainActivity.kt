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
import android.service.notification.NotificationListenerService
import android.util.Log
import android.view.accessibility.AccessibilityManager
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit


class MainActivity: FlutterActivity() {
    private val CHANNEL = "focus-native-kotlin-channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // service restart
//        val workRequest = PeriodicWorkRequestBuilder<ServiceCheckerWorker>(15, TimeUnit.MINUTES)
//            .build()
//        WorkManager.getInstance(this).enqueue(workRequest)
    }

    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when(call.method) {
                "isAccessibilityServiceEnabled" -> result.success(PermissionsHandler.isAccessibilityServiceEnabled(this, AppBlockerService::class.java))
                "requestAccessibilityPermission" -> {
                    PermissionsHandler.openAccessibilitySettings(this)
                    result.success(null)
                }
                "hasOverlayPermission" -> result.success(PermissionsHandler.isOverlayPermissionGranted(this))
                "requestOverlayPermission" -> PermissionsHandler.requestOverlayPermission(this)
                "hasReadNotificationPermission" -> result.success(PermissionsHandler.isNotificationServiceEnabled(this))
                "requestReadNotificationsPermission" -> PermissionsHandler.openReadNotificationSetting(this)
                "hasUsageStatsPermission" -> result.success(PermissionsHandler.isNotificationServiceEnabled(this))
                "requestUsageStatsPermission" -> PermissionsHandler.requestUsageStatsPermission(this)
                "startSchedule" -> {
                    val scheduleJson = call.arguments as Map<String, Any>
                    val name = scheduleJson["name"] as String
                    val startTime = scheduleJson["startTime"] as Long
                    val endTime = scheduleJson["endTime"] as Long
                    val blockedApps = scheduleJson["blockedApps"] as List<String>
                    val notificationsBlocked = scheduleJson["blockNotifications"] as Boolean

                    Log.d("SCHEDULE", "Started: $name  $startTime $endTime $blockedApps");
                    Log.d("NOTIFICATION BLOCK", "$blockNotifications");

                    currentSchedule = Schedule(name = name, startTime = startTime, endTime = endTime.toLong(), blockedApps = blockedApps)
                    blockNotifications = notificationsBlocked

                    if (notificationsBlocked ) {
                        if(!PermissionsHandler.isNotificationServiceEnabled(context)) {
                            PermissionsHandler.openReadNotificationSetting(context)
                        }

                        val intent1 = Intent(this, NotificationBlockerService::class.java)
                        startService(intent1)


                        val intent = Intent("com.kryptik.focus.BLOCK_NOTIFICATIONS")
                        sendBroadcast(intent)
                    }

                    result.success(null)
                }
                "endSchedule" -> {
                    currentSchedule = null
                    blockNotifications = false

                    Log.d("SCHEDULE", "Ended");

                    result.success(null)
                }
                "disableBatteryOptimization" -> {
                   PermissionsHandler.openBatteryOptimizationSettings(this)

                    result.success(null)
                }
                "checkBatteryOptimization" -> result.success(PermissionsHandler.isIgnoringBatteryOptimizations(this))
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
            Log.e("AUTOSTART SETTING", "Error while opening autostart setting: $e")
        }
    }

}
