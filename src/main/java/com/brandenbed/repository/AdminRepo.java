package com.brandenbed.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.brandenbed.entity.Admin;

import java.util.Optional;

@Repository
public interface AdminRepo extends JpaRepository<Admin, Long> {

    Optional<Admin> findByUsernameAndPassword(String username, String password);
    
    Optional<Admin> findByUsername(String username);

}
