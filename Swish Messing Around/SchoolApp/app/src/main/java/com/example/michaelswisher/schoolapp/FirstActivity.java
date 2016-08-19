package com.example.michaelswisher.schoolapp;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class FirstActivity extends AppCompatActivity {


    public void mapBtn(View view){
        Intent myIntent = new Intent(FirstActivity.this, PlacesList.class);
        FirstActivity.this.startActivity(myIntent);
    }

    public void d2lBtn(View view){
        Uri d2l_uri = Uri.parse("https://learn.colorado.edu/");
        Intent d2l_intent = new Intent(Intent.ACTION_VIEW, d2l_uri);
        startActivity(d2l_intent);
    }

    public void moodleBtn(View view){
        Uri moodle_uri = Uri.parse("https://moodle.cs.colorado.edu/");
        Intent moodle_intent = new Intent(Intent.ACTION_VIEW, moodle_uri);
        startActivity(moodle_intent);
    }

    public void mycuinfoBtn(View view){
        Uri mycuinfo_uri = Uri.parse("https://mycuinfo.colorado.edu/");
        Intent mycuinfo_intent = new Intent(Intent.ACTION_VIEW, mycuinfo_uri);
        startActivity(mycuinfo_intent);
    }

    public void diningBtn(View view){
        Uri dining_uri = Uri.parse("https://housing.colorado.edu/dining/menus");
        Intent dining_intent = new Intent(Intent.ACTION_VIEW, dining_uri);
        startActivity(dining_intent);
    }

    public void parkBtn(View view) {
        Uri parking_uri = Uri.parse("http://www.colorado.edu/pts/parking-services");
        Intent parking_intent = new Intent(Intent.ACTION_VIEW, parking_uri);
        startActivity(parking_intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first);

        getSupportActionBar().setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        getSupportActionBar().setCustomView(R.layout.action_layout);
    }
}
