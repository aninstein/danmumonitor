package com.DanMuSafetyMonitor.data;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.DanMuSafetyMonitor.bean.*;


public class GetArtableToMatable {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	
	ResultSet rsar=null;
	ResultSet[] rsdm=new ResultSet[50];//最多只能监控50个主播
	
	//Dao
	artableDao atd=new artableDao();
	matableDao mtd=new matableDao();
	SqlSelectDao ssd=new SqlSelectDao();
	
	//bean
	matable mt=new matable();
	
	public matable GetArtToMa() throws SQLException {
		int i=0;
		rsar=atd.ALLSelect();
		while(rsar.next()){
			mt.setMAname(rsar.getString("Aname"));//主播名
			mt.setMAroom(rsar.getString("Aroom"));//主播房间号
			rsdm[i]=ssd.ALLsearchTable(rsar.getString("Atable"));//把房间号放到数组里
			i++;
		}
		
		for(i=0;i<50;i++){
			if(rsdm[i]!=null){
				mt.setMAstate("在线");//在线状态
				mt.setMApeople("100000");//观众人数
				mt.setMAhis(ssd.getHisGrade(rsar.getString("Atable")));//历史评分
				mt.setMAnow(ssd.getNowGrade(rsar.getString("Atable")));//当前评分\
				mt.setMAdmnum(ssd.ALLDMnumbersearchTable(rsar.getString("Atable")));
				mt.setMAban(1);
			}
		}		
		return mt;
	}

}
