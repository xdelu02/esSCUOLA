import java.net.*;
import java.io.*;
import java.util.ArrayList;

public class Server {
    String serverName = "[Server Name]";
    int serverPort = -1;
    ArrayList<ServerThread> serverThreadArray;
    String stringFromUser;
    BufferedReader inFromClient;
    DataOutputStream outToClient1;
    DataOutputStream outToClient2;

    //Costruttore
    public Server(String serverName, int serverPort) {
        this.serverName = serverName;
        this.serverPort = serverPort;
        serverThreadArray = new ArrayList<>();
    }
    
    //Metodi
    public void power_up() {
        try {
            ServerSocket serverSocket = new ServerSocket(serverPort);

            System.out.println("Attesa client 1");
            Socket client = serverSocket.accept();
            System.out.println("Socket| " + client + " accepted");
            outToClient1 = new DataOutputStream(client.getOutputStream());
            inFromClient = new BufferedReader(new InputStreamReader(client.getInputStream()));

            outToClient1.writeBytes("Server| Insert Username\n");
            stringFromUser = inFromClient.readLine();

            String userName1 = stringFromUser;

            UserArray.insert(new UserData(userName1, client));
            System.out.println("User: " + userName1 + " Joined");

            serverThreadArray.add(new ServerThread(this, UserArray.get(0)));
            System.out.println("Server Thread 1 started!\n");

            outToClient1.writeBytes("Server| Waiting for a chat-mate\n");

            //User2
            System.out.println("Attesa client 2");
            client = serverSocket.accept();

            System.out.println("Socket| " + client + " accepted");
            outToClient2 = new DataOutputStream(client.getOutputStream());
            inFromClient = new BufferedReader(new InputStreamReader(client.getInputStream()));

            for(;;) {
                outToClient2.writeBytes("Server| Insert Username\n");
                stringFromUser = inFromClient.readLine();

                if(!userName1.equals(stringFromUser)) {
                    String userName2 = stringFromUser;
                    UserArray.insert(new UserData(userName2, client));
                    System.out.println("User: " + userName2 + " Joined");

                    serverThreadArray.add(new ServerThread(this, UserArray.get(1)));
                    System.out.println("Server Thread 2 started!");

                    outToClient2.writeBytes("Server| Chat-mate founded\n");

                    outToClient1.writeBytes("Server| User: " + userName2 + " - is ready to chat with you\n");
                    outToClient2.writeBytes("Server| User: " + userName1 + " - is ready to chat with you\n");
                    break;
                }
                else
                    outToClient2.writeBytes("Server| User taken\n");
            }

            for (ServerThread t: serverThreadArray) {
                t.start();
            }
        }
        catch (Exception e) {
            System.out.println(e);
        }
    }

    //Main
    public static void main(String[] args) {
        Server server = new Server("127.0.0.1", 9876);
        server.power_up();
    }
}
