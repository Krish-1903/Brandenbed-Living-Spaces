package com.brandenbed.entity;

import java.util.List;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "properties")
@Data
public class Property {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Property Name (maps to "name" field in JSP)
    @Column(nullable = false)
    private String name;

    // Location/Address (maps to "location")
    @Column(nullable = false)
    private String location;

    // Rent or Price (maps to "price")
    @Column(nullable = false)
    private Double price;

    // Status (Available, Rented, etc.)
    @Column(nullable = false)
    private String status;

    // Image path (uploaded file saved locally / in cloud)
    private String imagePath;

    // Optional: If you still want admin relationship
    @ManyToOne
    @JoinColumn(name = "admin_id", nullable = false)
    private Admin admin;
    
    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TenantQuery> tenantQueries;
    
    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Resident> residents;


	public List<Resident> getResidents() {
		return residents;
	}

	public void setResidents(List<Resident> residents) {
		this.residents = residents;
	}

	public List<TenantQuery> getTenantQueries() {
		return tenantQueries;
	}

	public void setTenantQueries(List<TenantQuery> tenantQueries) {
		this.tenantQueries = tenantQueries;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
    
    
}

