package com.example.michaelswisher.schoolapp;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by michael.swisher on 8/16/2016.
 */
public class PlacesAdapter extends BaseAdapter {
    private final Context context;
    private final HashMap data;
    private ArrayList<String> placeNames;

    public PlacesAdapter(Context context, HashMap data) {
        //super(context, R.layout.places_row, data);
        this.context = context;
        this.data = data;
        placeNames.addAll(data.keySet());
    }

    @Override
    public int getCount() {
        // TODO Auto-generated method stub
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        // TODO Auto-generated method stub
        return placeNames.get(position);
    }

    @Override
    public long getItemId(int position) {
        // TODO Auto-generated method stub
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View rowView = inflater.inflate(R.layout.places_row, parent, false);
        rowView.setBackgroundColor(Color.WHITE);
        TextView textView = (TextView) rowView.findViewById(R.id.label);
        ImageView imageView = (ImageView) rowView.findViewById(R.id.icon);
        textView.setText((String)placeNames.get(position));

        // Change the icon for Windows and iPhone
        /*
        String s = values[position];
        if (s.startsWith("Windows7") || s.startsWith("iPhone")
                || s.startsWith("Solaris")) {
            imageView.setImageResource(R.drawable.no);
        } else {
            imageView.setImageResource(R.drawable.ok);
        }
        */

        return rowView;
    }
}
