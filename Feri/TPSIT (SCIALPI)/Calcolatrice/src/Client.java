import java.io.*;
import java.net.*;

public class Client {
    private String serverName = "[SERVER NAME]";
    private int serverPort = -1;
    private Socket mySocket;
    private BufferedReader keyboard;
    private String userString;
    private String stringFormServer;
    private DataOutputStream outToServer;
    private BufferedReader inFromServer;

    //costruttore
    public Client(String serverName, int serverPort) {
        this.serverName = serverName;
        this.serverPort = serverPort;
    }

    //metodi
    public Socket connetti() {
        System.out.println("CLIENT in esecuzione ...");
        try {
            keyboard = new BufferedReader(new InputStreamReader(System.in));
            mySocket = new Socket(serverName, serverPort);
            outToServer = new DataOutputStream(mySocket.getOutputStream());
            inFromServer = new BufferedReader(new InputStreamReader(mySocket.getInputStream()));
        }
        catch (UnknownHostException e) {
            System.out.println("Host sconosciuto");
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            System.out.println("Errore durante la connessione!");
            System.exit(1);
        }

        return mySocket;
    }
    public void comunica() {
        for (;;) {
            try {
                System.out.println("Inserisci l'operzione da eseguire:");
                userString = keyboard.readLine();

                outToServer.writeBytes(userString + '\n');

                stringFormServer = inFromServer.readLine();
                System.out.println("Risposta:\n" + stringFormServer);

                if (userString.equals("FINE")) {
                    System.out.println("Connessione chiusa!");
                    mySocket.close();
                    break;
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
                System.out.println("Errore durante a comuniczione col server!");
                System.exit(1);
            }
        }
    }

    //main
    public static void main(String[] args) {
        Client client = new Client("127.0.0.1", 6555);
        client.connetti();
        client.comunica();
    }
}