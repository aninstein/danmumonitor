package com.DanMuSafetyMonitor.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Test2 {
	public static void main(String[] args) throws SQLException {
		DBTool db=new DBTool();
		Connection conn=db.getConnection();
		
		ResultSet rsar=null;
//		ResultSet[] rsdm=new ResultSet[50];//最多只能监控50个主播
		
		//Dao
		artableDao atd=new artableDao();
		matableDao mtd=new matableDao();
		SqlSelectDao ssd=new SqlSelectDao();
		
		//bean
	
		
	}
}
