package universityofcoloradoboulder.cuapp;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;

public class MapListActivity extends AppCompatActivity {
    AutoCompleteTextView actv;

    String[] countries ={
            "Libby","Center for Community","Fleming"
    };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_map_list);
        actv = (AutoCompleteTextView) findViewById(R.id.autocomplete);
        actv.setAdapter(new ArrayAdapter<String>(this,R.layout.map_list_detail,countries));
//        showAll();

    }

    String savedText;

    public void showAll() {
        savedText = actv.getText().toString();
        actv.setText("");
        actv.showDropDown();
    }

    public void restore() {
        actv.setText(savedText);
    }
}
