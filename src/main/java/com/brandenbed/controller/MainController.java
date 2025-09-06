package com.brandenbed.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.brandenbed.entity.Admin;
import com.brandenbed.entity.Employee;
import com.brandenbed.entity.Transaction;
import com.brandenbed.entity.Property;
import com.brandenbed.entity.TenantQuery;
import com.brandenbed.services.AdminService;
import com.brandenbed.services.EmployeeService;
import com.brandenbed.services.PropertyService;
import com.brandenbed.services.TenantService;
import com.brandenbed.services.TransactionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
	
	private AdminService adminService;
	private EmployeeService employeeService;
	private PropertyService propertyService;
	private TenantService tenantService;
	private TransactionService transactionService;
	public MainController(AdminService adminService, EmployeeService employeeService, PropertyService propertyService, TenantService tenantService, TransactionService transactionService) {
		this.adminService = adminService;
		this.employeeService = employeeService;
		this.propertyService = propertyService;
		this.tenantService = tenantService;
		this.transactionService = transactionService;
		
	}

	@GetMapping("/")
	public String homePage() {
		return "home";
	}
	@GetMapping("/admin")
	public String adminPage() {
		return "admin";
	}
	
	
	
	
	

	@PostMapping("/admin")
    public ModelAndView loginUser(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isValid = adminService.login(username, password);

        ModelAndView mv = new ModelAndView();

        if (isValid) {
           
            mv.setViewName("redirect:/admin/dashboard");
            HttpSession session = request.getSession(true);
			session.setAttribute("un", username);
        } else {
            mv.setViewName("admin"); // show login.jsp again
            mv.addObject("errmsg", "Invalid credentials");
        }

        return mv;
    }
	//Dashboard
	@GetMapping("/admin/dashboard")
	public String dashboard(Model model,HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin";
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);
	    // Fetch top 5 recent queries
	    List<TenantQuery> recentQueries = tenantService.findTop5ByOrderByDateSubmittedDesc();
	    model.addAttribute("recentQueries", recentQueries);

	    // Fetch pending rent collections
	    List<Transaction> pendingRents = transactionService.findTop5ByStatusOrderByTransactionDateAsc("Pending");
	    model.addAttribute("pendingRents", pendingRents);
	    
	    //Calculate total pending rent
	    Double totalPending = transactionService.getTotalPendingRent();
	    model.addAttribute("totalPending", totalPending);  
	    
	 // Fetch pending tenant queries
	    Long pendingQueries = tenantService.countPendingQueries();
	    model.addAttribute("pendingQueries", pendingQueries);
	    
	    Long totalProperties = propertyService.getTotalProperties();
	    model.addAttribute("totalProperties", totalProperties);
	    
	 // Total tenant queries
	    Long totalTenantQueries = tenantService.getTotalTenantQueries();
	    model.addAttribute("totalTenantQueries", totalTenantQueries);
	    
	    model.addAttribute("totalEmployees", employeeService.getTotalEmployees());
	    model.addAttribute("activeEmployees", employeeService.getActiveEmployees());
	    model.addAttribute("inactiveEmployees", employeeService.getInactiveEmployees());



	    return "dashboard"; // dashboard.jsp
	}

	//Transaction
	@GetMapping("/admin/rent-collection")
	public String rentCollection(
	        HttpServletRequest request,
	        Model model,
	        @RequestParam(defaultValue = "0") int page,
	        @RequestParam(required = false) String status) {

	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin";
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    int pageSize = 10; // records per page
	    Page<Transaction> paymentPage;

	    if (status != null && !status.isEmpty()) {
	        paymentPage = transactionService.findByStatus(status, PageRequest.of(page, pageSize));
	    } else {
	        paymentPage = transactionService.findAll(PageRequest.of(page, pageSize));
	    }

	    model.addAttribute("payments", paymentPage.getContent());
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", paymentPage.getTotalPages());
	    model.addAttribute("adminName", admin.getUsername());
	    model.addAttribute("selectedStatus", status);

	    return "rentCollection"; // JSP page
	}



	
	
	//Tenant-Query
	

	
	@GetMapping("/admin/tenant-queries")
	public String showTenantQueries(HttpServletRequest request, Model model) {
	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin";
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    List<TenantQuery> queries = tenantService.findAllQueries(); // implement this in your service
	    model.addAttribute("queries", queries);
	    model.addAttribute("adminName", admin.getUsername());

	    return "tenant-queries"; // JSP page: tenantQueries.jsp
	}


	@PostMapping("/admin/updateTenantQueryStatus")
	@ResponseBody
	public String updateTenantQueryStatus(@RequestParam Long id, @RequestParam String status, HttpServletRequest request) {
	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "Unauthorized";
	    }

	    TenantQuery query = tenantService.findById(id);
	    if (query == null) {
	        return "Query not found";
	    }

	    try {
	        TenantQuery.Status newStatus = TenantQuery.Status.valueOf(status.toUpperCase());
	        query.setStatus(newStatus);
	        tenantService.save(query); // persist the change
	        return "Status updated successfully";
	    } catch (IllegalArgumentException e) {
	        return "Invalid status value";
	    }
	}
	
	//Property Section
	@PostMapping("/admin/addProperty")
	public String addProperty(@ModelAttribute Property property,
	                          @RequestParam("image") MultipartFile file,
	                          HttpServletRequest request) throws IOException {

	    HttpSession session = request.getSession(false);
	    if(session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin"; 
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    // Save the uploaded file
	    if (!file.isEmpty()) {
	        String uploadsDir = request.getServletContext().getRealPath("/images/");
	        File dir = new File(uploadsDir);
	        if (!dir.exists()) dir.mkdirs();

	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        file.transferTo(new File(dir, fileName));

	        property.setImagePath(fileName);  // save the filename in DB
	    }

	    property.setAdmin(admin);
	    propertyService.addProperty(property);

	    // Redirect to property list
	    return "redirect:/admin/propertiesList";
	}
	
	@PostMapping("/admin/deleteProperty")
	public String deleteProperty(@RequestParam("id") long id) {
	    propertyService.deleteProperty(id);
	    return "redirect:/admin/propertiesList";
	}

	// GET: fetch property for editing
	@GetMapping("/admin/editProperty")
	public String getPropertyForEdit(@RequestParam("id") Long id, Model model) {
	    Property property = propertyService.getById(id);
	    model.addAttribute("property", property);
	    return "/admin/propertiesList";
	}

	// POST: update property after edit
	@PostMapping("/admin/editProperty")
	public String updateProperty(@ModelAttribute Property property) {
	    propertyService.updateProperty(property); // implement update in service
	    return "redirect:/admin/propertiesList";
	}
	
	@GetMapping("/admin/filter")
	public String filterProperties(
	        @RequestParam(value = "name", required = false) String name,
	        @RequestParam(value = "status", required = false) String status,
	        Model model) {

	    List<Property> properties;

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
	    return "propertiesList"; // JSP page displaying the list
	}




	
	@GetMapping("/admin/propertiesList")
	public String getPropertyList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin";
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    List<Property> properties = propertyService.findAllProperties(); // all employees
	    model.addAttribute("properties", properties);
	    model.addAttribute("adminName", admin.getUsername());

	    return "propertiesList";
	}


	//Employees Section
	
	@PostMapping("/admin/addEmployee")
	public String addEmployee(@ModelAttribute Employee employee, HttpServletRequest request, Model model) {

	    HttpSession session = request.getSession(false);
	    if(session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin"; 
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    employee.setAdmin(admin);
	    employeeService.addEmployee(employee);

	    // Redirect to employee list page (avoids null emp)
	    return "redirect:/admin/employeeList";
	}

	
	@GetMapping("/admin/employeeList")
	public String showEmployeeList(HttpServletRequest request, Model model) {
	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("un") == null) {
	        return "redirect:/admin";
	    }

	    String username = (String) session.getAttribute("un");
	    Admin admin = adminService.findByUsername(username);

	    List<Employee> employees = employeeService.findAllEmployees(); // all employees
	    model.addAttribute("emp", employees);
	    model.addAttribute("adminName", admin.getUsername());

	    return "employee"; // JSP
	}

	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		session.invalidate();

		return "admin";
	}




	



}

