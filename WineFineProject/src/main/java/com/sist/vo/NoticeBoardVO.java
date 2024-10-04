package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
/*
 * NBNO	NUMBER
ID	VARCHAR2(50 BYTE)
NICKNAME	VARCHAR2(100 BYTE)
SUBJECT	VARCHAR2(2000 BYTE)
CONTENT	CLOB
REGDATE	DATE
CNO	NUMBER
HIT	NUMBER
FILENAME	VARCHAR2(1000 BYTE)
FILESIZE	VARCHAR2(1000 BYTE)
FILECOUNT	NUMBER
 */
@Data
public class NoticeBoardVO {
	private int nbno, cno, hit, filecount;
	private String id, nickname, subject, content, filename, filesize, dbday;
	private Date regdate;
	private List<MultipartFile> files; 
}
