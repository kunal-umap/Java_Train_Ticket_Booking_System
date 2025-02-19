@WebServlet("/TrainServlet")
public class TrainServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String trainName = request.getParameter("trainName");
        String seats = request.getParameter("seats");
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String ownership = request.getParameter("ownership");

        // Store train data in DB (or session for testing)
        request.getSession().setAttribute("train_" + trainName, new String[]{trainName, seats, from, to, ownership});

        response.sendRedirect("admin.jsp");
    }
}
