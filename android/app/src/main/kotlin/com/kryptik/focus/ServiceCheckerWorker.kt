package com.kryptik.focus

import android.accessibilityservice.AccessibilityService
import android.content.Context
import android.content.Intent
import android.provider.Settings
import android.text.TextUtils
import android.view.accessibility.AccessibilityManager
import androidx.work.Worker
import androidx.work.WorkerParameters

class ServiceCheckerWorker(context: Context, workerParams: WorkerParameters) : Worker(context, workerParams) {

    override fun doWork(): Result {
        // Check if the service is running
        if (!isAccessibilityServiceEnabled(applicationContext, AppBlockerService::class.java)) {
            // If not, restart it
            restartAccessibilityService(applicationContext)
        }
        return Result.success()
    }

    // Method to check if Accessibility Service is running
    private fun isAccessibilityServiceEnabled(context: Context, service: Class<out AccessibilityService>): Boolean {
        val am = context.getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        val enabledServices = Settings.Secure.getString(context.contentResolver, Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES)
        val colonSplitter = TextUtils.SimpleStringSplitter(':')
        colonSplitter.setString(enabledServices)
        while (colonSplitter.hasNext()) {
            val componentName = colonSplitter.next()
            if (componentName.equals(service.name, ignoreCase = true)) {
                return true
            }
        }
        return false
    }

    // Method to restart the service
    private fun restartAccessibilityService(context: Context) {
        val intent = Intent(context, AppBlockerService::class.java)
        context.startService(intent)
    }
}
