package com.kryptik.focus

import android.annotation.TargetApi
import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.os.Process
import android.content.pm.PackageManager

object PermissionsHandler {
    const val overlayPermissionCode = 101 // You can use this in MainActivity
    const val usageStatsPermissionCode = 102 // Add a unique code for UsageStats permission


    // Method to check if overlay permission is granted
    fun isOverlayPermissionGranted(context: Context): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Settings.canDrawOverlays(context)
        } else {
            true // Permissions below API 23 are granted at install time
        }
    }

    // Method to request overlay permission
    fun requestOverlayPermission(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && !Settings.canDrawOverlays(context)) {
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:${context.packageName}"))
            if (context is MainActivity) {
                context.startActivityForResult(intent, overlayPermissionCode)
            }
        }
    }

    // Method to check if usage stats permission is granted
    @TargetApi(Build.VERSION_CODES.KITKAT)
    fun hasUsageStatsPermission(context: Context): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), context.packageName)
        return mode == AppOpsManager.MODE_ALLOWED
    }

    // Method to request usage stats permission
    fun requestUsageStatsPermission(context: Context) {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        if (context is MainActivity) {
            context.startActivityForResult(intent, usageStatsPermissionCode)
        }
    }
}
