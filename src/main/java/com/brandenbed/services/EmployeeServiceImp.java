package com.brandenbed.services;

import com.brandenbed.entity.Employee;
import com.brandenbed.repository.EmployeeRepo;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImp implements EmployeeService {

    private final EmployeeRepo employeeRepo;

    // ✅ Constructor Injection
    public EmployeeServiceImp(EmployeeRepo employeeRepo) {
        this.employeeRepo = employeeRepo;
    }

	@Override
	public String addEmployee(Employee employee) {
		employeeRepo.save(employee);
		return "Employee added successfully";
	}

	@Override
	public List<Employee> findAllEmployees() {
		// TODO Auto-generated method stub
		return employeeRepo.findAll();
	}
	// Total employees
    public long getTotalEmployees() {
        return employeeRepo.count();
    }

    // Total active employees
    public long getActiveEmployees() {
        return employeeRepo.countByStatus(Employee.Status.ACTIVE);
    }

    // Total inactive employees
    public long getInactiveEmployees() {
        return employeeRepo.countByStatus(Employee.Status.INACTIVE);
    }
	
}
