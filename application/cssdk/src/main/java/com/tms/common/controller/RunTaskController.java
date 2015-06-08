package com.tms.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import java.util.logging.Logger;
import java.util.logging.Level;
import org.springframework.util.MultiValueMap;
import java.util.Set;
import org.springframework.web.servlet.ModelAndView;
import com.interwoven.cssdk.common.CSClient;
import com.interwoven.cssdk.common.CSException;
import com.interwoven.cssdk.factory.CSFactory;
import com.interwoven.cssdk.workflow.CSTask;
import com.interwoven.cssdk.workflow.CSWorkflow;
import com.interwoven.cssdk.workflow.CSWorkflowEngine;

// This sample code include the CSSDK interface and is queryable from /SpringMVC/runtask
// It needs to he extended to extract the parameters from the WFM which include a method to run
// JobID and Task ID, which can be used to execute desired functions and return the data to the calling 
// WFM

@Controller
@RequestMapping("/runtask")
public class RunTaskController {
    private final static Logger LOGGER = Logger.getLogger(RunTaskController.class.getName()); 

        String retval="";
	@RequestMapping(method = RequestMethod.POST)
        @ResponseBody
         public String processPostRequest(@RequestParam MultiValueMap parameters) {
            Set<String> keys = parameters.keySet();
            LOGGER.setLevel(Level.INFO);
            
            // iterate through the key set and display key and values
              for (String key : keys) {
                  retval+=" Key = " + key;
                  retval+=" Values = " + parameters.get(key);
                  LOGGER.info("Key: "+key+" Value: "+parameters.get(key));
              }
        LOGGER.info("retval: "+retval);
        return retval;
}
	@RequestMapping(method = RequestMethod.GET)
        @ResponseBody

    	public String printWelcome(ModelMap model) {
        // This will be replaced with custom Java to execute tasks based off the data inthe post
		model.addAttribute("message", "Spring 3 MVC Run Task" + retval);
                LOGGER.setLevel(Level.INFO);
                LOGGER.info("Logger Name: "+LOGGER.getName());
		return "Get's are not supported on this URL";

	}

}
