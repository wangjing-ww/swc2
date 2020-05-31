<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/5/18
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
    $("#logoutA").click(function () {
          layer.confirm("您确定退出吗？",{"title":"退出提示",icon:3},function () {
              //确认按钮单击事件
              //提交注销请求
              //window.location="${PATH}/admin/logout";
              $("#logoutForm").submit();
          });
    })
</script>
