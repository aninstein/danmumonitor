package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DanMuSafetyMonitor.bean.SqlSelectDao;
import com.DanMuSafetyMonitor.bean.SqlString;
import com.DanMuSafetyMonitor.bean.usertableDao;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();

		usertableDao utd=new usertableDao();
		
		String uname=request.getParameter("username");
		String upass=request.getParameter("password");
		String ugrantStr=request.getParameter("manager");
		int ugrant=0;
		if(ugrantStr!=null){
			ugrant=Integer.parseInt(ugrantStr);
		}
		boolean b = false;
			if(uname==null)
			{
				out.print("");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			else if(ugrant==1){//即经理登陆
				try {
					b=utd.VerSelect(uname, upass);
				
				if(b){
					session.setAttribute("Uname",uname);
					session.setAttribute("Ugrant",ugrant);
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
				else{
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else{//管理员登陆
				try {
					b=utd.VerSelect(uname, upass);
					if(b){
						session.setAttribute("Uname",uname);
						session.setAttribute("Ugrant",ugrant);
						request.getRequestDispatcher("index.jsp").forward(request, response);
						 
					}
					else{
						request.getRequestDispatcher("login.jsp").forward(request, response);
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
	}
}


