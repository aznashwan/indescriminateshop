package com.example.nashwan.msa;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;

public class LoggedInActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logged_in);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }

}
