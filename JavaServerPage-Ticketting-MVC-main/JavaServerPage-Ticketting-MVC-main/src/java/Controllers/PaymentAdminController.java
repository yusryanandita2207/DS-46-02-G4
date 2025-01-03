package Controllers;

import DAO.PaymentDAO;
import DAO.PaymentDAOImpl;
import Models.Payment;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PaymentAdminController", urlPatterns = {"/paymentAdmin"})
public class PaymentAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("tiketting?menu=admin");
            return;
        }

        Payment paymentModel = new Payment();

        if ("view".equals(menu)) {
            List<Payment> payments = new ArrayList<>();
            try {
                payments = paymentModel.get();
                request.setAttribute("payments", payments);
                request.getRequestDispatcher("/paymentAdmin.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("error", "Failed to fetch payments: " + e.getMessage());
                request.getRequestDispatcher("/paymentAdmin.jsp").forward(request, response);
            }
        } else if ("edit".equals(menu)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    PaymentDAO paymentDAO = new PaymentDAOImpl();
                    Payment payment = paymentDAO.find(id);
                    if (payment != null) {
                        request.setAttribute("payment", payment);
                        request.getRequestDispatcher("/editPayment.jsp").forward(request, response);
                        return;
                    } else {
                        request.setAttribute("error", "Payment not found.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error fetching payment: " + e.getMessage());
                }
            } else {
                request.setAttribute("error", "Invalid payment ID.");
            }
            response.sendRedirect("paymentAdmin?menu=view");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                PaymentDAO paymentDAO = new PaymentDAOImpl();

                String id = request.getParameter("id");
                String bookingId = request.getParameter("bookingId");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String paymentMethod = request.getParameter("paymentMethod");
                String paymentStatus = request.getParameter("paymentStatus");

                // Validasi input
                if (id == null || id.isEmpty()) {
                    throw new Exception("Payment ID is required for editing.");
                }

                Payment payment = paymentDAO.find(id);
                if (payment != null) {
                    payment.setBookingId(bookingId);
                    payment.setAmount(amount);
                    payment.setPaymentMethod(paymentMethod);
                    payment.setPaymentStatus(paymentStatus);

                    paymentDAO.update(payment);
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Payment updated successfully!");
                    response.sendRedirect("paymentAdmin?menu=view");
                    return;
                }

            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                PaymentDAO paymentDAO = new PaymentDAOImpl();
                paymentDAO.delete(id);
                request.getSession().setAttribute("message", "Payment deleted successfully!");
                
            } else if ("approve".equals(action)) {
                String id = request.getParameter("id");
                PaymentDAO paymentDAO = new PaymentDAOImpl();
                Payment payment = paymentDAO.find(id);
                if (payment != null) {
                    payment.setPaymentStatus("SUCCESS");
                    paymentDAO.update(payment);
                    request.getSession().setAttribute("message", "Payment approved successfully!");
                }
                
            } else if ("reject".equals(action)) {
                String id = request.getParameter("id");
                PaymentDAO paymentDAO = new PaymentDAOImpl();
                Payment payment = paymentDAO.find(id);
                if (payment != null) {
                    payment.setPaymentStatus("FAILED");
                    paymentDAO.update(payment);
                    request.getSession().setAttribute("message", "Payment rejected successfully!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to process payment: " + e.getMessage());
            request.getRequestDispatcher("/paymentAdmin.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("paymentAdmin?menu=view");
    }

    @Override
    public String getServletInfo() {
        return "Controller for managing payments";
    }
}