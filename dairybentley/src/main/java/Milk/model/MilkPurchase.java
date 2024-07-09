package Milk.model;

public class MilkPurchase {

    private int purchase_id;
    private int prod_id;
    private int cust_id;
    private double amount_liter;
    private double total_price;
    private int payment_id;
    private int shipping_id;

    // Default constructor
    public MilkPurchase() {
    }

    // Parameterized constructor
    public MilkPurchase(int purchase_id, int cust_id, double amount_liter, double total_price) {
        this.purchase_id = purchase_id;
        this.cust_id = cust_id;
        this.amount_liter = amount_liter;
        this.total_price = total_price;
    }

    // Getters and setters
    public int getPurchaseID() {
        return purchase_id;
    }

    public void setPurchaseID(int purchase_id) {
        this.purchase_id = purchase_id;
    }

    public int getCustID() {
        return cust_id;
    }

    public void setCustID(int cust_id) {
        this.cust_id = cust_id;
    }

    public double getAmountLiter() {
        return amount_liter;
    }

    public void setAmountLiter(double amount_liter) {
        this.amount_liter = amount_liter;
    }

    public double getTotalPrice() {
        return total_price;
    }

    public void setTotalPrice(double total_price) {
        this.total_price = total_price;
    }

	public void setProductionId(int prod_id) {
		// TODO Auto-generated method stub
		this.prod_id = prod_id;
	}
	public int getProductionId() {
		// TODO Auto-generated method stub
		return prod_id;
	}
	
	public void setPaymentId(int payment_id) {
		
		this.payment_id = payment_id;
	}
	
	public int getPaymentId() {
		
		return payment_id;
	}
	
	public int getShipping_id() {
		return shipping_id;
	}

	public void setShipping_id(int shipping_id) {
		this.shipping_id = shipping_id;
	}
}