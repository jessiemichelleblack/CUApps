package com.example.michaelswisher.schoolapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.SearchView;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class PlacesList extends AppCompatActivity {

    ListView listview;
    SearchView searchview;
    List<String> placesList = new ArrayList<String>();
    ArrayAdapter<String> adapter;
    FirebaseDatabase database = FirebaseDatabase.getInstance();
    final DatabaseReference myRef = database.getReference("places");

    HashMap placesContainer = new HashMap();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_places_list);

        listview = (ListView) findViewById(R.id.placesList);
        searchview = (SearchView) findViewById(R.id.placesSearch);
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, placesList);
        listview.setAdapter(adapter);
    }

    @Override protected void onResume(){
        super.onResume();
        myRef.addListenerForSingleValueEvent(new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {
                        for (DataSnapshot messageSnapshot: dataSnapshot.getChildren()) {
                            String placeName = messageSnapshot.getKey();
                            placesList.add(placeName);
                            ArrayList<String> placeValues = (ArrayList<String>) messageSnapshot.getValue();
                            placesContainer.put(placeName, placeValues);
                        }
                        adapter.notifyDataSetChanged();
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {
                        //Log.w(TAG, "getUser:onCancelled", databaseError.toException());
                    }
        });


        searchview.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                adapter.getFilter().filter(newText);
                return false;
            }
        });

        listview.setOnItemClickListener(new AdapterView.OnItemClickListener()
        {
            @Override
            public void onItemClick(AdapterView<?> adapter, View v, int position, long arg3)
            {
                String value = (String)adapter.getItemAtPosition(position);
                ArrayList<String> valueSet = (ArrayList<String>) placesContainer.get(value);
                System.out.println(valueSet.get(0));
            }
        });
    }
}
