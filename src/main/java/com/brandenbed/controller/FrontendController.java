package com.brandenbed.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.brandenbed.entity.Property;

import com.brandenbed.services.PropertyService;


import jakarta.servlet.http.HttpServletRequest;


@Controller
public class FrontendController {
	
	
	private PropertyService propertyService;
	
	public FrontendController(PropertyService propertyService) {
	
		this.propertyService = propertyService;
		
	}
	

	@GetMapping("/properties")
	public String getPropertyList(HttpServletRequest request, Model model) {
		

	    List<Property> properties = propertyService.findAllProperties(); // all employees
	    model.addAttribute("properties", properties);
	    
	    return "properties";
	}
	
	@GetMapping("/filter")
	public String filterProperties(
	        @RequestParam(value = "name", required = false) String name,
	        @RequestParam(value = "status", required = false) String status,
	        Model model) {

	    List<Property> properties;
	    
	    if ("All".equalsIgnoreCase(status)) {
	        status = null;
	    }

	    if ((name != null && !name.isEmpty()) && (status != null && !status.isEmpty())) {
	        // Filter by both name and status
	        properties = propertyService.findByNameContainingAndStatus(name, status);
	    } else if (name != null && !name.isEmpty()) {
	        // Filter by name only
	        properties = propertyService.findByNameContaining(name);
	    } else if (status != null && !status.isEmpty()) {
	        // Filter by status only
	        properties = propertyService.findByStatus(status);
	    } else {
	        // No filters, return all
	        properties = propertyService.findAllProperties();
	    }

	    model.addAttribute("properties", properties);
	    return "properties"; // JSP page displaying the list
	}
	@GetMapping("/aboutUs")
	public String aboutUsPage() {
	    
	    return "about-us";
	}
	
	@GetMapping("/signIn")
	public String signInPage() {
	    
	    return "signin";
	}
	@GetMapping("/register")
	public String registerPage() {
	    
	    return "register";
	}
}
