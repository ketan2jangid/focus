package com.kryptik.focus

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.os.SystemClock
import android.util.Log

var blockNotifications: Boolean = false

class NotificationBlockerService : NotificationListenerService() {
    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            Log.d("NotificationBlocker", "Received block command")
        }
    }

    override fun onCreate() {
        super.onCreate()
        val filter = IntentFilter("com.kryptik.focus.BLOCK_NOTIFICATIONS")

        registerReceiver(receiver, filter)
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(receiver)
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if(currentSchedule != null && blockNotifications) {
            if (System.currentTimeMillis() < currentSchedule!!.endTime && currentSchedule!!.blockedApps.contains(sbn.packageName)) {
                cancelNotification(sbn.key)
            }
        }
    }

}
