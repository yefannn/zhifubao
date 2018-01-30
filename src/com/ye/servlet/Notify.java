package com.ye.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Notify
 */
@WebServlet("/notify")
public class Notify extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("接收到支付宝异步返回的信息-------------------------");
		Map<String, String[]> parameterMap = request.getParameterMap();
		for(Map.Entry<String, String[]> map:parameterMap.entrySet()){
			System.out.println(map.getKey()+":"+map.getValue());
			System.out.println("-----分割线----------");
		  String[] values = map.getValue();
		  for (String v : values) {
			System.out.println(v);
		}
		}
	}

}
