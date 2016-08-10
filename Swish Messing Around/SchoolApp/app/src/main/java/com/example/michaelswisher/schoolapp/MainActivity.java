package com.example.michaelswisher.schoolapp;

import android.content.Intent;
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
                        Intent intent = new Intent(MainActivity.this, PlacesList.class);
                        startActivity(intent);

                }
            }
        };

        ListView listview = (ListView) findViewById(R.id.menuOptions);
        listview.setOnItemClickListener(itemClickListener);

    }
}
