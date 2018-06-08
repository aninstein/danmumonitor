package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class imtableDao {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	imtable imt=new imtable();
	
	public ResultSet ALLSelect() throws SQLException {//可以查询所有
		ResultSet rs=null;
		String sql="select * from imtable";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//pstm.close();
//		//db.connclose();

		return rs;
	}
	
	public ResultSet TJSelect(String sql) throws SQLException {//可以条件查询
		ResultSet rs=null;
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//pstm.close();
//		//db.connclose();

		return rs;
	}
	
	public ResultSet TJSelectWhere(String shuxing,String tiaojian) throws SQLException {//可以条件查询
		ResultSet rs=null;
		String sql = "select * from imtable where "+shuxing+"='"+tiaojian+"'";  
		PreparedStatement pstm=conn.prepareStatement(sql);
//		System.out.println(sql);
		rs=pstm.executeQuery();
		//pstm.close();
//		//db.connclose();

		return rs;
	}
	
	public int getIndexTimes(String myIndex) throws SQLException {//可以规定查询结果
		ResultSet rs=null;
		int count=0;
		String sql = "select Times from imtable where myIndex='"+myIndex+"'";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			count=rs.getInt(1);
		}
		//pstm.close();
//		//db.connclose();

		return count;
	}
	
	public int getIndexNegTimes(String myIndex) throws SQLException {//可以规定查询结果
		ResultSet rs=null;
		int count=0;
		String sql = "select negtimes from imtable where myIndex='"+myIndex+"'";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			count=rs.getInt(1);
		}
		//pstm.close();
//		//db.connclose();

		return count;
	}
	
	public float getIndexNeg(String myIndex) throws SQLException {//可以规定查询结果
		ResultSet rs=null;
		float count=0;
		String sql = "select neg from imtable where myIndex='"+myIndex+"'";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			count=rs.getFloat(1);
		}
		//pstm.close();
//		//db.connclose();

		return count;
	}
	
	
	
	public int InsertTable(imtable it) throws SQLException {//插入一个监控关键词
		int count=0;
		String sql_count="select MAX(id) from imtable";
		Statement stm=conn.createStatement();
		ResultSet rs=stm.executeQuery(sql_count);
		int uno=9999;
		while(rs.next()){
			uno=rs.getInt(1);
		}
		
		System.out.println(it.getMyIndex());
		System.out.println(it.getTimes());
		System.out.println(it.getNegtimes());
		System.out.println(it.getNeg());
		
		String sql = "insert into imtable(id,myIndex,Times,negtimes,neg) values(?,?,?,?,?)";  
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setInt(1,uno+1);
		pstm.setString(2, it.getMyIndex());
		pstm.setInt(3, it.getTimes());
		pstm.setInt(4, it.getNegtimes());
		String negStr=String.valueOf(it.getNeg());
		pstm.setString(5,negStr);
		count=pstm.executeUpdate();
		//db.connclose();

		return count;
	}

	public int DeleteTable(String index) throws SQLException {//删除一个监控关键词
		int count=0;
		String sql = "delete from imtable where myIndex='"+index+"'";
		PreparedStatement pstm=conn.prepareStatement(sql);
		count=pstm.executeUpdate();
//		pstm.setString(1, room);
		//db.connclose();

		return count;
	}
}
