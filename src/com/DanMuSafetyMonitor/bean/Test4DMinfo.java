package com.DanMuSafetyMonitor.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Test4DMinfo {
	public static void main(String[] args) throws SQLException {
		DBTool db=new DBTool();
		Connection conn=db.getConnection();
		
		ResultSet rsar=null;
		ResultSet rsim=null;
		
		
		//Dao
		artableDao atd=new artableDao();
		matableDao mtd=new matableDao();
		imtableDao itd=new imtableDao();
		
		SqlSelectDao ssd=new SqlSelectDao();
		
		//查询的表格队列
		List<String> TableList=new ArrayList<String>();
		rsar=atd.ALLSelect();
		while(rsar.next()){
			TableList.add(rsar.getString("Atable"));
		}
		rsar.close();
		
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
			result.add(map);
		}
		
		
		
		String resultStr=JSONArray.fromObject(result).toString();
		System.out.println(resultStr);
//		for(int i=0;i<result.size();i++){//打印测试输出
//			System.out.println(resultStr);
//		}
	}
}
