package com.example.nashwan.msa;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class LoginActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        final EditText username = (EditText) findViewById(R.id.usernameField);
        final EditText password = (EditText) findViewById(R.id.passwordField);

        Button button = (Button) findViewById(R.id.loginButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // check pass:
                int lu = username.getText().length();
                if(lu == 0) {
                    Toast.makeText(getApplicationContext(), "Please fill in the username!", Toast.LENGTH_SHORT).show();
                    return;
                }

                int lp = password.getText().length();
                if(lp == 0) {
                    Toast.makeText(getApplicationContext(), "Please fill in a password!", Toast.LENGTH_SHORT).show();
                    return;
                }

                String user = username.getText().toString();
                String pass = password.getText().toString();

                if(user.contains(pass) || pass.contains(user)) {
                    Toast.makeText(getApplicationContext(), "Username and password too similar!", Toast.LENGTH_SHORT).show();
                    return;
                }

                Intent intent = new Intent(getApplicationContext(), LoggedInActivity.class);
                startActivity(intent);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_login, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
