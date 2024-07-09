package Milk.model;

public class MilkProduction {
    private int production_id;
    private java.sql.Date production_date;
    private String production_time;
    private double amount;
    private double total_production;
    private double amount_balance;
    private int emp_id;

    // Getters and setters
    public int getProductionId() { return production_id; }
    public void setProductionId(int production_id) { this.production_id = production_id; }

    public java.sql.Date getProductionDate() { return production_date; }
    public void setProductionDate(java.sql.Date production_date) { this.production_date = production_date; }

    public String getProductionTime() { return production_time; }
    public void setProductionTime(String production_time) { this.production_time = production_time; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public double getTotalProduction() { return total_production; }
    public void setTotalProduction(double total_production) { this.total_production = total_production; }

    public double getAmountBalance() { return amount_balance; }
    public void setAmountBalance(double amount_balance) { this.amount_balance = amount_balance; }

    public int getEmpId() { return emp_id; }
    public void setEmpId(int emp_id) { this.emp_id = emp_id; } 
}
