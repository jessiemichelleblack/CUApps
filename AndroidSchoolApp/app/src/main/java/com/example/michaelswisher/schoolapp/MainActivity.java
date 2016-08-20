package com.example.michaelswisher.schoolapp;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener(){
            public void onItemClick(AdapterView<?> listView, View view, int position, long id){
                String optionName = (String) listView.getItemAtPosition(position);

                //Intent intent = new Intent(MainActivity.this, )
                switch (optionName){
                    case "Places":
                        Intent places_intent = new Intent(MainActivity.this, PlacesList.class);
                        startActivity(places_intent);
                        break;

                    case "Dining":
                        Uri dining_uri = Uri.parse("https://housing.colorado.edu/dining/menus");
                        Intent dining_intent = new Intent(Intent.ACTION_VIEW, dining_uri);
                        startActivity(dining_intent);
                        break;

                    case "Moodle":
                        Uri moodle_uri = Uri.parse("https://moodle.cs.colorado.edu/");
                        Intent moodle_intent = new Intent(Intent.ACTION_VIEW, moodle_uri);
                        startActivity(moodle_intent);
                        break;

                    case "MyCUInfo":
                        Uri mycuinfo_uri = Uri.parse("https://fedauth.colorado.edu/idp/profile/SAML2/POST/SSO?execution=e1s1");
                        Intent mycuinfo_intent = new Intent(Intent.ACTION_VIEW, mycuinfo_uri);
                        startActivity(mycuinfo_intent);
                        break;

                    case "Parking Information":
                        Uri parking_uri = Uri.parse("http://www.colorado.edu/pts/parking-services");
                        Intent parking_intent = new Intent(Intent.ACTION_VIEW, parking_uri);
                        startActivity(parking_intent);
                        break;
                }
            }
        };

        ListView listview = (ListView) findViewById(R.id.menuOptions);
        listview.setOnItemClickListener(itemClickListener);

    }
}
