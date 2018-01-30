<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付成功返回页面</title>
</head>
<body>
<%@ page import="com.alipay.api.*"%>
<%@ page import="com.alipay.api.request.AlipayTradePagePayRequest"%>
<%@ page import="com.ye.common.AlipayConfig"%>
<%@ page import="java.util.UUID"%>
<%

System.out.println("---------进来----------------");
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
String title = request.getParameter("title");
int price =Integer.parseInt( request.getParameter("price"));
int num = Integer.parseInt(request.getParameter("num"));
String desc = request.getParameter("desc");
String orderID = UUID.randomUUID().toString();

//获得初始化的AlipayClient
AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

//设置请求参数
AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
alipayRequest.setReturnUrl(AlipayConfig.return_url);
alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

//商户订单号，商户网站订单系统中唯一订单号，必填
String out_trade_no = orderID;
//付款金额，必填
String total_amount = num*price+"";
//订单名称，必填
String subject = title;
//商品描述，可空
String body = desc;

alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
		+ "\"total_amount\":\""+ total_amount +"\"," 
		+ "\"subject\":\""+ subject +"\"," 
		+ "\"body\":\""+ body +"\"," 
		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

//若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
//alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
//		+ "\"total_amount\":\""+ total_amount +"\"," 
//		+ "\"subject\":\""+ subject +"\"," 
//		+ "\"body\":\""+ body +"\"," 
//		+ "\"timeout_express\":\"10m\"," 
//		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
//请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

//请求
String result="";
try {
	result = alipayClient.pageExecute(alipayRequest).getBody();
} catch (AlipayApiException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

//输出
out.println(result);



%>>
</body>
</html>