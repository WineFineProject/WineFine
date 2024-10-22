package com.sist.controller;

import java.math.BigDecimal;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.ItemService;
import com.sist.vo.*;

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
	@GetMapping(value="seller/itemlist_vue.do", produces = "text/plain;charset=UTF-8")
	public String item_list(String seller, int page, String sortOrder) throws Exception {
		
		List<WineVO> iList;
		int rowSize=10;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		iList = iService.sellerItemListData(seller, start, end, sortOrder);
		int iCount = iService.sellerItemCount(seller);
		int totalpage = (int) Math.ceil((double) iCount / rowSize);
		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
		if(totalpage<endPage)
			endPage=totalpage;
	
		Map map=new HashMap();
		map.put("iList", iList);
		map.put("iCount", iCount);
		map.put("curpage",page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("totalpage", totalpage);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@PostMapping(value = "seller/deleteitems_vue.do", produces = "text/plain;charset=UTF-8")
	public String deleteItems(@RequestParam("wnos") List<Integer> wnos) {
		
		iService.deleteItems(wnos);
	   	    
	    return "OK";
	}
	@PostMapping(value = "seller/itemdelete_vue.do", produces = "text/plain;charset=UTF-8")
	public String itemDelete(int wno) {
		
		iService.itemDelete(wno);
		
		return "OK";
	}
	@PostMapping(value = "seller/updateitems_vue.do", produces = "text/plain;charset=UTF-8")
	public String updateItems(@RequestParam List<String> updates) {
	    try {
	        for (String update : updates) {
	            WineVO wineVO = new ObjectMapper().readValue(update, WineVO.class);
	            iService.updateItem(wineVO);
	        }
	        return "OK";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Error";
	    }
	}
	
	@GetMapping(value="seller/edit_vue.do",produces = "text/plain;charset=UTF-8")
	public String item_edit(Integer wno) throws Exception
	{
		WineVO vo=iService.wineItemData(wno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	@GetMapping(value = "seller/prevmaker_vue.do", produces = "text/plain;charset=UTF-8")
	public String prevmaker(int maker) {
		String mname = iService.getMakerkor(maker);
	    return mname;
	}
	@GetMapping(value = "seller/prevgrapes_vue.do", produces = "text/plain;charset=UTF-8")
	public String prevgrapes(String grapeNumbers) {
	    List<String> grapeList = Arrays.asList(grapeNumbers.split(","));
	    List<String> gnames = iService.getGrapeNames(grapeList);
	    String result = String.join(",", gnames);
	    return result;
	}
	
	@PostMapping(value="seller/update_vue.do",produces = "text/plain;charset=UTF-8")
	public String seller_update(@ModelAttribute WineVO vo)
	{
		String result="";
		iService.wineItemUpdate(vo);
		result="yes";
		return result;
	}
	@GetMapping(value = "seller/info_vue.do", produces = "text/plain;charset=UTF-8")
	public String sellerinfo(String id) throws Exception {
		MemberVO vo = iService.sellerInfoData(id);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	@GetMapping(value = "seller/snotice_vue.do", produces = "text/plain;charset=UTF-8")
	public String sellernotice(String id) throws Exception {
		List<NoticeBoardVO> nList= iService.sellerNoticeList(id);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(nList);
		return json;
	}
	
	@GetMapping(value = "seller/swineList_vue.do", produces = "text/plain;charset=UTF-8")
	public String sellerWineList(String id , int end) throws Exception {
		List<WineVO> wList= iService.sellerWineList(id, end);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(wList);
		return json;
	}
	@GetMapping(value = "seller/swinename_vue.do", produces = "text/plain;charset=UTF-8")
	public String noticeWineName(Integer target) throws Exception {
		String result = iService.noticeWineName(target);
		return result;
	}
	@GetMapping(value = "seller/approvalCheck_vue.do", produces = "text/plain;charset=UTF-8")
	public String approvalCheck(String id, int state) throws Exception {
		List<WineVO> list = iService.approvalCheckList(id, state);
		int count = iService.approvalCheckCount(id, state);
		
		Map map=new HashMap();
		map.put("list", list);
		map.put("count", count);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "seller/orderList_vue.do", produces = "text/plain;charset=UTF-8")
	public String sellerOrderList(String id, int page) throws Exception {
		
		int rowSize=10;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		
		Map omap=new HashMap();
		omap.put("userId", id);
		omap.put("start", start);
		omap.put("end", end);
		
		List<Wine_PaymentVO> oList= iService.orderList(omap);
		Map<String, BigDecimal> orderCounts = iService.getOrderCounts(id);
		
		int totalCount = orderCounts.get("TOTALCOUNT").intValue();
		int completed = orderCounts.get("COMPLETED").intValue();
		int preparing = orderCounts.get("PREPARING").intValue();
		int delivering = orderCounts.get("DELIVERING").intValue();
		int delivered = orderCounts.get("DELIVERED").intValue();
		int returnRequested = orderCounts.get("RETURNREQUESTED").intValue();
		int sellerCancelled = orderCounts.get("SELLERCANCELLED").intValue();
		int returnCompleted = orderCounts.get("RETURNCOMPLETED").intValue();
		
		final int BLOCK=10;
		int totalpage = (int) Math.ceil((double) totalCount / rowSize);
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
		if(totalpage<endPage)
			endPage=totalpage;
		
		Map map= new HashMap();
		map.put("oList", oList);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("curpage",page);
		map.put("totalpage", totalpage);
		map.put("totalCount", totalCount);
		map.put("completed", completed);
		map.put("preparing", preparing);
		map.put("delivering", delivering);
		map.put("delivered", delivered);
		map.put("returnRequested", returnRequested);
		map.put("sellerCancelled", sellerCancelled);
		map.put("returnCompleted", returnCompleted);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	@PostMapping(value = "seller/orderCancel_vue.do", produces = "text/plain;charset=UTF-8")
	public String orderCancel(int wpno) {
		String result="";
		iService.ordercancelUpdate(wpno);
		result="OK";
		return result;
	}
	@PostMapping(value = "seller/orderReturnCheck_vue.do", produces = "text/plain;charset=UTF-8")
	public String orderReturnCheck(int wpno) {
		String result="";
		iService.ordereturnUpdate(wpno);
		result="OK";
		return result;
	}
	
}
