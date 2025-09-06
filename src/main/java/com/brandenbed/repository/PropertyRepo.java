package com.brandenbed.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import com.brandenbed.entity.Property;

@Repository
public interface PropertyRepo extends JpaRepository<Property, Long> {
	List<Property> findAll();

	List<Property> findByNameContainingIgnoreCase(String name);

	List<Property> findByNameContainingIgnoreCaseAndStatus(String name, String status);

	List<Property> findByStatus(String status);

	long countByStatus(String status);
	
}
