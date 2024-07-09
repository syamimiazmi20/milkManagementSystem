package Milk.model;

public class delivery extends shippingMethod {
    private String receiver_name;
    //private String carrier_name;
    //private String carrier_phone_num;
    private String send_address;
   

    public delivery() {
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }

    //public String getCarrier_name() {
    //    return carrier_name;
    //}

    //public void setCarrier_name(String carrier_name) {
    //    this.carrier_name = carrier_name;
    //}

    //public String getCarrier_phone_num() {
    //    return carrier_phone_num;
    //}

    //public void setCarrier_phone_num(String carrier_phone_num) {
    //   this.carrier_phone_num = carrier_phone_num;
    //}

    public String getSend_address() {
        return send_address;
    }

    public void setSend_address(String send_address) {
        this.send_address = send_address;
    }
}
