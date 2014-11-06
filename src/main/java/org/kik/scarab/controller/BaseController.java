package org.kik.scarab.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BaseController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String welcome(ModelMap model) {
		model.addAttribute("message",
				"Maven Web Project + Spring 3 MVC - welcome()");
		return "index";
	}

}