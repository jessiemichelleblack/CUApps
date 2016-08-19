package littlebird.androidapp2;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

public class LaunchActivity extends AppCompatActivity {


    private static boolean splashLoaded = false;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_launch);

        if (!splashLoaded) {
            setContentView(R.layout.activity_launch);
            int secondsDelayed = 1;

            new Handler().postDelayed(new Runnable() {
                public void run() {
                    startActivity(new Intent(LaunchActivity.this, MainActivity.class));
                    finish();
                }
            }, secondsDelayed * 2000);

            splashLoaded = true;
        }
        else {
            Intent goToMainActivity = new Intent(LaunchActivity.this, MainActivity.class);
            goToMainActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
            startActivity(goToMainActivity);
            finish();
        }
    }
}
