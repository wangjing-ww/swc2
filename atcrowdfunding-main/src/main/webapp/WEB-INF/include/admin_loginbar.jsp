<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/5/18
  Time: 20:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<ul class="nav navbar-nav navbar-right">
    <li style="padding-top:8px;">
        <div class="btn-group">
            <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><sec:authentication property="name"></sec:authentication> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                <li class="divider"></li>
                <form action="${PATH}/admin/logout" method="post" id="logoutForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <li><a id="logoutA" href="javascript:void(0);"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
            </ul>
        </div>
    </li>
    <sec:authorize access="hasAnyRole('PM - 项目经理')">
        <button type="button" class="btn btn-default btn-danger">
            <span class="glyphicon glyphicon-question-sign"></span> 项目经理帮助1
        </button>
    </sec:authorize>
    <sec:authorize access="hasAnyRole('PG - 程序员')">
        <button type="button" class="btn btn-default btn-danger">
            <span class="glyphicon glyphicon-question-sign"></span> 程序员帮助2
        </button>
    </sec:authorize>
    <sec:authorize access="hasAnyRole('SA - 软件架构师')">
        <button type="button" class="btn btn-default btn-danger">
            <span class="glyphicon glyphicon-question-sign"></span> 组长帮助3
        </button>
        <button type="button" class="btn btn-default btn-danger">
            <span class="glyphicon glyphicon-question-sign"></span> 软件架构师帮助4
        </button>
    </sec:authorize>
</ul>
