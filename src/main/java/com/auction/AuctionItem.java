package com.auction;

public class AuctionItem {
    private int productID;
    private String productName;
    private double buyNowPrice;
    private double startingBidPrice; // Changed type to double
    private String productDescription;
    private double currentBid;
    private String eDate;
    private String base64Image;

    public AuctionItem() {
        // Default constructor
    }

    public AuctionItem(int productID, String productName, double buyNowPrice, double startingBidPrice, String productDescription, double currentBid, String eDate, String base64Image) {
        this.productID = productID;
        this.productName = productName;
        this.buyNowPrice = buyNowPrice;
        this.startingBidPrice = startingBidPrice;
        this.productDescription = productDescription;
        this.currentBid = currentBid;
        this.eDate = eDate;
        this.base64Image = base64Image;
    }

    // Getters and Setters
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getBuyNowPrice() {
        return buyNowPrice;
    }

    public void setBuyNowPrice(double buyNowPrice) {
        this.buyNowPrice = buyNowPrice;
    }

    public double getStartingBidPrice() {
        return startingBidPrice;
    }

    public void setStartingBidPrice(double startingBidPrice) {
        this.startingBidPrice = startingBidPrice;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public double getCurrentBid() {
        return currentBid;
    }

    public void setCurrentBid(double currentBid) {
        this.currentBid = currentBid;
    }

    public String getEDate() {
        return eDate;
    }

    public void setEDate(String eDate) {
        this.eDate = eDate;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
}
