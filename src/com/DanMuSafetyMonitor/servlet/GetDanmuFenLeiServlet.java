package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.print.attribute.HashAttributeSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;

import com.DanMuSafetyMonitor.bean.SqlSelectDao;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class GetDanmuFenLeiServlet
 */
@WebServlet("/GetDanmuFenLeiServlet")
public class GetDanmuFenLeiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetDanmuFenLeiServlet() {
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
		
		SqlSelectDao ssd=new SqlSelectDao();
		
		Map<String,Object> map=new HashMap<String, Object>();
		
		try {
			map.put("sex", ssd.getAllTableFenlei(1));
			map.put("abuse", ssd.getAllTableFenlei(2));
			map.put("react", ssd.getAllTableFenlei(3));
			map.put("vio", ssd.getAllTableFenlei(4));
			map.put("other", ssd.getAllTableFenlei(5));
			
			String result=JSONArray.fromObject(map).toString();
			System.out.println(result);
			out.print(result);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
