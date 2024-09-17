package com.kryptik.focus

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.util.Log
import android.view.KeyEvent
import android.view.accessibility.AccessibilityEvent
import java.time.DayOfWeek
import java.time.LocalDate
import java.time.LocalTime
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import java.util.*
import android.os.Handler
import android.os.Looper
import java.time.Duration
import android.content.Intent
import android.content.pm.PackageManager
import java.time.Instant
import java.time.ZoneId

data class Schedule(val name: String, val startTime: Long, val endTime: Long, val blockedApps: List<String>)


var overlayVisible: Boolean = false
var canUnblock = false
var canBlock = true
var currentSchedule: Schedule? = null


class AppBlockerService : AccessibilityService() {
    private var currentApp: String = "com.kryptik.focus"
    private val loopHandler = Handler(Looper.getMainLooper())
    private var runnable: Runnable? = null
    private var launcher: String? = null
    private lateinit var overlayService: OverlayService




    override fun onInterrupt() {
        // Handle interrupt
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or
                    AccessibilityEvent.TYPE_VIEW_CLICKED or
                    AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_REQUEST_FILTER_KEY_EVENTS or
                    AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
        }

        serviceInfo = info
        overlayService = OverlayService(this)
        launcher = getDefaultLauncherPackageName(this)
    }


    private fun blockApp() {

        val handler = Handler(Looper.getMainLooper())

        val runnable = Runnable {
//            Log.d("can block", canBlock.toString())
            if(canBlock) {
                val startMain = Intent(Intent.ACTION_MAIN)
                startMain.addCategory(Intent.CATEGORY_HOME)
                startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                this.startActivity(startMain)

                overlayVisible = true
                overlayService.showOverlay(message = "FOCUS")
                canUnblock = false
                canBlock = false

                invertFlag()
            }
        }

        handler.postDelayed(runnable, 1000)
    }

    fun unblockApp() {
        val handler = Handler(Looper.getMainLooper())

        val runnable = Runnable {
            Log.d("can unblock", "$canUnblock")
            if(canUnblock) {
                overlayVisible = false
                overlayService.hideOverlay()
                invertBlocker()
            }
        }

        handler.postDelayed(runnable, 1000)
    }

    fun invertFlag() {
        val handler = Handler(Looper.getMainLooper())

        val runnable = Runnable {
            canUnblock = true
        }

        handler.postDelayed(runnable, 2000)
    }


    override fun onAccessibilityEvent(event: AccessibilityEvent) {

        if (event.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString()
            Log.d("current app", "Detected package: $packageName")

            currentApp = packageName ?: ""

            packageName?.let {
                if(currentSchedule != null) {
                    val currentTime = LocalTime.now()

                    val st = Instant.ofEpochMilli(currentSchedule!!.startTime)
                    val startTime = st.atZone(ZoneId.systemDefault()).toLocalTime()
                    val et = Instant.ofEpochMilli(currentSchedule!!.endTime)
                    val endTime = et.atZone(ZoneId.systemDefault()).toLocalTime()

                    if(currentTime.isBefore(endTime) && currentTime.isAfter(startTime) && currentSchedule!!.blockedApps.contains(it) && !overlayVisible) {
                        blockApp()
                    }

                }
//                if (it == "com.google.android.youtube" && !overlayVisible) {
//                    blockApp()
//                }
            }
        }
    }


    fun getDefaultLauncherPackageName(context: Context): String? {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)
        val resolveInfo = context.packageManager.resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
        return resolveInfo?.activityInfo?.packageName
    }

}

fun invertBlocker() {
    val handler = Handler(Looper.getMainLooper())

    val runnable = Runnable {
        canBlock = true
    }

    handler.postDelayed(runnable, 1500)
}



// ####################  FOR SCHEDULES  ##############################
/*

if (event.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
//            var currentSchedule: Schedule? = findCurrentSchedule()
    val packageName = event.packageName?.toString()
    Log.d("current app", "$packageName  $overlayVisible")

    if(currentSchedule == null) {
        Log.d("Current schedule", "none")
    } else {
        currentSchedule?.name?.let { Log.d("Current schedule", it) }

        if(currentSchedule?.endTime == 0L || (currentSchedule?.endTime ?: Long.MAX_VALUE) > System.currentTimeMillis()) {
            packageName?.let {
                if (currentSchedule?.blockedApps?.contains(it) == true) { // Replace with the actual package name of the app to block
                    blockApp()
                } else if (overlayVisible && it != "com.android.systemui" && it != "work.getaligned.getaligned") {
                    overlayVisible = false
                    overlayService.hideOverlay()
                }
            }
        } else if((currentSchedule?.endTime ?: Long.MAX_VALUE) < System.currentTimeMillis()){
            currentSchedule = null
        }
    }
}

 */

/*
    fun findCurrentSchedule(): Schedule? {
        val currentTime = System.currentTimeMillis()

        return schedules.find { it.startTime <= currentTime && it.endTime >= currentTime }
    }

    fun remainingTime(app: String): Int {
        // app present in list
        for(timer in appTimers) {
            if((timer["package"] == app)) {
                // check day is selected
                for(day in (timer["days"] as List<String>)) {
                    if(DayOfWeek.valueOf(day.toUpperCase()) == LocalDate.now().dayOfWeek) {
                        // should be allowed in slot, else not
                        if((timer["slots"] as List<Map<String, Int>>).isEmpty()) {
                            // check duration
                            val used = getUsageTime(this, app)

                            messageToDisplay = "You have exceeded daily usage limit"
                            if(used >= timer["duration"] as Int) {
                                return 0
                            } else {
                                return (timer["duration"] as Int) - (used.toInt())
                            }
                        } else {
                            val currentTime = LocalTime.now()
                            // check time in slot
                            for(m: Map<String, Int>  in timer["slots"] as List<Map<String, Int>>) {
                                val startHour = m["startHour"]!!
                                val startMinute = m["startMinute"]!!
                                val endHour = m["endHour"]!!
                                val endMinute = m["endMinute"]!!

                                val startTime = LocalTime.of(startHour, startMinute)
                                val endTime = LocalTime.of(endHour, endMinute)

                                messageToDisplay = "${formattedTime(startTime)} - ${formattedTime(endTime)}"

                                if(currentTime.isBefore(endTime) && currentTime.isAfter(startTime)) {
                                    // check duration
                                    val used = getUsageTime(this, app)
                                    val duration = timer["duration"] as Int?

                                    if(duration == null) {
                                        return Duration.between(currentTime,endTime).seconds.toInt()
                                    } else {
                                        if (used >= duration) {
//                                            messageToDisplay = "You have exceeded daily usage limit, come back tomorrow!"

                                            return 0
                                        } else {
//                                            if((timer["duration"] as Int) - (used.toInt()) > Duration.between(currentTime,endTime).seconds.toInt()) {
//                                                messageToDisplay =
//                                                    "You can use the app between the between ${startTime} and ${endTime}"
//                                            } else {
//                                                messageToDisplay = "You have exceeded daily usage limit, come back tomorrow!"
//                                            }

                                            return minOf(
                                                (timer["duration"] as Int) - (used.toInt()),
                                                Duration.between(
                                                    currentTime,
                                                    endTime
                                                ).seconds.toInt()
                                            )
                                        }
                                    }
                                }
                            }

                            // if not block
                            return 0
                        }
                    }
                }

                // day not in list
                return 0
            }
        }

        return -1
    }

    fun getUsageTime(context: Context, packageName: String): Long {
        val usageStatsManager = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager

        // Get the current time
        val endTime = System.currentTimeMillis()

        // Get the start time of the current day
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        val startTime = calendar.timeInMillis

        // Get the aggregated usage stats for the specified time range
        val aggregatedUsageStatsMap: Map<String, UsageStats> = usageStatsManager.queryAndAggregateUsageStats(startTime, endTime)

        // Find the UsageStats for the specified package
        val usageStats = aggregatedUsageStatsMap[packageName]

        // Return the total time in seconds, or 0 if the package is not found
        return usageStats?.totalTimeInForeground?.div(1000) ?: 0
    }

    private fun formatSecondsToHMS(seconds: Long): String {
        val hours = seconds / 3600
        val minutes = (seconds % 3600) / 60
        val remainingSeconds = seconds % 60

        return String.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }

 */
