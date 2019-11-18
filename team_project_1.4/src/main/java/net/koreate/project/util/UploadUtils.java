package net.koreate.project.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtils {
	
	ServletContext context;
	
	String uploadPath;
	
	private static UploadUtils utils;
	
	private UploadUtils() {}
	
	private UploadUtils(ServletContext context) {
		this.context = context;
		createUploadPath();
	}
	
	public static UploadUtils getInstance(ServletContext context) {
		if(utils == null) {
			utils = new UploadUtils(context);
		}
		return utils;
	}
	
	public void createUploadPath() {
		//		\\upload
		uploadPath = context.getRealPath("/upload");
		File file = new File(uploadPath);
		if(!file.exists()) {
			System.out.println(uploadPath+"경로 생성");
			file.mkdirs();
		}
	}
	
	// 파일 업로드 후 업로드된 파일명 반환
	public List<String> uploadFile(MultipartFile[] files) throws IOException {
		List<String> fileList = new ArrayList<>();

		for (MultipartFile file : files) {
			String fileName = uploadFile(file);
			System.out.println(fileName);
			fileList.add(fileName);
		}

		System.out.println("fileList : " + fileList.size());
		return fileList;
	}

	public String uploadFile(MultipartFile file) throws IOException {
		String originalName = file.getOriginalFilename();
		byte[] fileData = file.getBytes();
		String uploadFileName = "";

		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString().replace("-", "") + "_" + originalName;

		File f = new File(uploadPath + calcPath(), savedName);

		FileCopyUtils.copy(fileData, f);

		uploadFileName = makeFileUploadName(calcPath(), savedName);

		return uploadFileName;
	}

	public String makeFileUploadName(String calcPath, String savedName) throws IOException {

		String formatName = savedName.substring(savedName.lastIndexOf(".") + 1);

		String thumnail = "";
		if (MediaUtils.getMediaType(formatName) != null) {
			System.out.println("이미지 파일 업로드");

			BufferedImage fileImage = ImageIO.read(new File(uploadPath + calcPath, savedName));

		/*	BufferedImage sourceImage = Scalr.resize(fileImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, 300);*/
			BufferedImage sourceImage = Scalr.resize(fileImage, 200, 200);

			thumnail = uploadPath + calcPath + File.separator + "s_" + savedName;

			File file = new File(thumnail);
			ImageIO.write(sourceImage, formatName, file);
		} else {
			thumnail = uploadPath + calcPath + File.separator + savedName;
		}
		thumnail = thumnail.substring(uploadPath.length()).replace(File.separatorChar, '/');
		return thumnail;
	}

	// 날짜별 폴더트리 계산
	public String calcPath() {
		String datePath = "";
		// 현재 시간에 대한 정보를 가진 객체
		Calendar cal = Calendar.getInstance();

		String year = File.separator + cal.get(Calendar.YEAR);
		String month = year + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		// 1 01
		// 10 10
		datePath = month + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		System.out.println(datePath);
		mkDir(year, month, datePath);
		return datePath;
	}

	// 날짜별 폴더트리 생성
	public void mkDir(String... path) {
		String finalPath = uploadPath + path[path.length - 1];
		System.out.println(finalPath);
		if (new File(finalPath).exists()) {
			return;
		}

		for (String p : path) {
			File file = new File(uploadPath + p);
			if (!file.exists()) {
				file.mkdir();
			}
		}
	}
	
	public String deleteFile(String fileName) {

		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		if (mType != null) {
			System.out.println("썸네일 삭제");
			String name = fileName.replace("s_", "");
			new File(uploadPath + (name).replace('/', File.separatorChar)).delete();
		}

		new File(uploadPath + (fileName).replace('/', File.separatorChar)).delete();

		System.out.println("삭제완료");

		return "DELETED";
	}

	public String deleteAllFiles(String[] files) {
		for (String file : files) {
			String format = file.substring(file.lastIndexOf(".") + 1);

			if (MediaUtils.getMediaType(format) != null) {
				// 이미지
				String name = file.replace("s_", "");
				new File(uploadPath + (name).replace('/', File.separatorChar)).delete();
			}

			new File(uploadPath + (file).replace('/', File.separatorChar)).delete();

		}

		return "DELETED";
	}

	
	public byte[] getBytes(String fileName) throws IOException{
		System.out.println("fileName : "+fileName);
		InputStream in = null;
		String path = uploadPath+(fileName).replace('/', File.separatorChar);
		byte[] fileData = null;
		try {
			in = new FileInputStream(path);
			fileData = IOUtils.toByteArray(in);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			in.close();
		}
		return fileData;
	}
	
	public HttpHeaders getHeader(String fileName) {
		HttpHeaders header = null;
		try {

			header = new HttpHeaders();

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);

			MediaType mType = MediaUtils.getMediaType(formatName);

			if (mType != null) {
				header.setContentType(mType);
			} else {

				fileName = fileName.substring(fileName.indexOf("_") + 1);
				header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				header.add("content-disposition",
						"attachment;fileName=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return header;
	}

	public HttpHeaders getHeaders(String fileName) {
		HttpHeaders header = new HttpHeaders();
		
		try {
			fileName = fileName.substring(fileName.indexOf("_")+1);
			header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			header.add("content-disposition", "attachment;fileName=\""+new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\""); //브라우저가 인식할수있는 인코딩으로 바꿔줌 \뒤에"는 문자열로 인식
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return header;
	}
	
	public String deleteFileA(String fileName) {
		System.out.println(uploadPath);
		new File(uploadPath+(fileName).replace('/', File.separatorChar)).delete();
		System.out.println("삭제 완료");
		
		return "DELETED";
	}
	
	public String deleteAllFilesA(String[] files) {
		for(String file : files) {
			new File(uploadPath+(file).replace('/', File.separatorChar)).delete();
		}
		return "DELETED";
	}

}
