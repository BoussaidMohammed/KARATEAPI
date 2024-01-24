package utilities;

import java.io.FileWriter;
import java.io.IOException;

public class Writer {
    public static void write(String filename, String text) {
        try {
            FileWriter writer = new FileWriter("src/test/java/" + filename);
            writer.write(text);
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
