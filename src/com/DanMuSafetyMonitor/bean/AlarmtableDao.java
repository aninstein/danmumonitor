package com.DanMuSafetyMonitor.bean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AlarmtableDao {
    DBTool dbTool = new DBTool();
    Connection conn = dbTool.getConnection();

    public int renshu() throws SQLException {
        int count = 0;
        String sql = "select count(*) from matable where MAnow <7";
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(sql);

        while (rs.next()) {
            count = rs.getInt(1);
        }
        //dbTool.connclose();
        return count;
    }

    public List<Alarmtable> Searchmatable() throws SQLException {
        String sql = "select * from matable where MAnow <7";
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        List<Alarmtable> list = new ArrayList<Alarmtable>();

        while (rs.next()) {
            Alarmtable alar = new Alarmtable();
            alar.setAname(rs.getString("MAname"));
            alar.setAroom(rs.getString("MAroom"));
            alar.setAcredit(rs.getDouble("MAnow"));
            alar.setAtype(Searchtype(rs.getString("MAroom")));
            alar.setAtime(new Date().getTime() + "");
            list.add(alar);
        }
        //dbTool.connclose();
        return list;
    }

    public String Searchtype(String room) throws SQLException {
        String sql = "select Atype from statisticstable where Aroom='" + room + "'";
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(sql);

        String type = "";
        while (rs.next()) {
            type += rs.getString("Atype");
        }
        //dbTool.connclose();
        return type;
    }

    public List<String> Searchhavetable() throws SQLException {
        String sql = "select * from alarmtable";
        Statement stm = conn.createStatement();
        ResultSet rs = stm.executeQuery(sql);
        List<String> list = new ArrayList<String>();
        while (rs.next()) {
            list.add(rs.getString("MAroom"));
        }
        //dbTool.connclose();
        return list;
    }

    public int InsertAlarmtable(List<Alarmtable> list) throws SQLException {
        Statement stm = conn.createStatement();

        for (Alarmtable alar : list) {
            String sql = "insert into alarmtable(Aname,Aroom,Acredit,Atype,Atime) values('" + alar.getAname() + "','" + alar.getAroom() + "'," + alar.getAcredit() + ",'" + alar.getAtype() + "','" + alar.getAtime() + "')";
            stm.addBatch(sql);
        }
        int[] co = stm.executeBatch();
        //dbTool.connclose();
        return co.length;

    }


    public int updateAlarmtable(List<Alarmtable> list) throws SQLException {
        Statement stm = conn.createStatement();

        for (Alarmtable alar : list) {
            String sql = "update alarmtable set Acredit='" + alar.getAcredit() + "',Atype='" + alar.getAtype() + "',Atime='" + alar.getAtime() + "' where Aroom='" + alar.getAroom() + "')";
            stm.addBatch(sql);
        }
        int[] co = stm.executeBatch();
        //dbTool.connclose();
        return co.length;

    }

    public int InsertAlarmtableOne(Alarmtable alar) throws SQLException {
        int count = 0;
        Statement stm = conn.createStatement();


        String sql = "insert into alarmtable(Aname,Aroom,Acredit,Atype,Atime) values('" + alar.getAname() + "','" + alar.getAroom() + "'," + alar.getAcredit() + ",'" + alar.getAtype() + "','" + alar.getAtime() + "')";
        count = stm.executeUpdate(sql);
        //dbTool.connclose();
        return count;

    }


    public int updateAlarmtableOne(Alarmtable alar) throws SQLException {
        Statement stm = conn.createStatement();


        String sql = "update alarmtable set Acredit='" + alar.getAcredit() + "',Atype='" + alar.getAtype() + "',Atime='" + alar.getAtime() + "' where Aroom='" + alar.getAroom() + "')";

        int count = stm.executeUpdate(sql);
        stm.close();
//        //dbTool.connclose();
        return count;

    }


}
