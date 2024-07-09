package Milk.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Milk.dao.AddPaymentDAO;
import Milk.model.payment;


public class AddPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AddPaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new AddPaymentDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Payment Servlet called.");
        
        try {
            // Retrieve and parse payment date
            String paymentDateStr = request.getParameter("payment_date");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = dateFormat.parse(paymentDateStr);

            // Retrieve payment type from the form
            String paymentType = request.getParameter("payment_type");
            String shippingId = request.getParameter("shipping_id");
            String totalPrice = request.getParameter("total_price");

            System.out.println("Received parameters: paymentDate=" + paymentDate + ", paymentType=" + paymentType + ", shippingId=" + shippingId + ", totalPrice=" + totalPrice);
         // Create a new payment object and set its attributes
            payment newPayment = new payment();
            newPayment.setPayment_date(paymentDate);
            newPayment.setPayment_type(paymentType);

            // Use AddPaymentDAO to save the payment
            paymentDAO.addPayment(newPayment);

            // Redirect to a success page or display a success message
            response.sendRedirect("success.html");
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payment date format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the payment");
        }
    }
}
