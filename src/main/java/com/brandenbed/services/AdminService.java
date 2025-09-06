package com.brandenbed.services;

import com.brandenbed.entity.Admin;

public interface AdminService {
    boolean login(String username, String password);

	Admin findByUsername(String username);
}
