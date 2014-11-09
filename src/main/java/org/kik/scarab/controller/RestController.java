package org.kik.scarab.controller;

import org.kik.scarab.model.rest.US;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

	@RequestMapping(value = "us", method = RequestMethod.POST)
	public @ResponseBody US createUS(@RequestBody US us) {
		LOG.info("createUS({}, {})", us.getTitle(), us.getDescription());
		return new US();
	}
}