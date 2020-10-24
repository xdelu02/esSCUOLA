import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ServerThread extends Thread {
    Server server;
    UserData user;
    String stringFromUser;
    BufferedReader inFromClient;
    DataOutputStream outToClient;
    
    
    //Costruttore
    public ServerThread(Server server, UserData user) {
        this.server = server;
        this.user = user;
    }
    
    //Metodi
    public void run() {
        try {
            exe();
        }
        catch (Exception e) {
            e.printStackTrace(System.out);
        }
    }
    public void exe() {
        try {
            inFromClient = new BufferedReader(new InputStreamReader(user.getUserSocket().getInputStream()));
        } catch (IOException ex) {
            System.out.println(ex);
        }
        
        for(;;) {
            try {
                stringFromUser = inFromClient.readLine();

                String reciver = UserArray.searchUser(stringFromUser);

                if(!UserArray.isRegistered(reciver)) {
                    outToClient = new DataOutputStream(user.getUserSocket().getOutputStream());

                    outToClient.writeBytes("Server| User " + reciver + " doesn't exist\n");
                }
                if(!reciver.equals(user.getUsername())) {
                    Socket reciverSocket = UserArray.getUserSocket(reciver);
                    outToClient = new DataOutputStream(reciverSocket.getOutputStream());

                    stringFromUser = user.getUsername() + "|" + stringFromUser.substring(stringFromUser.indexOf("|") + 1);

                    outToClient.writeBytes(stringFromUser + '\n');
                }
                else {
                    outToClient = new DataOutputStream(user.getUserSocket().getOutputStream());

                    outToClient.writeBytes("Server| Self Writing is not allowed!\n");
                }

                close();

            } catch (IOException e) {
                System.out.println(e);
            }
        }
    }
    public void close() {
        String str = stringFromUser.substring(stringFromUser.indexOf('|') + 1);

        if(str.equals(" EXIT")) {
            if(UserArray.remove(user.getUsername())) {
                try {
                    outToClient = new DataOutputStream(user.getUserSocket().getOutputStream());

                    outToClient.writeBytes("Server| Exit successful!\n");
                } catch (IOException e) {
                    System.out.println(e);
                }
            }

            this.interrupt();
        }
    }
}
