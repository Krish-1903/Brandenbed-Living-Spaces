package com.brandenbed.services;

import java.util.List;

import com.brandenbed.entity.Property;

public interface PropertyService {

	String addProperty(Property property);

	List<Property> findAllProperties();

	String deleteProperty(Long id);

    Property findById(Long id);

	Property getById(Long id);

	String updateProperty(Property property);

	List<Property> findByNameContaining(String name);

	List<Property> findByNameContainingIgnoreCase(String name);

	List<Property> findByNameContainingAndStatus(String name, String status);

	List<Property> findByStatus(String status);

	List<Property> findAll();

	String findById(Property property);
	
	long countByStatus(String status);
	
	long getTotalProperties();


}
