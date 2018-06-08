package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.DanMuSafetyMonitor.bean.SqlSelectDao;
import com.DanMuSafetyMonitor.bean.artableDao;
import com.DanMuSafetyMonitor.bean.matable;
import com.DanMuSafetyMonitor.bean.matableDao;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class AnchorProDanMuServlet
 */
@WebServlet("/AnchorProDanMuServlet")
public class AnchorProDanMuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnchorProDanMuServlet() {
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
		
		
		
		String MAname=request.getParameter("listMAname");
		matableDao mtd=new matableDao();
		matable mt=new matable();
		ResultSet rs_a=null;
		try {
			rs_a = mtd.TJSelectWhere("MAname", MAname);
		
		while(rs_a.next()){
			mt.setMAname(MAname);
			mt.setMAroom((String)rs_a.getString("MAroom"));
			mt.setMAstate((String)rs_a.getString("MAstate"));
			mt.setMAhis((Double)rs_a.getDouble("MAhis"));
			mt.setMAnow((Double)rs_a.getDouble("MAnow"));
		}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		artableDao artd=new artableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		String theTable=null;
		
		ResultSet rs=null;
		
		int DMcount=0;

		try {
			theTable=artd.searchTable(mt.getMAroom());//搜索表格名称
//			System.out.println(theTable);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(theTable!=null){
			try {
				rs=ssd.searchTable(theTable);
				DMcount=ssd.ALLDMnumbersearchTable(theTable);
				mt.setMAdmnum(DMcount);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		List<Map<String,String>> DMlist = new ArrayList<Map<String,String>>();
		int i=0;
		try {
			while(rs.next()){
				i++;
				Map<String,String> DM = new HashMap<String,String>();
				DM.put("DM",rs.getString("content"));
				DMlist.add(DM);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String,Object> returnMap = new HashMap<String,Object>();
		returnMap.put("total", i);
		returnMap.put("rows", DMlist);
		String result = JSONObject.fromObject(returnMap).toString();//把JSON格式化为字符串然后返回jsp页面
//		System.out.println(result);
	    out.print(result);
	    request.setAttribute("JSON", result);
		request.setAttribute("mt", mt);//本页主播信息
		request.setAttribute("DMTbaleRs", rs);//弹幕查询的结果集
		request.getRequestDispatcher("anchor_profile.jsp").forward(request, response);
	}

}
