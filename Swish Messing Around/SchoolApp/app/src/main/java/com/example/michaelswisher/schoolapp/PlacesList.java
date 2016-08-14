package com.example.michaelswisher.schoolapp;

import android.app.ProgressDialog;
import android.content.Intent;
import android.net.Uri;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.SearchView;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.google.common.base.Charsets;
import com.google.common.io.ByteStreams;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

public class PlacesList extends AppCompatActivity {

    ListView listview;
    SearchView searchview;
    List<String> placesList = new ArrayList<String>();
    ArrayAdapter<String> adapter;

    HashMap placesContainer = new HashMap();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_places_list);

        listview = (ListView) findViewById(R.id.placesList);
        searchview = (SearchView) findViewById(R.id.placesSearch);
        adapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, placesList);
        listview.setAdapter(adapter);

        new URLDataDownloadPlaces().execute("http://swishertest.site/");
//        System.out.println(result);
    }

    public class URLDataDownloadPlaces extends URLDataDownload {

        public URLDataDownloadPlaces() {
            progressDialog = new ProgressDialog(PlacesList.this);
        }

        /**
         * onPostExecute shows website data
         */
        protected void onPostExecute(Void v) {
            progressDialog.dismiss();
            /*
            System.out.println(result);
            try {

                JSONObject resultObject = new JSONObject(result);
                JSONArray placesArray = resultObject.getJSONArray("places");
                for (int i = 0; i < placesArray.length(); i++) {
                    JSONObject place = placesArray.getJSONObject(i);
                    System.out.println(place);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
            */
        }
    }

    @Override protected void onResume(){
        super.onResume();
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

                /* Using the local maps activity */
//                Intent intent = new Intent(PlacesList.this, MapsActivity.class);
//                intent.putExtra("LocationName", value);
//                intent.putExtra("LocationLat", valueSet.get(0));
//                intent.putExtra("LocationLong", valueSet.get(1));
//                startActivity(intent);

                /* Using google maps app externally */

                String mapsQuery = String.format("geo:0,0?q=%s,%s (%s)", valueSet.get(0), valueSet.get(1), value);
                Uri gmmIntentUri = Uri.parse(mapsQuery);
                Intent mapIntent = new Intent(Intent.ACTION_VIEW, gmmIntentUri);
                mapIntent.setPackage("com.google.android.apps.maps");
                startActivity(mapIntent);
            }
        });
    }

}
