package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class usertableDao {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	
	public Boolean VerSelect(String uname,String upass) throws SQLException {//这个函数用来验证登陆
		Boolean b=false;
		ResultSet rs=null;
		String sql="select Upass from usertable where Uname=?";
		// 0-System.out.println(uname+upass);
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setString(1, uname);
		rs=pstm.executeQuery();
		while(rs.next()){
			if(upass.equals(rs.getString("Upass"))){
				b=true;
			}
		}
		//db.connclose();


		return b;
	}
	
	public ResultSet ALLselect() throws SQLException {
		ResultSet rs=null;
		String sql="select * from usertable";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		//db.connclose();

		return rs;
	}
}
