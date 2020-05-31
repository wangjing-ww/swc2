<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/5/19
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/include/base_css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">


            <%@include file="/WEB-INF/include/admin_loginbar.jsp"%>

            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/include/admin_menubar.jsp"%>

        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="contitionInput" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryRoleBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="batchDelRoleBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="showAddModalBtn" type="button" class="btn btn-primary" style="float:right;"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/include/base_js.jsp"%>
<%-- 新增角色的modal  模态框：默认不会显示 --%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel1">新增角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <%--表单项必须有name属性值才会被提交--%>
                        <input name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%-- 更新角色的模态框 --%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">更新角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id" />
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name1">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
    //当打开角色维护的相关页面时，设置角色维护所在的父菜单的子菜单列表显示
    $("a:contains('角色维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('角色维护')").css("color" , "red");
    // 声明 全局变量
    // 总页码
    var totalPages;
    var page;
    //*************************************更新角色****************************************
    $("tbody").delegate(".showUpdateRoleModalBtn","click",function () {
        //获取 角色的id
        var roleId = this.id;
        $.get("${PATH}/role/getRole",{id:roleId},function (role) {
            // 将服务器响应的id对应的角色 数据显示到模态框
            // id放在 隐藏域获取的
           $("#updateRoleModal input[name='id']").val(role.id);
           $("#updateRoleModal input[name='name']").val(role.name);
           $("#updateRoleModal").modal("toggle");
        })

    });
    // 给提交的 模态框 绑定单击事件
    // 提交更新到服务器 服务器处理完成响应回来 关闭模态框 更新列表
    $("#updateRoleModal #updateRoleBtn").click(function () {

        $.ajax({
            type:"post",
            data:$("#updateRoleModal form").serialize(),
            url:"${PATH}/role/updateRole",
            success:function (data) {
                if (data=="ok"){
                    $("#updateRoleModal").modal("toggle");
                    initRoleTable(page);
                }
            }
        })
    });


    //************************************批量删除*******************************************
       $("thead :checkbox").click(function () {
              // 查找子复选框
              $("tbody :checkbox").prop("checked",this.checked);
       });

       // 绑定动态委派事件
      $("tbody").delegate(":checkbox","click",function () {
           var totalCount = $("tbody :checkbox").length;
           var checkedCount = $("tbody :checkbox:checked").length;
           $("thead :checkbox").prop("checked",totalCount==checkedCount);
      });

      $("#batchDelRoleBtn").click(function () {

          var roleIdsArr = new Array();
          $("tbody :checkbox:checked").each(function () {

              var roleId = this.id;//要删除的id
              roleIdsArr.push(roleId);
          });
          var roleIdStrs = roleIdsArr.join();
          $.ajax({
              type:"get",
              data:{ids:roleIdStrs},
              url:"${PATH}/role/batchDelRole",
              success:function (data) {
                  if (data=="ok"){
                      layer.msg("批量删除 成功");
                      initRoleTable(page);
                  }
              }
          });
      });
    //***********************************新增角色***********************************
   //1.给新增 按钮绑定 单击事件
    $("#showAddModalBtn").click(function () {
        $("#addRoleModal").modal("toggle");
    });

    //2.给模态框设置单击事件
    $("#addRoleModal #addRoleBtn").click(function () {
        $.ajax({
            type:"post",
            /*这里没有获取到参数*/
            data:$("#addRoleModal form").serialize(),
            url:"${PATH}/role/addRole",
            success:function (data) {
                if (data=="ok"){
                   $("#addRoleModal").modal("toggle");
                   initRoleTable(totalPages+1);
                }else if (data=="fail"){
                    $("#addRoleModal").modal("toggle");
                    layer.alert("您无权访问 请联系管理员解决");
                }
            }
        });
    });
    //==============================================================================
    // 查询功能
    // 给 查询调件 绑定单击事件
     $("#queryRoleBtn").click(function () {
         // 条件
         var condition = $("#contitionInput").val();
         var pageNum = 1;
         initRoleTable(pageNum,condition);

     });
    //*****************************************************************************
    // 当前页面 已经解析完成 页面中暂时缺失数据
    // 默认需要查询 第一页的数据
    // 通过 ajax请求 第一页数据显示
      initRoleTable(1);
    //=========================================================================、


    //抽取 异步分页请求的 解析函数

    function initRoleTable(pageNum,condition) {

        //每次加载分页的角色列表时，需要将之前的分页数据清除
        $("tbody").empty();//掏空
        $("tfoot ul").empty();
        $.ajax({
            type:"get",
            url:"${PATH}/role/getRoles",
            data:{"pageNum":pageNum,"condition":condition},
            success:function (pageInfo) {
                //服务器响应成功后的回调函数
                layer.msg("请求列表 成功");
                console.log(pageInfo);
                //dom解析将pageINfo的数据遍历显示到表格中
                  totalPages = pageInfo.pages;
                  page = pageInfo.pageNum;
                // 1.遍历pageInfo.list
                initRoleList(pageInfo);
                //2.生成 分页导航栏
                initRoleNav(pageInfo);
            }
        });
    }
    //=================================================================
    // 生成 表格的数据
    function initRoleList(pageInfo) {
        $.each(pageInfo.list,function (i) {
             $('<tr>\n' +
                 '<td>'+(++i)+'</td>\n' +
                 '<td><input id="'+ this.id +'" type="checkbox"></td>\n' +
                 '<td>'+this.name+'</td>\n' +
                 '<td>\n' +
                 '<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\n' +
                 '<button id="'+this.id+'" type="button" class="btn btn-primary btn-xs showUpdateRoleModalBtn"><i class=" glyphicon glyphicon-pencil"></i></button>\n' +
                 '<button id="'+this.id+'" type="button" class="btn btn-danger btn-xs delRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\n' +
                 '</td>\n' +
                 '</tr>').appendTo("tbody");
        })

        //================删除单击事件
        //在role集合遍历显示完成之后绑定单击事件
        $("tbody .delRoleBtn").click(function () {
            var roleId = this.id;//获取删除按钮所在行的角色id
            //发起异步请求交给后台删除
            $.get("${PATH}/role/delRole" , {id:roleId} , function (data) {
                if(data=="ok"){
                    //删除成功
                    layer.msg("删除成功");
                    //刷新当前页面
                    initRoleTable(page);
                }
            });
        });
    }
    //==============================================================
    //解析 生成 分页导航栏的 代码
    function initRoleNav(pageInfo) {
         // 上一页
        if(pageInfo.isFirstPage){
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }else{
            //不是第一页 可以点击
            $('<li><a pageNum = "'+(pageInfo.pageNum-1)+'" class="navA" href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }

        // 中间页
        $.each(pageInfo.navigatepageNums,function () {
            // this 代表正在遍历的 代码
            if(this==pageInfo.pageNum){
                $('<li class="active"><a href="javascript:void(0);">'+this+'<span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul.pagination");
            }else{
                $('<li><a pageNum = "'+this+'" class="navA" href="javascript:void(0);">'+this+'</a></li>').appendTo("tfoot ul.pagination");
            }
        });
        // 最后一页
        if(pageInfo.isLastPage){
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }else{
            //不是最后一页 可以点击
            $('<li><a pageNum = "'+(pageInfo.pageNum+1)+'" class="navA"href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }

    }

    //给 a标签 绑定点击事件
    // 动态委派 事件
    //1 要动态绑定的事件 2.事件类型 3.事件处理函数
    $("tfoot ul").delegate(".navA","click",function () {
       //   alert("hehheheheheh");
        // this 代表 被点击的页面 的超链接
         var pageNum = $(this).attr("pageNum");
         var condition = $("#contitionInput").val();
         // 点击 分页 查询
         initRoleTable(pageNum,condition);
    });

</script>
</body>
</html>

