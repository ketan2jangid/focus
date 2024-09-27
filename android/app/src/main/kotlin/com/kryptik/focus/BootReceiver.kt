package com.kryptik.focus

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Intent.ACTION_BOOT_COMPLETED) {
            context?.let {
                val serviceIntent = Intent(it, AppBlockerService::class.java)
                it.startService(serviceIntent)
            }
        }
    }
}
