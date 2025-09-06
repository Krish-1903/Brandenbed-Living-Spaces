package com.brandenbed.services;


import java.util.List;

import com.brandenbed.entity.Employee;

public interface EmployeeService {


	String addEmployee(Employee employee);


	List<Employee> findAllEmployees();


	long getTotalEmployees();
	long getActiveEmployees();
	long getInactiveEmployees();

	

}
