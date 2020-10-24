import java.net.*;

public class UserData {
    private String username;
    private Socket userSocket;
    
    //get
    public String getUsername() {
        return username;
    }
    public Socket getUserSocket() {
        return userSocket;
    }
    
    //Costruttore
    public UserData(String username, Socket userSocket) {
        this.username = username;
        this.userSocket = userSocket;
    }
}
