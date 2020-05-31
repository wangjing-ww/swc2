<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/5/21
  Time: 15:40
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
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%--  新增菜单的模态框 --%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="pid" />
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name1">
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input name="icon" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<%--  更新菜单的模态框--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel1">更新菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <%-- 隐藏域 数据  给后台获取数据--%>
                    <%-- 设置 name 属性值  回显数据--%>
                    <input type="hidden" name="id" />
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name11">
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input name="icon" type="text" class="form-control" id="recipient-name111">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/include/base_js.jsp"%>>

<script type="text/javascript">
//********************添加菜单*******************************************
  // 给提交的模态框 绑定单击事件
   $("#addMenuModal #addMenuBtn").click(function () {
           $.ajax({
               type: "post",
               data:$("#addMenuModal form").serialize(),
               url:"${PATH}/menu/addMenu",
               success:function (data) {
                   if (data=="ok"){
                       layer.msg("添加成功");

                       $("#addMenuModal").modal("toggle");
                       // 刷新
                       initMenuTree();
                   }
               }
           });
   });
    function addMenu(pid) {
         // layer.alert("addMenu,id:"+pid);
          $("#addMenuModal form [name='pid']").val(pid);
          $("#addMenuModal").modal("toggle");
    }
//*************************删除功能******************************************

    function deleteMenu(id) {
       // layer.alert("deleteMenu,id:"+id);
        layer.confirm("您确定要删除吗？",{icon: 3,title:"删除提示"},
            function (index) {//index 代表当前弹层的索引值
            $.ajax({
                type:"get",
                data:{"id":id},
                url:"${PATH}/menu/deleteMenu",
                success:function (data) {
                    if(data=="ok"){
                        layer.close(index);
                        layer.msg("删除成功");
                        initMenuTree();
                    }
                }
            });

        })
    }
//*********************************更新操作**********************************************
   /*1 点击更新 按钮 再模态框中回显要更新的数据
   * 2 修改跟新数据
   * 3 给模态框的提交按钮绑定单击事件
   * 4 关闭模态框 并且刷新页面数据
   * 注意 表单提交 使用post
   * */
    function updateMenu(id) {
        layer.alert("updateMenu,id:"+id);
        $.ajax({
            type:"get",
            data:{"id":id},
            url:"${PATH}/menu/getMenu",
            success:function (menu) {
                // 回显到 模态框
                $("#updateMenuModal form [name='id']").val(menu.id);
                $("#updateMenuModal form [name='name']").val(menu.name);
                $("#updateMenuModal form [name='icon']").val(menu.icon);

                $("#updateMenuModal").modal("toggle");
            }
        });

    }

    // 给提交的 按钮 绑定 单击事件
   $("#updateMenuModal #updateMenuBtn").click(function () {
         $.ajax({
            type:"post",
            data:$("#updateMenuModal form").serialize(),
            url:"${PATH}/menu/updateMenu",
            success:function (data) {
                  if(data=="ok"){
                      $("#updateMenuModal").modal("toggle");
                      layer.msg("更新成功",{time:1000});
                      initMenuTree();
                  }
            }
         });
   });
/*************************************我是分割线***********************************************/
    /*创建 ztree的配置*/
    var settings = {
        view:{
            //显示按钮
            addHoverDom: function (treeId,treeNode) {
                var aObj = $("#" + treeNode.tId + "_a");
                aObj.attr("href", "javascript:;");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {//根节点
                    //href="javascript:void(0);" 取消 默认提交
                    // 添加
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {// 枝节点
                    // 修改啊
                    s += '<a  onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children==null||treeNode.children.length == 0) {//
                       //叶子节点
                        // 删除
                        s += '<a onclick="deleteMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    // 添加
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {// 字节的 叶子节点
                    s += '<a onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    s += '<a onclick="deleteMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },
            //移除按钮
            removeHoverDom: function (treeId,treeNode) {
                $("#btnGroup"+treeNode.tId).remove();
            },
            // 自定义ztree树每个标签创建的函数
              addDiyDom:function (treeId,treeNode) {
              //ztree树 没创建一个节点 都会调用一次方法
                // 并且 传入ztree树的id（ztreeDemo）正在调用当前方法的节点对象
                console.log(treeId);
                console.log(treeNode);
                //treeNode.tId//获取当前节点的id ，
                // 拼接_a 代表当前节点a标签的id， _span 代表显示当前节点名称的span标签id
                //移除正在调用当前方法的节点的图标span标签： tId+"_ico"
                $("#"+treeNode.tId +"_ico").remove();
                //在显示节点标题的span标签左边创建标签并
                // 设置上class属性值为当前节点的字体图标值
                $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                //获取当前节点的a标签，设置target属性值为空，避免跳转
                $("#"+treeNode.tId+"_a").prop("target","");
            }
        },
        data: {
            key: {
                url: "JackSon"//填写不存在的属性名，ztree就不会再节点a标签中设置href属性值
            },
            simpleData: {
                enable: true,
                pIdKey: "pid"//指定查询到的菜单数据  ztree自动识别父子菜单的属性名
            }
        }
    };
    /*准备 数据源*/
    var zNodes;
    initMenuTree();
     // 将初始化的 menu 显示 出来
     function initMenuTree(){
         $.ajax({
             type:"get",
             url:"${PATH}/menu/getMenus",
             success:function (menus) {
                 console.log(menus);
                 //在查询到集合菜单后 给menus设置父菜单
                 menus.push({id:0,name:"系统权限菜单",icon:"glyphicon glyphicon-heart"});
                 zNodes = menus;
                 var $ztreeObj = $.fn.zTree.init($("#treeDemo"), settings, zNodes);
                 //自动展开ztree所有的节点
                 $ztreeObj.expandAll(true);
             }
         });
     }
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

    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('菜单维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('菜单维护')").css("color" , "red");
</script>
</body>
</html>
