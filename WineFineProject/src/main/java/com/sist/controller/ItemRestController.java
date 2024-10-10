package com.sist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.ItemService;
import com.sist.vo.MakerVO;
import com.sist.vo.WineVO;
import com.sist.vo.GrapeVO;
import com.sist.vo.ItemNationVO;

@RestController
public class ItemRestController {
	@Autowired
	private ItemService iService;
	
	@PostMapping(value="seller/register_vue.do",produces = "text/plain;charset=UTF-8")
	public String seller_register(@ModelAttribute WineVO vo)
	{
		String result="";
		iService.wineItemInsert(vo);
		result="yes";
		return result;
	}
	
	@GetMapping(value="seller/register_maker_find_vue.do", produces = "text/plain;charset=UTF-8")
	public String maker_find_list(String find) throws Exception {
		
		List<MakerVO> mList;
		mList = iService.makerFindListData(find);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(mList);

		return json;
	}
	
	@GetMapping(value="seller/register_grape_find_vue.do", produces = "text/plain;charset=UTF-8")
	public String grape_find_list(String find) throws Exception {
		
		List<GrapeVO> gList;
		gList = iService.grapeFindListData(find);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(gList);
		
		return json;
	}
	
	@GetMapping(value="seller/register_nation1_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String nation1_list() throws Exception {
		
		List<ItemNationVO> n1List;
		n1List = iService.nation1FindListData();
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(n1List);
		
		return json;
	}
	@GetMapping(value="seller/register_nation2_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String nation2_list(Integer no) throws Exception {
		
		List<ItemNationVO> n2List;
		n2List = iService.nation2FindListData(no);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(n2List);
		
		return json;
	}
	@GetMapping(value="seller/register_nation3_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String nation3_list(Integer no) throws Exception {
		
		List<ItemNationVO> n3List;
		n3List = iService.nation3FindListData(no);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(n3List);
		
		return json;
	}
	@GetMapping(value="seller/register_nation4_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String nation4_list(Integer no) throws Exception {
		
		List<ItemNationVO> n4List;
		n4List = iService.nation4FindListData(no);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(n4List);
		
		return json;
	}
	
}
