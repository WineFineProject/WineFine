package com.sist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {
	
	@GetMapping("board/list.do")
	  public String board_list()
	  {
		  return "board/list";
	  }
	@GetMapping("board/detail.do")
	   public String board_detail(int bno, Model model)
	   {
		   model.addAttribute("bno", bno);
		   return "board/detail";
	   }
	@GetMapping("board/insert.do")
	   public String board_insert()
	   {
		   return "board/insert";
	   }
	@GetMapping("board/update.do")
	   public String board_update(int bno,Model model)
	   {
		   model.addAttribute("bno", bno);
		   return "board/update";
	   }
	
	@GetMapping("noticeboard/list.do")
	public String noticeboard_list()
	{
		return "noticeboard/list";
	}
	@GetMapping("noticeboard/detail.do")
	public String noticeboard_detail(int nbno, Model model)
	{
		model.addAttribute("nbno", nbno);
		return "noticeboard/detail";
	}
	@GetMapping("noticeboard/insert.do")
	public String noticeboard_insert()
	{
		return "noticeboard/insert";
	}
	@GetMapping("noticeboard/update.do")
	public String noticeboard_update(int nbno,Model model)
	{
		model.addAttribute("nbno", nbno);
		return "noticeboard/update";
	}
}
