package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class artableDao {
	DBTool dbTool=new DBTool();
	Connection conn=dbTool.getConnection();
	
	public String searchTable(String MAroom) throws SQLException {//通过房间号查询主播表名
		String atable="";
		ResultSet rs=null;
		String sql="select Atable from artable where Aroom='"+MAroom+"'";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			atable=rs.getString("Atable");
		}
		//dbTool.connclose();

		return atable;
	}
	
	public ResultSet ALLSelect() throws SQLException {//可以查询所有
		ResultSet rs=null;
		String sql="select * from artable";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//dbTool.connclose();
		return rs;
	}
	
	public int DeleteTable(String room) throws SQLException {//插入一个监控主播
		
		String sql = "delete from artable where Aroom='"+room+"'";
		String dropsql="drop table table"+room+"";
		Statement stm=conn.createStatement();
		stm.addBatch(sql);
		stm.addBatch(dropsql);
		int[] count=stm.executeBatch();
		int result=count.length;
//		pstm.setString(1, room);
		//dbTool.connclose();

		return result;
	}
	
}


