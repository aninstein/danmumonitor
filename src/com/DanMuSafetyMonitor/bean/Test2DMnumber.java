package com.DanMuSafetyMonitor.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Test2DMnumber {
	public static void main(String[] args) throws SQLException {
		DBTool db=new DBTool();
		Connection conn=db.getConnection();
		
		ResultSet rs=null;

		
		//Dao
		artableDao atd=new artableDao();
		matableDao mtd=new matableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		//查询的表格队列
		List<String> TableList=new ArrayList<String>();
		rs=atd.ALLSelect();
		while(rs.next()){
			TableList.add(rs.getString("Atable"));
		}
		
		int AllDMnum=0;
		for(int i=0;i<TableList.size();i++){
			AllDMnum=AllDMnum+ssd.ALLDMnumbersearchTable(TableList.get(i));
		}
		
		System.out.println("当前弹幕条数是："+AllDMnum);
		
		
	}
}
