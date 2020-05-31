<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/5/18
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--  静态资源[jquery/bs ] 不能放在WEB-INF，存放在webapp目录下--%>
<%-- Controller映射方法 和static文件夹 相当于在同一级目录下--%>
<base  href="${PATH}/static/"/>
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/carousel.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="ztree/zTreeStyle.css">

<%--
    <%@ include file="/WEB-INF/include/base_css.jsp"%>
   <%@include file="/WEB-INF/include/admin_loginbar.jsp"%>
    <%@include file="/WEB-INF/include/admin_menubar.jsp"%>
     <%@ include file="/WEB-INF/include/base_js.jsp"%>


     //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('用户维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('用户维护')").css("color" , "red");
--%>
