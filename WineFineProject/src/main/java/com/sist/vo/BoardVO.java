package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BoardVO {
	private int bno, cno, hit, filecount;
	private String id, nickname, subject, content, filename, filesize, dbday;
	private Date regdate;
	 private List<MultipartFile> files;
}
