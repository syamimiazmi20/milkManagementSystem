package Milk.model;

public class pickup extends shippingMethod {
    private String pickup_date;
    private String pickup_session;
    //private String farm_address;
    //private String office_phone_num;

    public pickup() {
    }

    public String getPickup_date() {
        return pickup_date;
    }

    public void setPickup_date(String pickup_date) {
        this.pickup_date = pickup_date;
    }

    public String getPickup_session() {
        return pickup_session;
    }

    public void setPickup_session(String pickup_session) {
        this.pickup_session = pickup_session;
    }

    //public String getFarm_address() {
    //    return farm_address;
    //}

    //public void setFarm_address(String farm_address) {
    //    this.farm_address = farm_address;
    //}

    //public String getOffice_phone_num() {
    //   return office_phone_num;
    //}

    //public void setOffice_phone_num(String office_phone_num) {
    //    this.office_phone_num = office_phone_num;
    //}
}
