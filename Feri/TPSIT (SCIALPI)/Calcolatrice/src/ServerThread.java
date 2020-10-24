import java.io.*;
import java.net.*;

class ServerThread extends Thread {
    Socket client;
    String stringFromUser = null;
    String stringReworked = null;
    BufferedReader inFromClient;
    DataOutputStream outToClient;

    //costruttore
    public ServerThread(Socket socket) {
        this.client = socket;
    }

    //metodi
    public void run() {
        try {
            comunica();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        }
    }
    public void comunica() throws Exception {
        inFromClient = new BufferedReader(new InputStreamReader(client.getInputStream()));
        outToClient = new DataOutputStream(client.getOutputStream());

        for (; ; ) {
            stringFromUser = inFromClient.readLine();

            if (stringFromUser == null || stringFromUser.equals("FINE")) {
                outToClient.writeBytes(stringFromUser + " (=>server in chiusura...)\n");
                break;
            } else {
                stringReworked = operation(stringFromUser.replace(" ", ""));
                outToClient.writeBytes(stringReworked + '\n');
            }
        }
        outToClient.close();
        inFromClient.close();
        System.out.println("Chiusura socket: " + client);
        client.close();
    }
    public String operation(String operation) {
        int result = 0;

        if (operation.indexOf("+") != -1) {
            int n1 = Integer.parseInt(operation.substring(0, operation.indexOf("+")));
            int n2 = Integer.parseInt(operation.substring(operation.indexOf("+") + 1));
            result = n1 + n2;
        }
        else if (operation.indexOf("-") != -1) {
            int n1 = Integer.parseInt(operation.substring(0, operation.indexOf("-")));
            int n2 = Integer.parseInt(operation.substring(operation.indexOf("-") + 1));
            result = n1 - n2;
        }
        else if (operation.indexOf("*") != -1) {
            int n1 = Integer.parseInt(operation.substring(0, operation.indexOf("*")));
            int n2 = Integer.parseInt(operation.substring(operation.indexOf("*") + 1));
            result = n1*n2;
        }
        else if (operation.indexOf("/") != -1) {
            int n1 = Integer.parseInt(operation.substring(0, operation.indexOf("/")));
            int n2 = Integer.parseInt(operation.substring(operation.indexOf("/") + 1));
            result = n1/n2;
        }

        return "" + result;
    }
}