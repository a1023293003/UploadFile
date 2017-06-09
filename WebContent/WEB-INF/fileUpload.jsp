<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件上传</title>
</head>
<%
	List<String> titles = (List<String>) request.getAttribute("titles");
	if(titles == null || titles.size() <= 0) {
		request.setAttribute("message", "暂时没有什么作业需要提交");
		request.getRequestDispatcher("alert.jsp").forward(request, response);
		return;
	}
%>
<body>
	<div class="imgContainer">
		<img src="/UploadFileSystem/img/小埋.jpg" class="img-circle">
	</div>
	<h3>14软件2班作业提交 beta v0.1</h3>
	<div style="width: 445px; height: 500px; margin: auto; padding: 10px 0;">
		<select class="form-control" name="title" id="titles">
		<%
			for(String title : titles) {
			%>
				<option value="<%= title %>"><%= title %></option>
			<%
			}	
		%>
		</select>
		<br/>
	    <div class="input-group">
	        <span class="input-group-addon"></span>
	        <input type="text" class="form-control" placeholder="请输入学号" id="id" />
	    </div>
	    <br/>
	    <div class="input-group">
	        <span class="input-group-addon"></span>
	        <input type="text" class="form-control" placeholder="请输入姓名" id="name" />
	    </div>
	    <br/>
	    <div class="input-group" style="display: none;">
	        <input type="file" class="form-control" id="file" accept=".zip, .rar" />
	    </div>
		<div class="input-group">
			<span class="input-group-btn">
				<button class="btn btn-default" type="button" onclick="selectFile()">
					<span class="glyphicon glyphicon-folder-open" style="height: 100%;"></span> Browse
				</button>
			</span>
			<input type="text" class="form-control" id="filePath" onclick="selectFile()" readonly>
		</div><!-- /input-group -->
	    <br/>
	    <button type="button" class="btn btn-primary" onclick="upload()" id="submit" style="width: 100%;"> 上传 </button>
	    <br/>
	    <div id="result" style="color: red;"></div>
	    <br />
		<p>
			请把你的文件压缩成zip或者rar格式,并限制在5MB以内.
		    <br>把服务器的带宽留给其他同学上传
		    <br>尽量避免上传无关的工程文件
		    <br>有疑问请联系学委
		</p>
		<p>
			<a href="https://github.com/a1023293003/UploadFile">本站源码</a>
		</p>
	</div>
    <!-- 模态框（Modal） -->
	<div class="modal fade" id="upload-progress-bar" tabindex="-1" role="dialog" aria-labelledby="uploadProgressBarLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="modalLabel">
						正在上传...
					</h4>
				</div>
				<div class="modal-body col-sm-12">
					<div class="progress">
						<div id="progress-bar" class="progress-bar progress-bar-info progress-bar-striped active" style="width: 0%;">
							<div class="progress-value">0%</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</body>
<link rel="stylesheet" href="/UploadFileSystem/css/bootstrap.min.css">
<link rel="stylesheet" href="/UploadFileSystem/css/progress-bar.css">
<link rel="stylesheet" href="/UploadFileSystem/css/upload.css">
<script src="/UploadFileSystem/js/jquery-3.2.1.min.js"></script>
<script src="/UploadFileSystem/js/bootstrap.min.js"></script>
<script src="/UploadFileSystem/js/progress-bar.js"></script>
<script src="/UploadFileSystem/js/upload.js"></script>
</html>