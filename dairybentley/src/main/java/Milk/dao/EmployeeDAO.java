package Milk.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Milk.model.Employee;
import Milk.connection.ConnectionManager;

public class EmployeeDAO {
    private ConnectionManager connectionManager;

    public EmployeeDAO() {
        connectionManager = new ConnectionManager();
    }

    public boolean registerEmployee(String name, String email, String password, String address, String phone, String role) {
        boolean isSuccess = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "INSERT INTO EMPLOYEES (emp_name, emp_email, emp_password, emp_address, emp_phoneNum, emp_role) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, address);
            ps.setString(5, phone);
            ps.setString(6, role);

            int rowCount = ps.executeUpdate();
            if (rowCount > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }

        return isSuccess;
    }

    public boolean authenticateEmployee(String email, String password) {
        boolean isAuthenticated = false;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "SELECT * FROM EMPLOYEES WHERE emp_email = ? AND emp_password = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                isAuthenticated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return isAuthenticated;
    }

    
    
    
    public Employee getEmployeeByEmail(String email) {
        Employee employee = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "SELECT * FROM EMPLOYEES WHERE emp_email = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);

            rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("emp_id");
                String name = rs.getString("emp_name");
                String address = rs.getString("emp_address");
                String role = rs.getString("emp_role");
                String password = rs.getString("emp_password");
                String phoneNum = rs.getString("emp_phoneNum");
                int adminId = rs.getInt("admin_id");

                employee = new Employee(id, name, address, role, email, password, phoneNum, adminId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return employee;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "SELECT * FROM EMPLOYEES";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("emp_id");
                String name = rs.getString("emp_name");
                String email = rs.getString("emp_email");
                String address = rs.getString("emp_address");
                String phone = rs.getString("emp_phoneNum");
                String role = rs.getString("emp_role");

                employees.add(new Employee(id, name, address, role, email, "", phone, 0));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, rs);
        }

        return employees;
    }
    public boolean deleteEmployee(int empId) {
        boolean isDeleted = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "DELETE FROM EMPLOYEES WHERE emp_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, empId);

            int rowCount = ps.executeUpdate();
            if (rowCount > 0) {
                isDeleted = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }

        return isDeleted;
    }

    public boolean updateEmployee(Employee employee) {
        boolean isUpdated = false;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConnectionManager.getConnection();
            String query = "UPDATE EMPLOYEES SET emp_name = ?, emp_email = ?, emp_address = ?, emp_phoneNum = ?, emp_role = ? WHERE emp_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, employee.getName());
            ps.setString(2, employee.getEmail());
            ps.setString(3, employee.getAddress());
            ps.setString(4, employee.getPhoneNum());
            ps.setString(5, employee.getRole());
            ps.setInt(6, employee.getId());

            int rowCount = ps.executeUpdate();
            if (rowCount > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(con, ps, null);
        }

        return isUpdated;
    }

    
    public int getTotalEmployees() throws SQLException {
        String query = "SELECT COUNT(*) FROM EMPLOYEES";
        try (Connection con = ConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return 0;
    }
    
    private void closeResources(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}