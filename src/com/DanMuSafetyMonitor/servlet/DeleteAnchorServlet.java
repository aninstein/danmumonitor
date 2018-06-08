package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DanMuSafetyMonitor.bean.DBTool;
import com.DanMuSafetyMonitor.bean.SqlSelectDao;
import com.DanMuSafetyMonitor.bean.artableDao;
import com.DanMuSafetyMonitor.bean.matableDao;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class DeleteAnchorServlet
 */
@WebServlet("/DeleteAnchorServlet")
public class DeleteAnchorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAnchorServlet() {
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
		
		
		DBTool db=new DBTool();
		Connection conn=db.getConnection();
		
		ResultSet rsar=null;
//		ResultSet[] rsdm=new ResultSet[50];//最多只能监控50个主播
		
		//Dao
		artableDao atd=new artableDao();
		matableDao mtd=new matableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		String strnum=(String)request.getParameter("roomNumber");
		int roomNumber=Integer.parseInt(strnum);
		System.out.println(roomNumber);
		
		String del=(String)request.getParameter("deleteStr");
		List<String> dellist=new ArrayList<String>();
		for(int i=0;i<del.length();i++){
			String str="";
			if(del.charAt(i)!='#'){
				int j=i;
				for(j=i;del.charAt(j)!='#';j++){
					str+=del.charAt(j);
				}
				i=j;
			}
//			System.out.println(str);
			dellist.add(str);
		}
		System.out.println(dellist.size());
		int delm,dela;
		for(int i=0;i<dellist.size();i++){
				try {
					System.out.println(dellist.get(i));
					dela=atd.DeleteTable((String)dellist.get(i));//删除成功返回2
					delm=mtd.DeleteTable((String)dellist.get(i));//删除成功返回1
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	
		}
		request.getRequestDispatcher("list_anchor.jsp").forward(request, response);
	}

}
