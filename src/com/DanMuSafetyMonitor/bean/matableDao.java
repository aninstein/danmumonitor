package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class matableDao {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	matable mt=new matable();
	
	public ResultSet ALLSelect() throws SQLException {//可以查询所有
		ResultSet rs=null;
		String sql="select * from matable";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//db.connclose();
		return rs;
	}
	
	public ResultSet TJSelect(String sql) throws SQLException {//可以条件查询
		ResultSet rs=null;
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//db.connclose();
		return rs;
	}
	
	public ResultSet TJSelectWhere(String shuxing,String tiaojian) throws SQLException {//可以条件查询
		ResultSet rs=null;
		String sql = "select * from matable where "+shuxing+"='"+tiaojian+"'";  
		PreparedStatement pstm=conn.prepareStatement(sql);
//		System.out.println(sql);
		rs=pstm.executeQuery();
		//db.connclose();
		return rs;
	}
	
	public Boolean SelectAnchor(String room) throws SQLException {//可以条件查询
		Boolean b=true;
		ResultSet rs=null;
		String sql = "select MAroom from matable where MAroom=?";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setString(1, room);
//		System.out.println(room);
		rs=pstm.executeQuery();
		while(rs.next()){
			if(room.equals(rs.getString(1))){
				b=false;
			}
		}
		//db.connclose();
		return b;
	}
	
	public int InsertTable(matable mt) throws SQLException {//插入一个监控主播
		int count=0;
		String sql = "insert into matable(MAname,MAroom,MAstate,MApeople,MAhis,MAnow,MAdmnum,MAban) values(?,?,?,?,?,?,?,?)";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setString(1, mt.getMAname());
		pstm.setString(2, mt.getMAroom());
		pstm.setString(3, mt.getMAstate());
		pstm.setString(4, mt.getMApeople());
		pstm.setDouble(5, mt.getMAhis());
		pstm.setDouble(6, mt.getMAnow());
		pstm.setInt(7, mt.getMAdmnum());
		pstm.setInt(8, mt.getMAban());
		count=pstm.executeUpdate();
		//db.connclose();

		return count;
	}
	
	public int UpdateTable(matable mt) throws SQLException {//插入一个监控主播
		int count=0;
		String sql = "Update matable set MAname=?,MAstate=?,MApeople=?,MAhis=?,MAnow=?,MAdmnum=?,MAban=? where MAroom=?";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setString(1, mt.getMAname());
		pstm.setString(2, mt.getMAstate());
		pstm.setString(3, mt.getMApeople());
		pstm.setDouble(4, mt.getMAhis());
		pstm.setDouble(5, mt.getMAnow());
		pstm.setInt(6, mt.getMAdmnum());
		pstm.setInt(7, mt.getMAban());
		pstm.setString(8, mt.getMAroom());
		count=pstm.executeUpdate();
		//db.connclose();

		return count;
	}
	
	public int DeleteTable(String room) throws SQLException {//插入一个监控主播
		int count=0;
		String sql = "delete from matable where MAroom='"+room+"'";
		PreparedStatement pstm=conn.prepareStatement(sql);
		count=pstm.executeUpdate();
//		pstm.setString(1, room);
		//db.connclose();

		return count;
	}
}
