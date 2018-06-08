package com.DanMuSafetyMonitor.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Test {
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
	
		List<matable> inmalist=new ArrayList<matable>();
		List<matable> upmalist=new ArrayList<matable>();
		rsar=atd.ALLSelect();
		while(rsar.next()){
			matable mt=new matable();//这个生命一定要放在这个点，不能放在外面
			mt.setMAname((String)rsar.getString("Aname"));//主播名
			mt.setMAroom((String)rsar.getString("Aroom"));//主播房间号
			mt.setMAstate("在线");//在线状态
			mt.setMApeople("100000");//观众人数
			mt.setMAhis((double)ssd.getHisGrade((String)rsar.getString("Atable")));//历史评分
			mt.setMAnow((double)ssd.getNowGrade((String)rsar.getString("Atable")));//当前评分
			mt.setMAdmnum(ssd.ALLDMnumbersearchTable((String)rsar.getString("Atable")));//获取所有弹幕数量
			mt.setMAban(1);
			if(mtd.SelectAnchor((String)rsar.getString("Aroom"))){//查询是否已经有该主播,如果已经有返回的是false
				inmalist.add(mt);//插入队列
			}
			else{
				upmalist.add(mt);
			}
		}
		
		int incount=0,upcount=0;
		if(inmalist.size()>0){//如果插入队列有值就执行插入
			for(int i=0;i<inmalist.size();i++){
				if(inmalist.get(i)!=null){
					incount+=mtd.InsertTable(inmalist.get(i));
				}
			}
		}
		else if(upmalist.size()>0){//如果更新队列有值就执行更新
			for(int i=0;i<upmalist.size();i++){
				if(upmalist.get(i)!=null){
					upcount+=mtd.UpdateTable(upmalist.get(i));
				}
			}
		}
		else{
			System.out.println("无更新！");	
		}
		System.out.println("插入了"+incount);
		System.out.println("修改了"+upcount);	
	}
}
