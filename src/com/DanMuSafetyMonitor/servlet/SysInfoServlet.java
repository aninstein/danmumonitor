package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DanMuSafetyMonitor.bean.DBTool;
import com.DanMuSafetyMonitor.bean.SqlSelectDao;
import com.DanMuSafetyMonitor.bean.artableDao;
import com.DanMuSafetyMonitor.bean.matableDao;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class SysInfoServlet
 */
@WebServlet("/SysInfoServlet")
public class SysInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SysInfoServlet() {
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
		
		ResultSet rs=null;

		
		//Dao
		artableDao atd=new artableDao();
		matableDao mtd=new matableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		//查询的表格队列
		List<String> TableList=new ArrayList<String>();
		try {
			rs=atd.ALLSelect();
		
		while(rs.next()){
			TableList.add(rs.getString("Atable"));
		}
		
		int indexDMnum=0;
		for(int i=0;i<TableList.size();i++){
			indexDMnum=indexDMnum+ssd.getIndexNumber(TableList.get(i));
		}
		
		int AllDMnum=0;
		for(int i=0;i<TableList.size();i++){
			AllDMnum=AllDMnum+ssd.ALLDMnumbersearchTable(TableList.get(i));
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("AllDMnum",AllDMnum);
		map.put("indexDMnum",indexDMnum);
		
		String result=JSONObject.fromObject(map).toString();
		out.print(result);
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
