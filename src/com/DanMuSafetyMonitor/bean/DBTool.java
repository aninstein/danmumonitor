package com.DanMuSafetyMonitor.bean;
import java.sql.*;
import java.util.ResourceBundle;

public class DBTool {
	private String sDBDriver;
    private String sConnStr;
	private String user;
	private String password;
	Connection conn=null;
    ResultSet rs=null;
    
    public DBTool() {//在构造函数里就已经创建了数据库连接
//        try {
//        	ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
//        	sDBDriver = bundle.getString("jdbc.driver");
//        	sConnStr = bundle.getString("jdbc.connstr"); 
//            user = bundle.getString("jdbc.user");
//            password = bundle.getString("jdbc.password");  
//        	
//        	Class.forName(sDBDriver);//加载驱动
//           }
//        catch (java.lang.ClassNotFoundException e)
//        {
//               System.err.println("dbcoursebean():"+e.getMessage());
//         }
//        try {
//		        conn=DriverManager.getConnection(sConnStr,user,password);//创建链接
//		        
//        }
//        catch (SQLException ex)
//        {
//            System.err.println("aq.executeQuery:"+ex.getMessage());
//         }
        
     }
    
    public Connection getConnection(){
    	try {
        	ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
        	sDBDriver = bundle.getString("jdbc.driver");
        	sConnStr = bundle.getString("jdbc.connstr"); 
            user = bundle.getString("jdbc.user");
            password = bundle.getString("jdbc.password");  
        	
        	Class.forName(sDBDriver);//加载驱动
           }
        catch (ClassNotFoundException e)
        {
               System.err.println("dbcoursebean():"+e.getMessage());
         }
        try {
		        conn=DriverManager.getConnection(sConnStr,user,password);//创建链接
		        
        }
        catch (SQLException ex)
        {
            System.err.println("aq.executeQuery:"+ex.getMessage());
         }
        return conn;
    }
    
    public ResultSet executeQuery(String sql)
    {
        rs=null;
        try {
                     	   
        	Statement stmt =conn.createStatement();   
        	rs=stmt.executeQuery(sql);
			   
            }
         catch (SQLException ex)
         {
             System.err.println("aq.executeQuery:"+ex.getMessage());
          }
         return rs;
     }
    
    public int executeUpdate(String sql)
    {
        int count = 0; 
	    try {
               
	    	Statement stmt =conn.createStatement(); //创建Statement类
	    	count = stmt.executeUpdate(sql);
			   
			   
            }
         catch (SQLException ex)
         {
             System.err.println("aq.executeUpdate:"+ex.getMessage());
          }
	    return count;
      }
    
    public void rsclose()
	{
	   try{
		   	   rs.close();
	   }
      catch (SQLException ex)
         {
             System.err.println("aq.executeQuery:"+ex.getMessage());
          }
	}

 
	public void connclose()
	{
		try{
			conn.close();
		}
		catch (SQLException ex)
         {
             System.err.println("aq.executeQuery:"+ex.getMessage());
          }
	}
    
}
