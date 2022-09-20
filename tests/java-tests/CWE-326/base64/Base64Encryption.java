
import java.util.Base64;

public class Base64Encryption {
    public void password() {
        // Example with password
        String password = request.getParameter("password");
        String encryptedPassword = Base64.getEncoder().encode(password);
    }

    public void card() {
        // Example of cardnumber
        String cardnumber = request.getParameter("cardnumber");
        String cvv = request.getParameter("cvv");
        String encryptCardNumber = Base64.getEncoder().encode(cardnumber + ":" + cvv);

    }
}
