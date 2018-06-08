package com.DanMuSafetyMonitor.servlet;

import java.io.IOException;
import java.io.PrintWriter;
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

import com.DanMuSafetyMonitor.bean.Alarmtable;
import com.DanMuSafetyMonitor.bean.AlarmtableDao;
import com.DanMuSafetyMonitor.bean.StatisticstableDao;

import net.sf.json.JSONObject;

/**
 * Servlet implementation class AlarmServlet
 */
@WebServlet("/AlarmServlet")
public class AlarmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlarmServlet() {
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
		// TODO Auto-generated method stub
				request.setCharacterEncoding("UTF-8");
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
		
		AlarmtableDao alar=new AlarmtableDao();
		StatisticstableDao stat=new StatisticstableDao();
		List<Alarmtable> alarmtableList=new ArrayList<Alarmtable>();
		
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		
		try {
			int renshu=alar.renshu();
			alarmtableList=alar.Searchmatable();
			
			List<String> haveList=alar.Searchhavetable();
			
			Map<String,Object> alarMap=new HashMap<String, Object>();
			
			for(Alarmtable alart:alarmtableList){
				for(int i=0;i<haveList.size();i++){
					if(!haveList.get(i).equals(alart.getAroom())){
						int insert=alar.InsertAlarmtableOne(alart);
					}
					else{
						int up=alar.updateAlarmtableOne(alart);
					}
				}
				 
				alarMap.put("theAname", alart.getAname());
				alarMap.put("theAroom", alart.getAroom());
				alarMap.put("theType", alart.getAtype());
				list.add(alarMap);
			}
			
			Map<String,Object> result=new HashMap<String, Object>();
			result.put("alarNum", renshu);
			result.put("alarList", list);
			
			String theResult=JSONObject.fromObject(result).toString();
			System.out.println(theResult);
			out.print(theResult);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
