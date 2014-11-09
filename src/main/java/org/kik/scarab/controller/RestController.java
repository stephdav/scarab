package org.kik.scarab.controller;

import java.util.List;

import org.kik.scarab.model.UserStory;
import org.kik.scarab.service.UserStoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/rest")
public class RestController {

	private static final Logger LOG = LoggerFactory
			.getLogger(RestController.class);

	@Autowired
	UserStoryService svcUS;

	// === User Story ========================================================

	@RequestMapping(value = "us", method = RequestMethod.GET)
	public @ResponseBody List<UserStory> getUS() {
		LOG.info("getUS()");
		List<UserStory> l = svcUS.getUserStories();
		LOG.info("getUS() : {} results", l.size());
		return l;
	}

	@RequestMapping(value = "us", method = RequestMethod.POST)
	public @ResponseBody UserStory createUS(@RequestBody UserStory us) {
		LOG.info("createUserStory({}, {})", us.getTitle(), us.getDescription());
		return svcUS.createUserStory(us);
	}
}