package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class BoardRestController {
	@Autowired
	private BoardService bService;
	
	 @GetMapping(value="board/list_vue.do",produces = "text/plain;charset=UTF-8")
	 public String board_list(int page, Integer type) throws Exception
	 {
		  int rowSize=10;
		  int start=(rowSize*page)-(rowSize-1);
		  int end=rowSize*page;
		  
		  List<BoardVO> list=bService.boardListData(start, end);
		  int totalpage=bService.boardTotalPage();
		  
		  final int BLOCK=10;
		   int startPage=((page-1)/BLOCK*BLOCK)+1;
		   int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		   
		   if(endPage>totalpage)
			   endPage=totalpage;
		   if(type==null)
			   type=0;
		   List<BoardVO> cList=bService.boardTypeListData(type, start, end);  
				   
		  Map map=new HashMap();
		  map.put("list", list);
		  map.put("cList", cList);
		  map.put("totalpage", totalpage);
		  map.put("curpage",page);
		  map.put("startPage", startPage);
		  map.put("endPage", endPage);
		   
		   ObjectMapper mapper=new ObjectMapper();
		   String json=mapper.writeValueAsString(map);
		   
		   return json;
	 }
	 
	 @GetMapping(value="board/detail_vue.do",produces = "text/plain;charset=UTF-8")
	  public String board_detail(int bno) throws Exception
	  {
		  BoardVO vo=bService.boardDetailData(bno);
		  ObjectMapper mapper=new ObjectMapper();
		  String json=mapper.writeValueAsString(vo);
		  return json;
	  }
	 @PostMapping(value = "board/get_nickname.do", produces = "text/plain;charset=UTF-8")
	 public String getNickname(HttpServletRequest request) {
	     HttpSession session = request.getSession();
	     String id = (String) session.getAttribute("id");
	     if (id != null) {
	         String nickname = bService.boardNickname(id);
	         return nickname;  // 닉네임 반환
	     }
	     return "";  // ID가 없는 경우 빈 문자열 반환
	 }
	 @PostMapping(value="board/insert_vue.do",produces = "text/plain;charset=UTF-8")
	  public String board_insert(@ModelAttribute BoardVO vo, HttpServletRequest request)
	  {
		  String result="";
		  try
		  {
			 String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
			 File dir=new File(path);
			 if(!dir.exists())
			 {
				 dir.mkdir();
			 }
			 path=path.replace("\\", File.separator);
			 String fileUrlBase = "http://localhost:8080/WineFineProject/upload/";
			 
			 System.out.println(path);
			 
			 List<MultipartFile> list=vo.getFiles();
			 if(list==null || list.isEmpty()) // 업로드가 없는 경우
			 {
				 vo.setFilename("");
				 vo.setFilesize("");
				 vo.setFilecount(0);
			 }
			 else // 업로드가 있는 상태 
			 {
				 String filename="";
				 String filesize="";
				 StringBuilder contentWithImages = new StringBuilder(vo.getContent()); // 기존 콘텐츠 저장
				 for(MultipartFile mf:list)
				 {
					 String name=mf.getOriginalFilename();
					 File file=new File(path+name);
					 mf.transferTo(file); // 업로드 
					 // 이미지 URL 추가
					 String imageUrl = fileUrlBase + name; // 저장된 파일의 경로
		             contentWithImages.append("<img src='").append(imageUrl).append("' alt='Uploaded Image' />"); // 이미지 태그 추가
					 filename+=name+",";
					 filesize+=file.length()+",";
				 }
				 
				 filename=filename.substring(0,filename.lastIndexOf(","));
				 filesize=filesize.substring(0,filesize.lastIndexOf(","));
				 vo.setFilecount(list.size());
				 vo.setFilename(filename);
				 vo.setFilesize(filesize);
				 vo.setContent(contentWithImages.toString()); // 수정된 콘텐츠 설정
			 }
			 bService.boardInsert(vo);
			 result="yes";  
		  }catch(Exception ex)
		  {
			  result=ex.getMessage();
		  }
		  return result;
	  }
	 @GetMapping(value="board/download.do",produces = "text/plain;charset=UTF-8")
	  public void databoard_download(String fn,HttpServletResponse response,
			  HttpServletRequest request)
	  {
		  try
		  {
			  String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
			  path=path.replace("\\", File.separator);
			  File file=new File(path+fn);
			  
			  response.setHeader("Content-Disposition", "attachment;filename="
					       +URLEncoder.encode(fn, "UTF-8"));
			  response.setContentLength((int)file.length());
			  
			  BufferedInputStream bis=
					  new BufferedInputStream(new FileInputStream(file));
			   
			  BufferedOutputStream bos=
					  new BufferedOutputStream(response.getOutputStream());
			  
			  int i=0;
			  byte[] buffer=new byte[1024];
			  while((i=bis.read(buffer, 0, 1024))!=-1)
			  {
				  bos.write(buffer, 0, i);
			  }
			  bis.close();
			  bos.close();
		  }catch(Exception ex) {}
	  }
	 @GetMapping(value="board/update_vue.do",produces = "text/plain;charset=UTF-8")
	  public String databoard_update(Integer bno) throws Exception
	  {
		  BoardVO vo=bService.boardUpdateData(bno);
		  ObjectMapper mapper=new ObjectMapper();
		  String json=mapper.writeValueAsString(vo);
		  return json;
	  }
	  @PostMapping(value="board/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
	  public String board_update_ok(BoardVO vo,HttpServletRequest request)
	  {
		  String result="";
		  try
		  {
			  // 수정전에 파일 정보 읽기 
			  BoardVO fvo=bService.boardFileInfoData(vo.getBno());
			  String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
			  path=path.replace("\\", File.separator);
			  String fileUrlBase = "http://localhost:8080/WineFineProject/upload/";
			  if(fvo.getFilecount()>0)
			  {
				  StringTokenizer st=new StringTokenizer(fvo.getFilename(),",");
				  while(st.hasMoreTokens())
				  {
					  File file=new File(path+st.nextToken());
					  file.delete();
				  }
			  }
			  List<MultipartFile> list=vo.getFiles();
			  if(list==null || list.isEmpty())
			  {
				  vo.setFilename("");
				  vo.setFilesize("");
				  vo.setFilecount(0);
			  }
			  else
			  {
				  StringBuilder filenames = new StringBuilder();
		          StringBuilder filesizes = new StringBuilder();
				  StringBuilder contentWithImages = new StringBuilder(vo.getContent());
				  for(MultipartFile mf:list)
				  {
					  String name=mf.getOriginalFilename();
					  File file=new File(path+name);
					  mf.transferTo(file);// 파일 업로드 
					// 이미지 URL 추가
						 String imageUrl = fileUrlBase + name; // 저장된 파일의 경로
			             contentWithImages.append("<img src='").append(imageUrl).append("' alt='Uploaded Image' />"); // 이미지 태그 추가
		
			             filenames.append(name).append(",");
			             filesizes.append(file.length()).append(",");
				  }
				  
				  filenames.setLength(filenames.length() - 1);
				  filesizes.setLength(filesizes.length() - 1);
				  vo.setFilename(filenames.toString());
				  vo.setFilesize(filesizes.toString());
				  vo.setFilecount(list.size());
				  vo.setContent(contentWithImages.toString()); // 수정된 콘텐츠 설정
			  }
			  result=bService.boardUpdate(vo);
		  }catch(Exception ex) {ex.printStackTrace();}
		  return result;
	  }
}
