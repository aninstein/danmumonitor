package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BantableDao {
	DBTool dbtool = new DBTool();
	Connection conn = dbtool.getConnection();
	
	public List<Bantable> Searchbantable(String Aname) throws SQLException
	{
		String name = Aname;
		String sql = "select * from matable where MAname = '"+name+"'";
		Statement stm = conn.createStatement();
		ResultSet rs = stm.executeQuery(sql);
		List<Bantable> list=new ArrayList<Bantable>();
		while(rs.next())
		{
			Bantable ban = new Bantable();
			ban.setAname(rs.getString("MAname"));
			ban.setAtype("NULL");
			ban.setAhis(rs.getDouble("MAhis"));
			ban.setMAtype("NULL");
			ban.setAtime(new Date().getTime()+"");
			list.add(ban);
		}
		//dbtool.connclose();

		return list;
	}
	public int InsertBantable(List<Bantable> list) throws SQLException
	{
		Statement stm = conn.createStatement();
		
		for(Bantable ban:list){
			String sql ="insert into bantable(Aname,Atype,Ahis,MAtype,Atime) values('"+
																				ban.getAname()+"','"+ban.getAtype()+"',"+ban.getAhis()+",'"+ban.getMAtype()+"','"+ban.getAtime()+"')";
			stm.addBatch(sql);
		}
		int[] co = stm.executeBatch();
		//dbtool.connclose();

		return co.length;
	}
	

}
