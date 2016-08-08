package com.example.michaelswisher.schoolapp;

import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.SearchView;
import android.util.Log;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.firebase.client.Firebase;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

public class PlacesList extends AppCompatActivity {

    ListView listview;
    SearchView searchview;

    //private DatabaseReference mDatabase;

    String[] places = {""};
    public List<String> placesList = new ArrayList<String>();

    ArrayAdapter<String> adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_places_list);

        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference myRef = database.getReference("places");
        System.out.println(myRef);
        // Read from the database
        myRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot messageSnapshot: dataSnapshot.getChildren()) {
                    String placeName = messageSnapshot.getKey();
                    System.out.println(placeName + " : " + messageSnapshot.getValue());
                }
            }

            @Override
            public void onCancelled(DatabaseError error) {
                // Failed to read value
                //Log.w(TAG, "Failed to read value.", error.toException());
            }
        });

        listview= (ListView) findViewById(R.id.placesList);
        searchview = (SearchView) findViewById(R.id.placesSearch);
        adapter = new ArrayAdapter<String>(this, android.R.layout.simple_expandable_list_item_1, places);
        listview.setAdapter(adapter);

        searchview.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                System.out.println("Array size: " + places.length);
                System.out.println("List size: " + placesList.size());
                adapter.getFilter().filter(newText);

                return false;
            }
        });
    }

//    @Override
//    protected void onStart() {
//        super.onStart();
//        setContentView(R.layout.activity_places_list);
//        System.out.println("wtf " + placesList.size());
//    }
}
