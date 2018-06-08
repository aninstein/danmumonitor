package com.DanMuSafetyMonitor.bean;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class SqlSelectDao {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	
	public ResultSet ALLsearchTable(String table) throws SQLException {//查询弹幕内容
		ResultSet str=null;
		String sql="SELECT * FROM "+table;//查询所有弹幕
		PreparedStatement pstm=conn.prepareStatement(sql);
		str=pstm.executeQuery();
		//db.connclose();

		return str;
	}
	
	public int ALLDMnumbersearchTable(String table) throws SQLException {//查询所有弹幕数量
		int count=0;
		ResultSet rs=null;
		String sql="SELECT count(content) FROM "+table;//查询所有弹幕数量
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		if(rs.next()){
			count=rs.getInt(1);
		}
		//db.connclose();

		return count;
	}
	
	public ResultSet searchTable(String table) throws SQLException {//查询弹幕内容
		ResultSet str=null;
		String sql="SELECT content FROM "+table+" WHERE number>(SELECT MAX(number)-20 FROM "+table+") ORDER BY(number) DESC";//查询前20条
		PreparedStatement pstm=conn.prepareStatement(sql);
		//pstm.setString(1, table);
		//pstm.setString(2, table);
		str=pstm.executeQuery();
		//db.connclose();

		return str;
	}
	
	
	public int searchMApoeple(String table){//查询观众人数
		ResultSet rs=null;
		int count = 0;
		String sql="SELECT count(DISTINCT id) FROM "+table;//查询观众人数
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
		}catch (SQLException se){
			System.out.println(se);
		}finally {
			//db.connclose();
		}
		return count;
	}


	public double getHisGrade(String table) throws SQLException {//历史评分
		ResultSet rs=null;
		double grade=0.0;
		String sql="SELECT AVG(neg) FROM "+table;
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		if(rs.next()){
			grade=rs.getDouble(1);
		}
		//db.connclose();

		return grade*20;
	}
	
	public double getNowGrade(String table) throws SQLException {//当前评分
		ResultSet rs=null;
		double grade=0.0;
		String sql="SELECT AVG(neg) FROM "+table+" WHERE number>(SELECT MAX(number)-100 FROM "+table+")";//当前评分是前一百条的评分
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		if(rs.next()){
			grade=rs.getDouble(1);
		}
		//db.connclose();

		return grade*20;
	}

	/*
	查询弹幕数量
	 */
	public int getDanmuNumerByTable(String table){//查询某一类个主播的所有弹幕的数量
		ResultSet rs=null;
		int count=0;
		String sql="SELECT count(content) FROM " + table;
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
 		} catch (SQLException se){
			se.getSQLState();
		}finally {
			//db.connclose();
		}
		return count;
	}

	/*
	 * flag的值有
	 * 1色情
	 * 2谩骂
	 * 3反动
	 * 4血腥
	 * 5其他*/
	public int getFenLei(String table,int flag) throws SQLException {//查询某一类弹幕的数量
		ResultSet rs=null;
		int count=0;
		String sql="SELECT count(flag) FROM "+table+" WHERE flag=?";
		PreparedStatement pstm=conn.prepareStatement(sql);
		pstm.setInt(1, flag);
		rs=pstm.executeQuery();
		if(rs.next()){
			count=rs.getInt(1);
		}
		//db.connclose();

		return count;
	}
	public int getAllTableFenlei(int flag) throws SQLException {
		int count=0;
		artableDao at=new artableDao();
		ResultSet rs=at.ALLSelect();
		String sql="";
		Statement stm=conn.createStatement();
		
		//为sql赋值，查询所有表格一类数据的数量
		for(int i=0;rs.next();i++){
			sql+=" SELECT count(*) times FROM "+rs.getString("Atable")+"  WHERE flag="+flag+" UNION ";
		}
		sql+="SELECT count(*) times FROM notest  WHERE flag="+flag;
		rs=stm.executeQuery(sql);
		while(rs.next()){
			count+=rs.getInt("times");
		}
		//db.connclose();

		return count;
	}
	
	public int getIndexNumber(String table) throws SQLException {//查询敏感词数量
		ResultSet rs=null;
		int count=0;
		String sql="SELECT count(neg) FROM "+table+" WHERE neg>0.4";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		if(rs.next()){
			count=rs.getInt(1);
		}
		//db.connclose();

		return count;
	}
	
	public List<String> getIndex(String table,String index) throws SQLException {//查询敏感词内容
		ResultSet rs=null;
		List<String> contentList=new ArrayList<String>();
		String sql="SELECT content FROM "+table+" WHERE content like '%"+index+"%' and mark<0";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			contentList.add(rs.getString("content"));
		}
		//db.connclose();

		return contentList;
	}
	
	public int getDMIndexNumberOf(String table,String index) throws SQLException {//查询敏感词出现次数
		ResultSet rs=null;
		int count=0;
		String sql="SELECT count(*) FROM "+table+" WHERE content like '%"+index+"%'";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			count=rs.getInt(1);
		}
		//db.connclose();

		return count;
	}
	
	public int getDMIndexNegNumberOf(String table,String index) throws SQLException {//查询消极敏感词出现次数
		ResultSet rs=null;
		int count=0;
		String sql="SELECT count(*) FROM "+table+" WHERE content like '%"+index+"%' and mark<0";
		PreparedStatement pstm=conn.prepareStatement(sql);
		rs=pstm.executeQuery();
		while(rs.next()){
			count=rs.getInt(1);
		}
		//db.connclose();

		return count;
	}

	public Map<String, Object> getAnchorPrecentage(String tablename) throws SQLException {

		DecimalFormat df = new DecimalFormat( "0.00");

		int allDanmuNumber = getDanmuNumerByTable(tablename);
		int sex = getFenLei(tablename, 1) ;
		int abuse = getFenLei(tablename, 2) ;
		int react = getFenLei(tablename, 3) ;
		int violence = getFenLei(tablename, 4) ;
		int other = getFenLei(tablename, 5) ;

		// 百分比
		HashMap<String, Object> precentageMap = new HashMap<>();
		precentageMap.put("sex", df.format((sex * 100) / allDanmuNumber));
		precentageMap.put("abuse", df.format((abuse * 100) / allDanmuNumber));
		precentageMap.put("react", df.format((react * 100) / allDanmuNumber));
		precentageMap.put("violence", df.format((violence * 100) / allDanmuNumber));
		precentageMap.put("other", df.format((other * 100) / allDanmuNumber));

		String maxType = "";
		double max = 0;
		for(String key:precentageMap.keySet()) {
			if(Double.parseDouble((String) precentageMap.get(key)) > max){
				max = Double.parseDouble((String) precentageMap.get(key));
				maxType = key;
			}
		}
		HashMap<String, String> typeMap = new HashMap<>();
		typeMap.put("sex", "色情");
		typeMap.put("abuse", "侮辱谩骂");
		typeMap.put("react", "反动政治");
		typeMap.put("violence", "血腥暴力");
		typeMap.put("other", "其他违法");

		if(Double.parseDouble((String) precentageMap.get(maxType))>10) {
			precentageMap.put("prefer", typeMap.get(maxType));
		} else {
			precentageMap.put("prefer", "正常");
		}
		return precentageMap;
	}
}
