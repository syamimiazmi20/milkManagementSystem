package Milk.controller;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Milk.dao.AddShippingDAO;

public class AddShippingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddShippingDAO shippingDAO;

    @Override
    public void init() throws ServletException {
        shippingDAO = new AddShippingDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Servlet called.");
        HttpSession session = request.getSession();
        int cust_id = (int)session.getAttribute("userID");
        //int cust_id = Integer.parseInt(request.getParameter("cust_id"));
        //int cust_id = 10; // Retrieve the customer ID as needed
        String con_phone = request.getParameter("con_phone");
        String shipping_type = request.getParameter("shipping_type");

        System.out.println("Received parameters: custId=" + cust_id + ", contactPhoneNum=" + con_phone + ", shippingType=" + shipping_type);

        try {
            // Start transaction
            int shipping_id = shippingDAO.addShippingMethod(cust_id, con_phone, shipping_type);

            // Insert data into delivery or pickup table based on shipping type
            if ("delivery".equals(shipping_type)) {
                String receiver_name = request.getParameter("receiver_name");
                String send_address = request.getParameter("send_address");
                System.out.println("Delivery parameters: shippingId=" + shipping_id + ", receiverName=" + receiver_name + ", sendAddress=" + send_address);

                shippingDAO.addDelivery(shipping_id, receiver_name, send_address);

            } else if ("pickup".equals(shipping_type)) {
                String pickup_date = request.getParameter("pickup_date");
                String pickup_session = request.getParameter("pickup_session");
                System.out.println("Pickup parameters: shippingId=" + shipping_id + ", pickupDate=" + pickup_date + ", pickupSession=" + pickup_session);

                shippingDAO.addPickup(shipping_id, pickup_date, pickup_session);
            }

            // Calculate total price (for example purposes)
            double totalPrice = calculateTotalPrice();

            // Redirect to payment page with necessary data
            response.sendRedirect("CustPayment.jsp?shipping_id=" + shipping_id + "&total_price=" + totalPrice);
        } catch (SQLException | NumberFormatException e) {
            // Handle errors
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }

    private double calculateTotalPrice() {
        // Example calculation
        double milkQuantity = 5;
        double pricePerUnit = 2.5;
        return milkQuantity * pricePerUnit;
    }
}