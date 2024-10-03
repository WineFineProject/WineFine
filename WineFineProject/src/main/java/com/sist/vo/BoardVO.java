package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private int bno, cno, hit, filecount;
	private String id, nickname, subject, content, filename, filesize, dbday;
	private Date regdate;
	private List<MultipartFile> files; // 업로드된파일을 받는 경우 사용 ==> 여러개가 동시에 들어 올때 (List) => name은 반드시 []
	private MemberVO mvo=new MemberVO();
}
