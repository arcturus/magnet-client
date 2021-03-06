package org.mozilla.magnet;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class ReceiverAlarm extends BroadcastReceiver {
    String TAG = "ReceiverAlarm";

    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d(TAG, "on receive");
        Intent serviceIntent = new Intent(context, NotificationService.class);
        context.startService(serviceIntent);
    }
}