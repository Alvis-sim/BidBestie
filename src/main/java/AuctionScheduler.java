import java.util.Timer;
import java.util.TimerTask;
import java.util.Date;

public class AuctionScheduler {

    public static void scheduleAuctionFinalization(int productID, Date endTime) {
        Timer timer = new Timer();
        TimerTask finalizeTask = new TimerTask() {
            @Override
            public void run() {
                AuctionEndpoint auctionEndpoint = new AuctionEndpoint();
                auctionEndpoint.finalizeAuction(productID);
                timer.cancel(); // Terminate the timer
            }
        };
        
        timer.schedule(finalizeTask, endTime);
        System.out.println("Auction finalization scheduled for product " + productID + " at " + endTime);
    }
}
