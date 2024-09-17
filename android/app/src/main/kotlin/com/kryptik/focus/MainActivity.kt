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
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "focus-native-kotlin-channel"
//    private lateinit var overlayService: OverlayService
//    private val overlayPermissionCode = 2084


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        overlayService = OverlayService(this)

//        val serviceIntent = Intent(this, AppBlockerService::class.java)
//        startForegroundService(serviceIntent)  // Updated to use AppBlockerService
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
                "isAccessibilityServiceEnabled" -> result.success(isAccessibilityServiceEnabled(this, AppBlockerService::class.java))
                "requestAccessibilityPermission" -> {
                    openAccessibilitySettings()
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

    private fun isAccessibilityServiceEnabled(context: Context, service: Class<out AccessibilityService>): Boolean {
        val am = context.getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        val enabledServicesList = am.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK)

        for (enabledServiceInfo in enabledServicesList) {
            val componentName = enabledServiceInfo.resolveInfo.serviceInfo.packageName + "/" + enabledServiceInfo.resolveInfo.serviceInfo.name
            Log.d("AccessibilityCheck", "Enabled Service: $componentName")
            if (componentName.equals("${context.packageName}/${service.name}", ignoreCase = true)) {
                return true
            }
        }

        return false
    }

    private fun openAccessibilitySettings() {
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
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
