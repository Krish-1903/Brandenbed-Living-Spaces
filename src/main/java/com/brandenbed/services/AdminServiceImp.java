package com.brandenbed.services;

import org.springframework.stereotype.Service;

import com.brandenbed.entity.Admin;
import com.brandenbed.repository.AdminRepo;

@Service
public class AdminServiceImp implements AdminService{
private AdminRepo adminRepo;
	
	public AdminServiceImp(AdminRepo adminRepo) {
		this.adminRepo = adminRepo;
	}

	@Override
	public boolean login(String username, String password) {
		// TODO Auto-generated method stub
		return adminRepo.findByUsernameAndPassword(username, password).isPresent();
	}

	@Override
	public Admin findByUsername(String username) {
	    return adminRepo.findByUsername(username).orElse(null);
	}

}
