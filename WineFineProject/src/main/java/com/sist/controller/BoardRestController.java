package com.sist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
		   
		   for (BoardVO board : list) {
		        int replyCount = bService.boardReplyCount(board.getBno()); // 각 게시물의 bno로 댓글 수 가져오기
		        board.setReplycount(replyCount); 
		    }
		   
		   List<BoardVO> cList=bService.boardTypeListData(type, start, end);  
		   for (BoardVO board : cList) {
		        int replyCount = bService.boardReplyCount(board.getBno());
		        board.setCreplycount(replyCount); 
		    }
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
	  public String board_update(Integer bno) throws Exception
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
	  @GetMapping(value="board/delete_vue.do",produces = "text/plain;charset=UTF-8")
	  public String board_delete(int bno,HttpServletRequest request)
	  {
		  BoardVO vo=bService.boardFileInfoData(bno);
		  int count = bService.boardReplyCount(bno);
		  if(count>0)
		  {
		  bService.boardReplyAllDelete(bno);
		  }
		  String result=bService.boardDelete(bno);
		  // 파일삭제 
		  if(result.equals("yes"))
		  {
			  String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
			  path=path.replace("\\", File.separator);
			  if(vo.getFilecount()>0)// 파일이 존재시 
			  {
				  StringTokenizer st=new StringTokenizer(vo.getFilename(),",");
				  while(st.hasMoreTokens())// 파일명 만큼 
				  {
					  File file=new File(path+st.nextToken());
					  file.delete();// 파일 삭제 
				  }
			  }
		  }
		  return result;
	  }
	  // 댓글
	  public String boardReply_list(int bno) 
	   {
		   String json="";
		   try
		   {
			   List<BoardReplyVO> list=bService.boardReplyListData(bno);
			   int count=bService.boardReplyCount(bno);
			   Map map =new HashMap();
			   map.put("list", list);
			   map.put("count", count);
			   ObjectMapper mapper=new ObjectMapper();
			   json=mapper.writeValueAsString(map);
		   }catch(Exception ex) {}
		   return json;
	   }
	  
	  @GetMapping(value="board/reply_read_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reply_read(int bno)
	   {
		   return boardReply_list(bno);
	   }
	  
	  @PostMapping(value="board/reply_insert_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reply_insert(BoardReplyVO vo,HttpSession session) throws Exception
	   {
		  //String id=(String)session.getAttribute("id");
		  // String nickname=(String)session.getAttribute("nickname");
		  //vo.setId(id);
		  //vo.setNickame(nickname);
		   bService.boardReplyInsert(vo);
		   		   
		   return boardReply_list(vo.getBno());
	   }
	  
	  @PostMapping(value="board/reReply_insert_vue.do",produces = "text/plain;charset=UTF-8")
	  public String rereply_insert(BoardReplyVO vo, HttpSession session) throws Exception
	  {
		  //String id=(String)session.getAttribute("id");
		  // String nickname=(String)session.getAttribute("nickname");
		  //vo.setId(id);
		  //vo.setNickname(nickname);
		  int root=vo.getRoot();
		  int rereplycount = bService.boardReReplyCount(root);
		  if(rereplycount==0)
		  {
		  bService.boardReReplyInsert(vo);
		  }
		  return boardReply_list(vo.getBno());
	  }
	  
	  @GetMapping(value="board/reply_delete_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reply_delete(int bno, int brno)
	   {
		   bService.boardReplyDelete(brno);
		   return boardReply_list(bno);
	   }
	  
	   @PostMapping(value="board/reply_update_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reply_update(int bno, BoardReplyVO vo)
	   {
		   bService.boardReplyUpdate(vo);
		   return boardReply_list(bno);
	   }
	   
	   //noticeboard
	   @GetMapping(value="noticeboard/list_vue.do",produces = "text/plain;charset=UTF-8")
		 public String noticeboard_list(int page, Integer type) throws Exception
		 {
			  int rowSize=10;
			  int start=(rowSize*page)-(rowSize-1);
			  int end=rowSize*page;
			  
			  List<NoticeBoardVO> list=bService.noticeboardListData(start, end);
			  int totalpage=bService.noticeboardTotalPage();
			  
			  final int BLOCK=10;
			   int startPage=((page-1)/BLOCK*BLOCK)+1;
			   int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
			   
			   if(endPage>totalpage)
				   endPage=totalpage;
			   if(type==null)
				   type=0;
			   
			   List<NoticeBoardVO> cList=bService.noticeboardTypeListData(type, start, end);  
			   
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
		 
		 @GetMapping(value="noticeboard/detail_vue.do",produces = "text/plain;charset=UTF-8")
		  public String noticeboard_detail(int nbno) throws Exception
		  {
			 NoticeBoardVO vo=bService.noticeboardDetailData(nbno);
			  ObjectMapper mapper=new ObjectMapper();
			  String json=mapper.writeValueAsString(vo);
			  return json;
		  }
		 
		 @PostMapping(value = "noticeboard/get_admin.do", produces = "application/json;charset=UTF-8")
		 public ResponseEntity<Map<String, Integer>> getadmin(HttpServletRequest request) {
		     HttpSession session = request.getSession();
		     String id = (String) session.getAttribute("id");
		     Map<String, Integer> response = new HashMap<>();

		     if (id != null) {
		         int admin = bService.noticeboardadmin(id);
		         response.put("admin", admin);
		         System.out.println(admin);
		     } else {
		         response.put("admin", 0);
		     }
		     return ResponseEntity.ok(response); // JSON 형태로 반환
		 }
		 
		 @PostMapping(value="noticeboard/insert_vue.do",produces = "text/plain;charset=UTF-8")
		  public String noticeboard_insert(@ModelAttribute NoticeBoardVO vo, HttpServletRequest request)
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
				 String fileUrlBase = "http://localhost:8080/WineFineProject/noticeupload/";
				 
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
				 bService.noticeboardInsert(vo);
				 result="yes";  
			  }catch(Exception ex)
			  {
				  result=ex.getMessage();
			  }
			  return result;
		  }
		 
		 @GetMapping(value="noticeboard/update_vue.do",produces = "text/plain;charset=UTF-8")
		  public String noticeboard_update(Integer nbno) throws Exception
		  {
			 NoticeBoardVO vo=bService.noticeboardUpdateData(nbno);
			  ObjectMapper mapper=new ObjectMapper();
			  String json=mapper.writeValueAsString(vo);
			  return json;
		  }
		  @PostMapping(value="noticeboard/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
		  public String noticeboard_update_ok(NoticeBoardVO vo,HttpServletRequest request)
		  {
			  String result="";
			  try
			  {
				  // 수정전에 파일 정보 읽기 
				  NoticeBoardVO fvo=bService.noticeboardFileInfoData(vo.getNbno());
				  String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
				  path=path.replace("\\", File.separator);
				  String fileUrlBase = "http://localhost:8080/WineFineProject/noticeupload/";
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
				  result=bService.noticeboardUpdate(vo);
			  }catch(Exception ex) {ex.printStackTrace();}
			  return result;
		  }
		  @GetMapping(value="noticeboard/delete_vue.do",produces = "text/plain;charset=UTF-8")
		  public String noticeboard_delete(int nbno,HttpServletRequest request)
		  {
			  NoticeBoardVO vo=bService.noticeboardFileInfoData(nbno);
			  String result=bService.noticeboardDelete(nbno);
			  // 파일삭제 
			  if(result.equals("yes"))
			  {
				  String path=request.getSession().getServletContext().getRealPath("/")+"upload\\";
				  path=path.replace("\\", File.separator);
				  if(vo.getFilecount()>0)// 파일이 존재시 
				  {
					  StringTokenizer st=new StringTokenizer(vo.getFilename(),",");
					  while(st.hasMoreTokens())// 파일명 만큼 
					  {
						  File file=new File(path+st.nextToken());
						  file.delete();// 파일 삭제 
					  }
				  }
			  }
			  return result;
		  }
		 
	}
