package com.brandenbed.services;

import com.brandenbed.repository.PropertyRepo;
import java.util.List;
import org.springframework.stereotype.Service;
import com.brandenbed.entity.Property;

@Service
public class PropertyServiceImp implements PropertyService {

    private final PropertyRepo propertyRepo;

    PropertyServiceImp(PropertyRepo propertyRepo) {
        this.propertyRepo = propertyRepo;
    }

    @Override
    public String addProperty(Property property) {
        propertyRepo.save(property);
        return "Property added successfully";
    }

    @Override
    public List<Property> findAllProperties() {
        return propertyRepo.findAll();
    }

    @Override
    public String deleteProperty(Long id) {
        propertyRepo.deleteById(id);
        return "Property deleted successfully";
    }

    @Override
    public Property getById(Long id) {
        return propertyRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Property not found"));
    }

    @Override
    public String updateProperty(Property property) {
        Property pr = propertyRepo.findById(property.getId())
                .orElseThrow(() -> new RuntimeException("Property not found"));

        pr.setName(property.getName());
        pr.setLocation(property.getLocation());
        pr.setPrice(property.getPrice());
        pr.setStatus(property.getStatus());

        if (property.getImagePath() != null) {
            pr.setImagePath(property.getImagePath());
        }

        propertyRepo.save(pr);
        return pr.getName() + " Property Updated Successfully";
    }

	@Override
	public String findById(Property property) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Property> findByNameContaining(String name) {
		// TODO Auto-generated method stub
		return propertyRepo.findByNameContainingIgnoreCase(name);
	}
	
	@Override
	public List<Property> findByNameContainingIgnoreCase(String name) {
	    return propertyRepo.findByNameContainingIgnoreCase(name);
	}

	@Override
	public List<Property> findByNameContainingAndStatus(String name, String status) {
	    // Calls the repository method to filter by both name and status
	    return propertyRepo.findByNameContainingIgnoreCaseAndStatus(name, status);
	}

	@Override
	public List<Property> findByStatus(String status) {
	    return propertyRepo.findByStatus(status);
	}

	@Override
	public List<Property> findAll() {
		// TODO Auto-generated method stub
		return propertyRepo.findAll();
	}

	@Override
    public Property findById(Long id) {
        return propertyRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Property not found with id: " + id));
    }

	@Override
	public long countByStatus(String status) {
		return propertyRepo.countByStatus(status);
	}

	@Override
	public long getTotalProperties() {
		// TODO Auto-generated method stub
		return propertyRepo.count();
	}
	


}
