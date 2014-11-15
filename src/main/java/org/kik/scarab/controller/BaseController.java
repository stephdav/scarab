package org.kik.scarab.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BaseController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String welcome(ModelMap model) {
		return "index";
	}

	@RequestMapping(value = "/backlog", method = RequestMethod.GET)
	public String backlog(ModelMap model) {
		return "backlog";
	}

	@RequestMapping(value = "/sprint", method = RequestMethod.GET)
	public String sprint(ModelMap model) {
		return "sprint";
	}

	@RequestMapping(value = "/daily", method = RequestMethod.GET)
	public String daily(ModelMap model) {
		return "daily";
	}

	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String review(ModelMap model) {
		return "review";
	}

	@RequestMapping(value = "/retro", method = RequestMethod.GET)
	public String retro(ModelMap model) {
		return "retro";
	}
}