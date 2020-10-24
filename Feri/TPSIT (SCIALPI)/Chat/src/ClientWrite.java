import java.io.*;
import java.net.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClientWrite extends Thread {
    Client client;
    BufferedReader keyboard;
    String userString;
    DataOutputStream outToServer;
    
    //Costruttore
    public ClientWrite(Client client) {
        this.client = client;
    }
    
    //metodi
    public void run() {
        try {
            outToServer = new DataOutputStream(client.mySocket.getOutputStream());
        } catch (IOException ex) {
            System.out.println("Error: IOInstrauration");
        }

        keyboard = client.keyboard;

        for(;;) {
            try {
                userString = keyboard.readLine();
                outToServer.writeBytes(userString + '\n');
            } catch (IOException ex) {
                System.out.println("Error: Read user message");
            }
        }
    }
}
