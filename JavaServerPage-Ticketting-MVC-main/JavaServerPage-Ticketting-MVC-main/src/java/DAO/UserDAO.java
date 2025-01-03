package DAO;

import java.util.List;
import Models.UserWeb;
import Models.Admin;

public interface UserDAO {
    // For regular users
    void createUser(UserWeb user);
    UserWeb getUserById(String userId);
    List<UserWeb> getAllUsers();
    void updateUser(UserWeb user);
    void deleteUser(String userId);

    // For admin users
    void createAdmin(Admin admin);
    Admin getAdminById(String adminId);
    List<Admin> getAllAdmins();
    void updateAdmin(Admin admin);
    void deleteAdmin(String adminId);
}