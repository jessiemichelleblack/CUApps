package com.example.michaelswisher.schoolapp;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.webkit.WebView;

public class WebPortal extends AppCompatActivity {

    String urlString;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        Intent intent = getIntent();
        urlString = intent.getExtras().getString("webportal");


        System.out.println("wtf:" + urlString);
        WebView webview = new WebView(this);
        WebView browser = (WebView) findViewById(R.id.webView);
        setContentView(browser);
        browser.loadUrl(urlString);
    }
}
