package com.example.michaelswisher.schoolapp;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.AsyncTask;

import com.google.common.base.Charsets;
import com.google.common.io.ByteStreams;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by michael.swisher on 8/14/2016.
 */

public abstract class URLDataDownload extends AsyncTask<String, String, String> {

    protected ProgressDialog progressDialog = null;
    InputStream inputStream = null;
    String result = "";

    protected void onPreExecute() {
        progressDialog.setMessage("Getting adoption info...");
        progressDialog.show();
        progressDialog.setOnCancelListener(new DialogInterface.OnCancelListener() {
            @Override
            public void onCancel(DialogInterface arg0) {
                URLDataDownload.this.cancel(true);
            }
        });
    }



    /**
     * Opening connection to URL, reading data from URL,
     * convert inputStream to string, then closes inputStream
     */
    @Override
    protected String doInBackground(String... params) {

        try {
            URL url = new URL(params[0]);
            URLConnection urlConnection = url.openConnection();
            inputStream = new BufferedInputStream(urlConnection.getInputStream());
            result = new String(ByteStreams.toByteArray(inputStream), Charsets.UTF_8); //using Guava ByteStreams
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException ignored) {
            }
        }
        return null;
    }
}