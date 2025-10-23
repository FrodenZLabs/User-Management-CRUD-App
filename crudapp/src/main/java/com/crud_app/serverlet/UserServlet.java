package com.crud_app.serverlet;

import com.crud_app.dao.UserDAO;
import com.crud_app.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                // case "/new":
                //     showNewForm(request, response);
                //     break;
                case "/insert":
                    insertUser(request, response);
                    break;
                case "/delete":
                    deleteUser(request, response);
                    break;
                // case "/edit":
                //     showEditForm(request, response);
                    // break;
                case "/update":
                    updateUser(request, response);
                    break;
                default:
                    listUser(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> listUser = userDAO.selectAllUsers();
        request.setAttribute("listUser", listUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    // private void showNewForm(HttpServletRequest request, HttpServletResponse response)
    //         throws ServletException, IOException {
    //     RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
    //     dispatcher.forward(request, response);
    // }

    // private void showEditForm(HttpServletRequest request, HttpServletResponse response)
    //         throws ServletException, IOException {
    //     int id = Integer.parseInt(request.getParameter("id"));
    //     User existingUser = userDAO.selectUser(id);
    //     RequestDispatcher dispatcher = request.getRequestDispatcher("user-form.jsp");
    //     request.setAttribute("user", existingUser);
    //     dispatcher.forward(request, response);
    // }

    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        User newUser = new User(name, email, country);
        userDAO.insertUser(newUser);
        response.sendRedirect("list?success=User+added+successfully");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        User user = new User(id, name, email, country);
        userDAO.updateUser(user);
        response.sendRedirect("list?success=User+updated+successfully");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id);
        response.sendRedirect("list?success=User+deleted+successfully");
    }


}
