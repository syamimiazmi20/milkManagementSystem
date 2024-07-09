package Milk.model;

import java.util.Date; // Import the Date class

public class payment {
    private int payment_id;
    private Date payment_date; // Use java.util.Date for compatibility with Oracle DATE type
    private String payment_type;
    
    public int getPayment_id() {
        return payment_id;
    }
    public void setPayment_id(int payment_id) {
        this.payment_id = payment_id;
    }
    public Date getPayment_date() {
        return payment_date;
    }
    public void setPayment_date(Date payment_date) {
        this.payment_date = payment_date;
    }
    public String getPayment_type() {
        return payment_type;
    }
    public void setPayment_type(String payment_type) {
        this.payment_type = payment_type;
    }
}
