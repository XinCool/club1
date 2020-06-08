<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询管理员</title>
<link href="${pageContext.request.contextPath }/js/layui/css/layui.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/layui/layui.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.7.2.js"></script>
<script type="text/javascript">
    function delConfirm() {
        var r = confirm("确认删除？");
        if (r == true) {
            return true;
        } else {
            return false;
        }
    }
</script>
<script type="text/javascript">
    //滚动时保存滚动位置
    $(window).scroll(function() {
        if ($(document).scrollTop() != 0) {
            localStorage.setItem("offsetTop", $(window).scrollTop());
        }
    });
    //onload时，取出并滚动到上次保存位置
    window.onload = function() {
        var offset = localStorage.getItem("offsetTop");
        $(document).scrollTop(offset);
    };
</script>
</head>
<body>
    <c:if test="${sessionScope.admin==null}">
        <script type="text/javascript">
           top.location="${pageContext.request.contextPath}/admin/admin_login.jsp?req=fail";
        </script>
    </c:if>
	<c:if test="${result != null}">
		<script type="text/javascript">
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.msg("${result} ");
            });
        </script>
	</c:if>
	<c:if test="${update != null}">
		<script type="text/javascript">
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.msg('<%=session.getAttribute("update")%>');
			});
		</script>
		<%
			session.removeAttribute("update");
		%>
	</c:if>
	
	<!-- 按条件查询 -->
	<div style="margin:0px auto;background-color:rgba(57, 61, 73, 0.1);height:130px;">
	   <!-- <h2
        style="padding-top: 20px;padding-bottom:10px;margin-left: 420px; align: center; color: rgba(57, 61, 73, 0.7);">
        <span style="align: center; color: rgba(35, 38, 46, 0.7)">
            管理员账号信息</span>
    </h2> -->
		<form class="layui-form" method="post" name="form1" style="margin-left:70px;padding-top: 20px;"
			action="${pageContext.request.contextPath }/admin/selAdmins">
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">管理员ID:</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="id" class="layui-input"
							lay-verify="numoro" />
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label">姓名:</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="name" autocomplete="off" value=""
							class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">邮箱:</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="email" autocomplete="off" value=""
							class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">注册时间:</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" id="time" name="time" autocomplete="off"
							value="" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">电话:</label>
					<div class="layui-input-inline" style="width: 150px;">
						<input type="text" name="phone" autocomplete="off" value=""
							class="layui-input" lay-verify="numoro" lay-reqText="">
					</div>
				</div>

				<div class="layui-inline">
					<div class="layui-input-block" style="width: 170px;">
						<button class="layui-btn" lay-submit lay-filter="setId"><i class="layui-icon">&#xe615;</i>查询</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- 条件查询没有结果不显示 -->
	<c:if test="${ curPage.data!=null }">
		<!-- 给表格固定大小 -->
		<div style="">
			<table class="layui-table">
				<colgroup>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col >
					<col >
				</colgroup>
				<thead>
					<tr>
						<!--  style="background-color:rgba(57,61,73,0.2);color:white" -->
						<th>账号</th>
						<th>名称</th>
						<th>密码</th>
						<th>性别</th>
						<th>电话</th>
						<th>邮箱</th>
						<th>注册时间</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${curPage.data }" var="i">
						<tr>
							<td>${i.id }</td>
							<td>${i.name }</td>
							<td>${i.password }</td>
							<td><c:if test="${i.sex==0 }">男</c:if> <c:if
									test="${i.sex==1 }">女</c:if></td>
							<td>${i.phone }</td>
							<td>${i.email }</td>
							<td>${i.time }</td>
							<td><a class="layui-btn layui-btn-radius layui-btn-normal"
								href="${pageContext.request.contextPath }/admin/preUpdAdmin?id=${i.id }"><i class="layui-icon layui-icon-edit">编辑</i></a>
								<a class="layui-btn layui-btn-radius"
								href="${pageContext.request.contextPath }/admin/delAdmin?id=${i.id }"
								onclick="return delConfirm()"><i class="layui-icon">&#xe640;删除</i></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!--  分页 -->
		<div style="margin: 10px 0px 10px 380px">
			<!-- 首页 -->
			<c:if test="${curPage.curPage==1}">
				<a class="layui-btn layui-btn-primary"
					style="border: solid 1px rgba(57, 61, 73, 0.3); color: rgba(57, 61, 73, 0.3);"
					href="javascipt:void(0);">首页</a>
			</c:if>
			<c:if test="${curPage.curPage!=1}">
				<a class="layui-btn"
					href="${pageContext.request.contextPath }/admin/selAdminByPage?curPage=1">首页</a>
			</c:if>
			<!-- 上一页 -->
			<c:if test="${curPage.curPage<=1}">
				<a class="layui-btn layui-btn-primary"
					style="border: solid 1px rgba(57, 61, 73, 0.3); color: rgba(57, 61, 73, 0.3);"
					href="javascipt:void(0);"><i class="layui-icon layui-icon-left"></i></a>
			</c:if>
			<c:if
				test="${(curPage.curPage>1)&&(curPage.curPage<=curPage.totalPage)}">
				<a class="layui-btn"
					href="${pageContext.request.contextPath }/admin/selAdminByPage?curPage=${curPage.curPage-1 }"><i class="layui-icon layui-icon-left"></i></a>
			</c:if>
			<!-- 下一页 -->
			<c:if test="${curPage.curPage==curPage.totalPage}">
				<a
					style="border: solid 1px rgba(57, 61, 73, 0.3); color: rgba(57, 61, 73, 0.3);"
					class="layui-btn layui-btn-primary" href="javascipt:void(0);"><i class="layui-icon">&#xe602;</i></a>
			</c:if>
			<c:if
				test="${(curPage.curPage>=1) && (curPage.curPage<curPage.totalPage)}">
				<a class="layui-btn"
					href="${pageContext.request.contextPath }/admin/selAdminByPage?curPage=${curPage.curPage+1 }"><i class="layui-icon">&#xe602;</i></a>
			</c:if>
			<!-- 尾页 -->
			<c:if test="${curPage.curPage==curPage.totalPage}">
				<a
					style="border: solid 1px rgba(57, 61, 73, 0.3); color: rgba(57, 61, 73, 0.3);"
					class="layui-btn layui-btn-primary" href="javascipt:void(0);">尾页</a>
			</c:if>
			<c:if test="${curPage.curPage!=curPage.totalPage}">
				<a class="layui-btn"
					href="${pageContext.request.contextPath }/admin/selAdminByPage?curPage=${curPage.totalPage }">尾页</a>
			</c:if>
		</div>
	</c:if>
	<script>
		//注意：导航 依赖 element 模块，否则无法进行功能性操作
		layui.use([ 'element', 'form', 'laydate' ], function() {
			var element = layui.element;
			var form = layui.form;
			var laydate = layui.laydate;
			laydate.render({
				elem : '#time' //指定元素
			//,value:new Date() //默认值
			});
			//监听提交
			form.on('submit(setId)', function(data) {
				//alert("sss");
				//alert(document.form1.id.value);
				if (document.form1.id.value == ''
						|| document.form1.id.value == 0) {
					document.form1.id.value = 0;
				}
				return true;
			});
			form.verify({
				name : [ /^[a-zA-Z0-9]{3,20}$/, '用户名组成为字母3-20位' ],
				sid : [ /^[0-9]{10}$/, '学号组成为10位数字' ],
				password : [ /^[a-zA-Z0-9]{6,20}$/, '密码组成为字母或数字,6-20位' ],
				numoro : [ /^[0-9]{0,}$/, '组成为数字' ],
				age : [ /^[1]?[0-9]{1,2}$/, '年龄为0-99' ]

			})
		});
	</script>
</body>
</html>