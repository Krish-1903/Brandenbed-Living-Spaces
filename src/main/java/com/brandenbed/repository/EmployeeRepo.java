package com.brandenbed.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.brandenbed.entity.Admin;
import com.brandenbed.entity.Employee;

public interface EmployeeRepo extends JpaRepository<Employee, Long> {
	
	List<Employee> findByAdmin(Admin admin);
	
	 // Count by status
    long countByStatus(Employee.Status status);
}
