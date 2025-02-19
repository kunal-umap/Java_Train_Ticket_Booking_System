@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("adminUsername", request.getParameter("username"));
        session.setAttribute("adminEmail", request.getParameter("email"));
        session.setAttribute("adminMobile", request.getParameter("mobile"));
        
        if (!request.getParameter("password").isEmpty()) {
            session.setAttribute("adminPassword", request.getParameter("password"));
        }
        
        response.sendRedirect("admin.jsp");
    }
}
