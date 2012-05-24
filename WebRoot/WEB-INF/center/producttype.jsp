<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/share/taglib.jsp"%>

<script>
	$(function() {
		$('#proform').hide();
		$('#pro').datagrid({
			title : '',
			iconCls : 'icon-save',
			height : 620,
			nowrap : false,
			striped : true,
			collapsible : true,
			url : '/unismNet/control/product/list.action',
			sortName : 'name',
			sortOrder : 'desc',
			remoteSort : false,
			idField : '编号',
			pagination : true,
			rownumbers : true,
			frozenColumns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				title : '编号',
				field : 'typeid',
				width : 250,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '基本信息',
				colspan : 3
			}, {
				field : 'opt',
				title : '操作',
				width : 100,
				align : 'center',
				rowspan : 2,
				formatter : function(value, rec) {
					return '<span style="color:red">编辑 删除</span>';
				}
			} ], [ {
				field : 'name',
				title : '产品名称',
				width : 120
			}, {
				field : 'note',
				title : '产品描述',
				width : 220,
				rowspan : 2,
				sortable : true,
				sorter : function(a, b) {
					return (a > b ? 1 : -1);
				}
			}, {
				field : 'parent',
				title : '父级产品',
				width : 150,
				rowspan : 2
			} ] ],

			toolbar : [ {
				id : 'btnadd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					$('#btnsave').linkbutton('enable');
					$('#add').window('open');
					$('#proform').show();
					$('#proform').form('clear');
					$('#proform').appendTo('#aa');
				}
			}, '-', {
				id : 'btnedit',
				text : '修改',
				iconCls : 'icon-edit',
				handler : getSelect
			}, '-', {
				id : 'btncancel',
				text : '删除',
				iconCls : 'icon-cancel',
				handler : del
			}, '-', {
				id : 'btnsearch',
				text : '查询',
				iconCls : 'icon-search',
				handler : function() {
					$('#btnsearch').linkbutton('enable');
					$('#query').window('open');
				}
			}, '-', {
				id : 'btnsave',
				text : '保存',
				disabled : false,
				iconCls : 'icon-save',
				handler : function() {
					$('#btnsave').linkbutton('disable');
					alert('save')
				}
			} ]
		});
		var p = $('#pro').datagrid('getPager');
		$(p).pagination({
			pageSize : 10,//每页显示的记录条数，默认为10  
			pageList : [ 5, 10, 15, 20, 25, 30 ],//可以设置每页记录条数的列表  
			beforePageText : '第',//页数文本框前显示的汉字  
			afterPageText : "共{pages}页",
			displayMsg : "共{total}条记录"
		});
	});
	function resize() {
		$('#pro').datagrid('resize', {
			height : 800
		});
	}

	function displayMsg() {
		$('#pro').datagrid('getPager').pagination({
			displayMsg : '当前显示从{from}到{to}共{total}记录'
		});
	}
	function close1() {
		$('#add').window('close');
	}
	function close2() {
		$('#edit').window('close');
	}
	function add() {
		$('#proform').form('submit', {
			url : 'easyAdd.action',
			onSubmit : function() {
				return $('#proform').form('validate');
			},
			success : function() {
				close1();
			}
		});
		$.messager.alert('add', '添加信息成功!!!', 'info', function() {
			$('#pro').datagrid({
				url : 'easyAction.action',
				loadMsg : '更新数据中......'
			});
			displayMsg();
		});
	}
	var id;
	function getSelect() {
		var select = $('#pro').datagrid('getSelected');
		if (select) {
			$('#edit').window('open');
			$('#proform').show();
			$('#proform').appendTo('#ee');
			$('#name').val(select.name);
			$('#age').val(select.age);
			$('#sex').val(select.sex);
			$('#birthday').val(select.birthday);
			$('#className').val(select.className);
			id = select.id;
		} else {
			$.messager.alert('warning', '请选择一行数据', 'warning');
		}
	}
	function edit() {
		$('#proform').form('submit', {
			url : 'easyUpdate.action?id=' + id,
			onSubmit : function() {
				return $('#proform').form('validate');
			},
			success : function() {
				$.messager.alert('edit', '修改信息成功!!!', 'info');
				close2();
			}
		});
		$('#pro').datagrid({
			url : 'easyAction.action',
			loadMsg : '更新数据......'
		});

	}
	function del() {
		var selected = $('#pro').datagrid('getSelected');
		if (selected) {
			$.messager.confirm('warning', '确认删除么?', function(id) {
				if (id) {
					id = selected.id;
					$.ajax({
						type : "POST",
						url : "easyDel.action",
						data : "id=" + id,
						dataType : "xml",
						success : function callback() {
						}
					});
					$('#pro').datagrid('reload');
				}
			});
		} else {
			$.messager.alert('warning', '请选择一行数据', 'warning');
		}
	}
	function query() {
		var queryParams = $('#pro').datagrid('options').queryParams;
		queryParams.queryWord = $('#qq').val();
		$('#pro').datagrid({
			url : 'easyQuery.action'
		});
		displayMsg();
		$('#query').window('close');
	}
</script>

<table id="pro"></table>

<form id="proform" method="post">
	<div>
		姓名:<input class="easyui-validatebox" type="text" id="name" name="name"
			required="true"></input>
	</div>
	<div>
		年龄:<input class="easyui-numberbox" type="text" id="age" name="age"
			required="true"></input>
	</div>
	<div>
		性别:<input class="easyui-validatebox" type="text" id="sex" name="sex"
			required="true"></input>
	</div>
	<div>
		出生:<input class="easyui-validatebox" type="text" id="birthday"
			name="birthday" required="true" />
	</div>
	<div>
		班级:<input class="easyui-validatebox" type="text" id="className"
			name="className" required="true" />
	</div>
</form>

<div id="add" class="easyui-window" title="添加"
	style="padding: 10px;width: 300;height:200;" iconCls="icon-add"
	closed="true" maximizable="false" minimizable="false"
	collapsible="false">
	<div id="aa"></div>
	<a class="easyui-linkbutton" iconCls="icon-ok"
		href="javascript:void(0)" onclick="add()">添加</a> <a
		class="easyui-linkbutton" iconCls="icon-cancel"
		href="javascript:void(0)" onclick="close1()">取消</a>
</div>
<div id="edit" class="easyui-window" title="修改"
	style="padding: 10px;width: 300;height: 200;" iconCls="icon-edit"
	closed="true" maximizable="false" minimizable="false"
	collapsible="false">
	<div id="ee"></div>
	<a class="easyui-linkbutton" iconCls="icon-ok"
		href="javascript:void(0)" onclick="edit()">修改</a> <a
		class="easyui-linkbutton" iconCls="icon-cancel"
		href="javascript:void(0)" onclick="close2()">取消</a>
</div>
<div id="query" class="easyui-window" title="查询"
	style="padding: 10px;width: 360px;height:100;" iconCls="icon-search"
	closed="true" maximizable="false" minimizable="false"
	collapsible="false">
	<div>
		<table>
			<tr>
				<td>学生学号:</td>
				<td><input type="text" name="id" id="qq"
					class="easyui-numberbox" required="true">
				</td>
				<td><a class="easyui-linkbutton" iconCls="icon-search"
					href="javascript:void(0);" onclick="query()">查询</a>
				</td>
			</tr>
		</table>
	</div>
</div>