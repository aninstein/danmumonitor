package com.DanMuSafetyMonitor.bean;

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

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class DanMuInfoServlet
 */
@WebServlet("/DanMuInfoServlet")
public class DanMuInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DanMuInfoServlet() {
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
		ResultSet rsim=null;
		
		//bean
		imtable im=new imtable();
		
		
		//Dao
		artableDao atd=new artableDao();
		imtableDao itd=new imtableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		String index=request.getParameter("theIndex");
		im.setMyIndex(index);
		
		if(!index.equals("")){
		//在执行查询输出
		//查询的表格队列
		List<String> TableList=new ArrayList<String>();
		try {
			rsar=atd.ALLSelect();
		while(rsar.next()){
			TableList.add(rsar.getString("Atable"));
		}
		rsar.close();
		
		int totalDMnum=0;//所有出现次数
		for(int i=0;i<TableList.size();i++){
			totalDMnum=totalDMnum+ssd.getDMIndexNumberOf(TableList.get(i), index);//遍历所有表格获得出现次数
		}
		im.setTimes(totalDMnum);//存入im中
		
		int negDMnum=0;//消极词汇出现次数
		for(int i=0;i<TableList.size();i++){
			negDMnum=negDMnum+ssd.getDMIndexNegNumberOf(TableList.get(i), index);//遍历所有表格获得出现次数
		}
		im.setNegtimes(negDMnum);
		
		if(totalDMnum!=0&&negDMnum!=0){
			im.setNeg(100*(float)negDMnum/totalDMnum);
		}
		else{
			im.setNeg(0);
		}
		int incount=itd.InsertTable(im);//执行插入
		
		
		
		//查询的关键词队列
		List<String> IndexList=new ArrayList<String>();
		rsim=itd.ALLSelect();
		while(rsim.next()){
			IndexList.add(rsim.getString("myIndex"));
		}
		rsim.close();
		
		//查询结果队列：关键字，查询结果集
		List<Map<String, Object>> result=new ArrayList<Map<String,Object>>();
		
		for(int j=0;j<IndexList.size();j++){
			Map<String, Object> map=new HashMap<String, Object>();//关键字、结果集
			List<String> list=new ArrayList<String>();//容器
			for(int i=0;i<TableList.size();i++){
				list=ssd.getIndex(TableList.get(i),IndexList.get(j));
			}
		
			map.put("theIndex", IndexList.get(j));
			map.put("content", list);
			map.put("Times", itd.getIndexTimes(IndexList.get(j)));
			map.put("negTimes", itd.getIndexNegTimes(IndexList.get(j)));
			map.put("neg", itd.getIndexNeg(IndexList.get(j)));
			result.add(map);//插入到输出队列中
		}
		
		String resultStr=JSONArray.fromObject(result).toString();
		out.print(resultStr);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}//if(index!=null)
		else{
			//在执行查询输出
			//查询的表格队列
			List<String> TableList=new ArrayList<String>();
			try {
				rsar=atd.ALLSelect();
			while(rsar.next()){
				TableList.add(rsar.getString("Atable"));
			}
			
			
			//查询的关键词队列
			List<String> IndexList=new ArrayList<String>();
			rsim=itd.ALLSelect();
			while(rsim.next()){
				IndexList.add(rsim.getString("myIndex"));
			}
			
			//查询结果队列：关键字，查询结果集
			List<Map<String, Object>> result=new ArrayList<Map<String,Object>>();
			
			for(int j=0;j<IndexList.size();j++){
				Map<String, Object> map=new HashMap<String, Object>();//关键字、结果集
				List<String> list=new ArrayList<String>();//容器
				for(int i=0;i<TableList.size();i++){
					list=ssd.getIndex(TableList.get(i),IndexList.get(j));
				}
			
				map.put("theIndex", IndexList.get(j));
				map.put("content", list);
				map.put("Times", itd.getIndexTimes(IndexList.get(j)));
				map.put("negTimes", itd.getIndexNegTimes(IndexList.get(j)));
				map.put("neg", ((float)itd.getIndexNeg(IndexList.get(j))));
				result.add(map);//插入到输出队列中
			}
			
			String resultStr=JSONArray.fromObject(result).toString();
			out.print(resultStr);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

}
