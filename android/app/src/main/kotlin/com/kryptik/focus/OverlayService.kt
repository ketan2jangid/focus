package com.kryptik.focus


import android.annotation.TargetApi
import android.content.Context
import android.content.Intent
import android.content.res.Resources
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView

class OverlayService() {
    private lateinit var context: Context
    private var overlayView: View? = null
    private var windowManager: WindowManager? = null
    private var layoutParams: WindowManager.LayoutParams? = null

    constructor(context: Context) : this() {
        this.context = context
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    fun showOverlay(message: String) {
        if (overlayView == null) {
            val frameLayout = FrameLayout(context)

            val linearLayout = LinearLayout(context).apply {
                orientation = LinearLayout.VERTICAL
                gravity = Gravity.CENTER
                setPadding(16, 16, 16, 16)

                val backgroundDrawable = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE
                    cornerRadius = TypedValue.applyDimension(
                        TypedValue.COMPLEX_UNIT_DIP, 0f, resources.displayMetrics
                    )
                    setColor(Color.parseColor("#FFFFFFFF"))
                }
                background = backgroundDrawable
            }

            // Create a TextView and add it to the LinearLayout
            val headerTextView = TextView(context).apply {
                text = "FOCUS"
                gravity = Gravity.CENTER
                textSize = 16f
                setTextColor(Color.parseColor("#1E1E1E"))
            }
            headerTextView.textAlignment = View.TEXT_ALIGNMENT_CENTER
            linearLayout.addView(headerTextView)

            val messageTextView = TextView(context).apply {
                text = "App is Blocked"
                gravity = Gravity.CENTER
                textSize = 22f
                setTextColor(Color.BLACK)
                setTypeface(null, Typeface.BOLD)
            }
            messageTextView.textAlignment = View.TEXT_ALIGNMENT_CENTER
            linearLayout.addView(messageTextView)

            val subtitleTextView = TextView(context).apply {
                text = "App is blocked"
                gravity = Gravity.CENTER
                textSize = 22f
                setTextColor(Color.RED)
                setPadding(16, 24, 16, 16)
            }
            subtitleTextView.textAlignment = View.TEXT_ALIGNMENT_CENTER
//            linearLayout.addView(subtitleTextView)

            // Add the LinearLayout to the FrameLayout
            frameLayout.addView(linearLayout)

            // Create the button
            val button = Button(context).apply {
                text = "CLOSE"
                textSize = 16f
                setTextColor(Color.WHITE)

                val backgroundDrawable = GradientDrawable().apply {
                    shape = GradientDrawable.RECTANGLE
                    cornerRadius = 16f
                    setColor(Color.parseColor("#1E1E1E"))
                }
                background = backgroundDrawable

                setOnClickListener {
                    Log.d("From app", "Button is pressed")

                    val startMain = Intent(Intent.ACTION_MAIN)
                    startMain.addCategory(Intent.CATEGORY_HOME)
                    startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    context.startActivity(startMain)
                    hideOverlay()

                    overlayVisible = false
                    invertBlocker()
                }
            }

            // Set button's width and position
            val buttonLayoutParams = FrameLayout.LayoutParams(
                260, FrameLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                gravity = Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL // Align button to the bottom center
                bottomMargin = 120 // 160px above the bottom of the screen
            }
            button.layoutParams = buttonLayoutParams

            // Add button to FrameLayout
            frameLayout.addView(button)

            // Assign the FrameLayout to overlayView
            overlayView = frameLayout

            val navigationBarHeight = getNavigationBarHeight(context)
            val displayMetrics = Resources.getSystem().displayMetrics
            val screenHeight = displayMetrics.heightPixels
//            val overlayHeight = screenHeight - (navigationBarHeight * 0.5).toInt()

            val layoutParamsType = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            else
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_SYSTEM_ALERT

            layoutParams = WindowManager.LayoutParams(
                WindowManager.LayoutParams.MATCH_PARENT,
                screenHeight,
                layoutParamsType,
                WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL or
                        WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                        WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                PixelFormat.TRANSLUCENT
            ).apply {
                gravity = Gravity.TOP
            }

            windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            windowManager?.addView(overlayView, layoutParams)
        }
    }


    fun hideOverlay() {
        if (overlayView != null) {
            windowManager?.removeView(overlayView)
            overlayView = null
        }
    }

    private fun getNavigationBarHeight(context: Context): Int {
        val resources = context.resources
        val resourceId = resources.getIdentifier("navigation_bar_height", "dimen", "android")
        return if (resourceId > 0) {
            resources.getDimensionPixelSize(resourceId)
        } else {
            0
        }
    }

}