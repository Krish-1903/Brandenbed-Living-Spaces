package com.brandenbed.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "tenant_queries")
@Data
public class TenantQuery {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Tenant name
    @Column(nullable = false)
    private String tenantName;

    // Query description
    @Column(nullable = false, length = 1000)
    private String queryText;

    // Date submitted (auto-generated)
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private LocalDateTime dateSubmitted;

    // Status (Pending, In Progress, Resolved)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;

    // Link to Property
    @ManyToOne
    @JoinColumn(name = "property_id", nullable = false)
    private Property property;

    // Admin who created the query
    @ManyToOne
    @JoinColumn(name = "admin_id", nullable = false)
    private Admin admin;

    // Status enum
    public enum Status {
        PENDING,
        IN_PROGRESS,
        RESOLVED, 
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public String getQueryText() {
        return queryText;
    }

    public void setQueryText(String queryText) {
        this.queryText = queryText;
    }

    public LocalDateTime getDateSubmitted() {
        return dateSubmitted;
    }

    public void setDateSubmitted(LocalDateTime dateSubmitted) {
        this.dateSubmitted = dateSubmitted;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
}
