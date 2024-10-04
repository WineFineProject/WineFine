
package com.sist.controller;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.service.CartService;

import java.util.*;

@Controller
@RequestMapping("cart/")
public class CartController {


	@GetMapping("inMyCart")
	public String inMyCart(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		if (id == null) {
			return "redirect:member/login";
		}
		// List<Cart>
		/*
		 * List<CartItemDTO> cartItems = cartService.getCartItems(userId);
		 * model.addAttribute("cartItems", cartItems);
		 */
		return "cart/inMyCart";
	}

}
