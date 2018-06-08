package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DanMuSafetyMonitor.bean.*;



/**
 * Servlet implementation class AnchorMonitorServlet
 */
@WebServlet("/AnchorMonitorServlet")
public class AnchorMonitorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnchorMonitorServlet() {
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
		
		matableDao mtd=new matableDao();

		
		HttpSession session = request.getSession();
		ResultSet searchAnchorRs=null;
		
	    if(session.getAttribute("Uname") == null)
	    {
	        response.sendRedirect("login.jsp");
	        
	    }
	    else
	    {
	    String search=request.getParameter("searchAnchor");
		String tiaojian = " 'a'='a' ";
		if(search==null || search.trim().equals("")){
			try {//其实内容并没有被执行
				searchAnchorRs = mtd.ALLSelect();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if(search!=null && !search.trim().equals("")){
		    tiaojian += " and MAroom='"+search+"' ";
		}
		String sql = "select * from matable where " + tiaojian;  
//		String sql = "select * from matable"; 
        try{
           searchAnchorRs = mtd.TJSelect(sql);
           request.setAttribute("searchAnchorRs", searchAnchorRs);
           request.getRequestDispatcher("list_anchor.jsp").forward(request, response);
          }
          catch(Exception e)
          {
        	  this.getServletContext().log(e.getMessage());
        	  throw new ServletException("Servlet Error!");
        	  
          }
	    }
	}

}

