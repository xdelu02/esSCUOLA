import java.io.*;
import java.net.*;

public class Client {
    String clientName = "#";
    String serverName = "[Nome Server]";
    int serverPort = -1;
    Socket mySocket;
    BufferedReader keyboard;
    ClientRead threadRead;
    ClientWrite threadWrite;
    
    //Costruttore
    public Client(String serverName, int serverPort) {
        this.serverName = serverName;
        this.serverPort = serverPort;
    }
    
    //metodi
    public Socket connetti() {
        try {
            mySocket = new Socket(serverName, serverPort);

            DataOutputStream outToServer = new DataOutputStream(this.mySocket.getOutputStream());
            BufferedReader inFromServer = new BufferedReader(new InputStreamReader(this.mySocket.getInputStream()));
            keyboard = new BufferedReader(new InputStreamReader(System.in));

            String str;

            do {
                str = inFromServer.readLine();

                if (str.equals("Server| Insert Username")) {
                    System.out.println(str);

                    clientName = keyboard.readLine();
                    outToServer.writeBytes(clientName + '\n');

                    str = inFromServer.readLine();
                    System.out.println(str);

                    str = inFromServer.readLine();
                    if(str.substring(0, str.indexOf(":") + 1).equals("Server| User:")) {
                        System.out.println(str);

                        threadRead = new ClientRead(this);
                        threadWrite = new ClientWrite(this);
                    }
                }
                if (str.equals("Server| User taken")) {
                    System.out.println(str);
                }

            } while (str.equals("Server| User taken"));

            threadRead.start();
            threadWrite.start();
        }
        catch (Exception e) {
            System.out.println(e);
        }
        return mySocket;
    }
    public void println(String string) {
        System.out.println(string);
    }

    //Main
    public static void main(String[] args) {
        Client client = new Client("127.0.0.1", 9876);
        client.connetti();
    }
}
