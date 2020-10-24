import java.io.*;
import java.net.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClientRead extends Thread {
    Client client;
    String stringFromServer;
    BufferedReader inFromServer;
    
    //Costruttore
    public ClientRead(Client client) {
        this.client = client;
    }
    
    //metodi
    public void run() {
        try {
            inFromServer = new BufferedReader(new InputStreamReader(client.mySocket.getInputStream()));
        } catch (IOException ex) {
            System.out.println("Error: IOInstrauration");
        }

        for(;;) {
            try {
                stringFromServer = inFromServer.readLine();
                client.println(stringFromServer);
            } catch (IOException ex) {
                System.out.println("Error: Ricezione del messaggio");
            }
        }
    }
}
