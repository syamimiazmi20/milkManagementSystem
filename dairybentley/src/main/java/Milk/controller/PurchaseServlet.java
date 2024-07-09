package Milk.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


import Milk.dao.AddPaymentDAO;
import Milk.dao.AddShippingDAO;
import Milk.dao.MilkProductionDAO;
import Milk.dao.MilkPurchaseDAO;
import Milk.model.MilkProduction;
import Milk.model.MilkPurchase;
import Milk.model.payment;
import Milk.connection.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class PurchaseServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ConnectionManager connectionManager;
    private MilkProductionDAO milkProductionDAO;
    private AddShippingDAO shippingDAO;
    private AddPaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        // Initialize DAOs
        milkProductionDAO = new MilkProductionDAO();
        shippingDAO = new AddShippingDAO();
        paymentDAO = new AddPaymentDAO();
    }

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = connectionManager.getConnection()) {
            if ("addPayment".equals(action)) {
//            	int amountPurchase = Integer.parseInt(request.getParameter("amountPurchase"));
                handleAddPayment(request, response, conn);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try (Connection conn = connectionManager.getConnection()) {
            if (action != null) {
                switch (action) {
                    case "view":
                        viewPurchase(request, response, conn);
                        break;
                    case "edit":
                        editPurchase(request, response, conn);
                        break;
                    default:
                        listPurchases(request, response, conn);
                }
            } else {
                listPurchases(request, response, conn);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void viewPurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException, SQLException {
        int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
        MilkPurchase purchase = purchaseDAO.getMilkPurchaseById(purchaseId);
        
        request.setAttribute("purchase", purchase);
        request.getRequestDispatcher("ViewEditPurchase.jsp").forward(request, response);
    }

    private void editPurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException, SQLException {
        int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
        MilkPurchase purchase = purchaseDAO.getMilkPurchaseById(purchaseId);
        
        request.setAttribute("purchase", purchase);
        request.getRequestDispatcher("milk_purchase.jsp").forward(request, response);
    }

    private void listPurchases(HttpServletRequest request, HttpServletResponse response, Connection conn) throws ServletException, IOException, SQLException {
        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
        List<MilkPurchase> purchases = purchaseDAO.getAllMilkPurchases();
        
        request.setAttribute("purchases", purchases);
        request.getRequestDispatcher("purchase_list.jsp").forward(request, response);
    }

//    private void handleAddPurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws SQLException, IOException {
//        int cust_id = Integer.parseInt(request.getParameter("cust_id"));
//        double amount_liter = Double.parseDouble(request.getParameter("amount_liter"));
//        double total_price = amount_liter * 2.5; // Assume fixed price per liter
//
//        MilkPurchase purchase = new MilkPurchase();
//        purchase.setCustID(cust_id);
//        purchase.setAmountLiter(amount_liter);
//        purchase.setTotalPrice(total_price);
//
//        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
//        purchaseDAO.addMilkPurchase(purchase);
//
//        response.sendRedirect("CustShippingMethod.jsp");
//    }
//
//    private void handleDeletePurchase(HttpServletRequest request, HttpServletResponse response, Connection conn) throws SQLException, IOException {
//        int purchase_id = Integer.parseInt(request.getParameter("purchase_id"));
//
//        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
//        purchaseDAO.deleteMilkPurchase(purchase_id);
//
//        response.sendRedirect("CustShippingMethod.jsp");
//    }
//
//    private void handleAddShipping(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
//        HttpSession session = request.getSession();
//        int cust_id = (int) session.getAttribute("userID");
//        String con_phone = request.getParameter("con_phone");
//        String shipping_type = request.getParameter("shipping_type");
//
//        int shipping_id = shippingDAO.addShippingMethod(cust_id, con_phone, shipping_type);
//
//        if ("delivery".equals(shipping_type)) {
//            String receiver_name = request.getParameter("receiver_name");
//            String send_address = request.getParameter("send_address");
//
//            shippingDAO.addDelivery(shipping_id, receiver_name, send_address);
//
//        } else if ("pickup".equals(shipping_type)) {
//            String pickup_date = request.getParameter("pickup_date");
//            String pickup_session = request.getParameter("pickup_session");
//
//            shippingDAO.addPickup(shipping_id, pickup_date, pickup_session);
//        }
//
//        double totalPrice = calculateTotalPrice();
//
//        response.sendRedirect("CustPayment.jsp?shipping_id=" + shipping_id + "&total_price=" + totalPrice);
//    }

    private void handleAddPayment(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
    	//shipping

    	int cust_id = Integer.parseInt(request.getParameter("cust_id"));
    	String con_phone = request.getParameter("con_phone");
    	String shipping_type = request.getParameter("shipping_type");
    	int shipping_id = shippingDAO.addShippingMethod(cust_id, con_phone, shipping_type);
    	if ("delivery".equals(shipping_type)) {
            String receiver_name = request.getParameter("receiver_name");
            String send_address = request.getParameter("send_address");

            shippingDAO.addDelivery(shipping_id, receiver_name, send_address);

        } else if ("pickup".equals(shipping_type)) {
            String pickup_date = request.getParameter("pickup_date");
            String pickup_session = request.getParameter("pickup_session");

            shippingDAO.addPickup(shipping_id,pickup_date, pickup_session);
        }
    	
    	//payment
    	Double totalPrice = 0.0;
    	try {
            String paymentDateStr = request.getParameter("payment_date");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date paymentDate = dateFormat.parse(paymentDateStr);

            String paymentType = request.getParameter("payment_type");

            totalPrice = Double.parseDouble( request.getParameter("totalPrice"));

            payment newPayment = new payment();
            newPayment.setPayment_date(paymentDate);
            newPayment.setPayment_type(paymentType);

            paymentDAO.addPayment(newPayment);
            
//            MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
//            int paymentid = purchaseDAO.getLatestPayment();

            
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payment date format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the payment");
        }
    	
    	//milkpurchase
        double amountPurchase = Double.parseDouble(request.getParameter("amountPurchase"));
        
        int prod_id = Integer.parseInt(request.getParameter("production_id"));
//        int purchase_id= Integer.parseInt(request.getParameter("purchase_id"));
//        
//        double mp = MilkProduction.getAmountBalance();
//        double amount = mp - amountPurchase;
//

        MilkProductionDAO milkProductionDAO2 = new MilkProductionDAO();
        MilkProduction milkProduction = new MilkProduction();
        
        double oldAmtBal = MilkProductionDAO.getLatestMilkProductionAmtBal();
        double newAmtBal = oldAmtBal - amountPurchase;
        int prodID = MilkProductionDAO.getLatestMilkProductionProdId();
        
		milkProductionDAO2.updateMilkProductionAmtBal(newAmtBal, prodID);
		milkProduction.setAmountBalance(newAmtBal); 
		
        
        MilkPurchase purchase = new MilkPurchase();
        purchase.setProductionId(prod_id);
        purchase.setCustID(cust_id);
        purchase.setAmountLiter(amountPurchase);
        purchase.setTotalPrice(totalPrice);
//        purchase.setPurchaseID(purchase_id);
        purchase.setShipping_id(shipping_id);
        
        MilkPurchaseDAO purchaseDAO = new MilkPurchaseDAO(conn);
        purchaseDAO.addMilkPurchase(purchase);
        

//        int shipping_id = shippingDAO.addShippingMethod(cust_id, con_phone, shipping_type);

        response.sendRedirect("success.html");

//        double totalPrice = calculateTotalPrice();
        
        
    }

    private double calculateTotalPrice() {
        double milkQuantity = 5;
        double pricePerUnit = 3.0;
        return milkQuantity * pricePerUnit;
    }
}