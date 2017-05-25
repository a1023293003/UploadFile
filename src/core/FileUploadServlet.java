package core;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@SuppressWarnings("serial")
@WebServlet(name="FileUploadServlet", urlPatterns={"/upload.html"})
@MultipartConfig(maxRequestSize=50 * 1024 * 1024) // 50M
public class FileUploadServlet extends HttpServlet{
	
	/**
	 * slf4j日志配置
	 */
	private static final Logger _LOG = LoggerFactory.getLogger(FileUploadServlet.class);
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message = this.uploadFile(request);
		response.getWriter().print("<script>alert(\"" + message + "\");</script>");
		response.setHeader("refresh", "0; URL=fileUpload.jsp");
	}
	
	private String uploadFile(HttpServletRequest request) {
		String uploadDir = this.getServletContext().getRealPath("/upload");
		Part filePart;
		String message;
		try {
			// 获取文件块
			filePart = request.getPart("fileName");
		} catch(IOException ioe) {
			message = "an I/O error occurs!";
			_LOG.error("IO异常:" + ioe.getMessage());
			return message;
		} catch(IllegalStateException ise) {
			message = "size limits are exceeded!";
			_LOG.error("上传文件过大:" + ise.getMessage());
			return message;
		} catch(ServletException se) {
			message = "the request is not multipart/form-data!";
			_LOG.error("请求异常:" + se.getMessage());
			return message;
		}
		// form-data; name="fileName"; filename="httpcomponents-client-4.5.3-src.zip"
		String header = filePart.getHeader("content-disposition");
		// 截取文件名
		String fileName = header.substring(header.lastIndexOf("=") + 2, header.length() - 1);
		// System.getProperty("file.separator")当前系统的文件分割符
		String uploadPath = uploadDir + System.getProperty("file.separator") + fileName;
		System.out.println(uploadPath);
		return "success";
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("fileUpload.jsp");
	}
	
}
