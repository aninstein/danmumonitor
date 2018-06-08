package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class StatisticstableDao {
	DBTool db=new DBTool();
	Connection conn=db.getConnection();
	
	public List<Statisticstable> Selectstat() throws SQLException {//鍙互鏌ヨ鎵�鏈�
		
		artableDao at=new artableDao();
		ResultSet rs=at.ALLSelect();
		SqlSelectDao as=new SqlSelectDao();
		List<Statisticstable> statList=new ArrayList<Statisticstable>();
		while(rs.next()){
			Statisticstable stat=new Statisticstable();
			stat.setAroom(rs.getString("MAroom"));
			stat.setAsex(as.getFenLei(rs.getString("MAroom"), 1));
			stat.setAabuse(as.getFenLei(rs.getString("MAroom"), 2));
			stat.setAreact(as.getFenLei(rs.getString("MAroom"), 3));
			stat.setAvio(as.getFenLei(rs.getString("MAroom"), 4));
			stat.setAother(as.getFenLei(rs.getString("MAroom"), 5));
            stat.setAtype(getflagstr(getMax(stat)));
            statList.add(stat);
		}

        //db.connclose();

		return statList;
		
	}
	
	public int Insertstate(List<Statisticstable> list) throws SQLException{
        Statement stm = conn.createStatement();
		
		for(Statisticstable alar:list){
			String sql ="insert into statisticstable(Aroom,Atype,Asex,Aabuse,Areact,Avio,Aother) values('"+
																				alar.getAroom()+
																				"','"+alar.getAtype()+
																				"',"+alar.getAsex()+
																				","+alar.getAtype()+
																				","+alar.getAabuse()+
																				","+alar.getAreact()+
																				","+alar.getAvio()+
																				","+alar.getAother()+")";
			stm.addBatch(sql);
		}
		int[] co = stm.executeBatch();
        //db.connclose();

		return co.length;
	}
	
	public int getMax(Statisticstable stat){
		int max=0;
		int[] value={stat.getAsex(),stat.getAabuse(),stat.getAreact(),stat.getAvio(),stat.getAother()};
		for(int i=0;i<5;i++){
			for(int j=i+1;j<5;j++){
				if(value[j]>value[i]){
					max=j;
					j=i;
					i=max;
				}
			}
		}


		return max+1;
	}
	
	public String getflagstr(int a){
		String re="";
		switch (a) {
		case 1:
			re="色情淫秽";
			break;
		case 2:
			re="侮辱谩骂";
			break;
		case 3:
			re="反动政治";
			break;
		case 4:
			re="血腥暴力";
			break;
		case 5:
			re="其他";
			break;
		default:
			re="正常";
			break;
		}
		return re;
	}
	
	
}
