package com.DanMuSafetyMonitor.servlet;

import com.DanMuSafetyMonitor.bean.DBTool;
import com.DanMuSafetyMonitor.bean.SqlSelectDao;
import com.DanMuSafetyMonitor.bean.artableDao;
import com.DanMuSafetyMonitor.bean.matableDao;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2018/6/8.
 */
@WebServlet("/GetAnchorPercentageServlet")
public class GetAnchorPercentageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAnchorPercentageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String room = request.getParameter("room");
        String tablename = "table"+room;

        SqlSelectDao sqlSelectDao = new SqlSelectDao();

        try {
            Map<String, Object> precent = sqlSelectDao.getAnchorPrecentage(tablename);
            String result = JSONObject.fromObject(precent).toString();
            out.print(result);
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }
}
