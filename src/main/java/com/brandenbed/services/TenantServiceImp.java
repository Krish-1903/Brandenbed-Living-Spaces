package com.brandenbed.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.brandenbed.entity.TenantQuery;
import com.brandenbed.repository.TenantRepo;

@Service
public class TenantServiceImp  implements TenantService{

	
	private final TenantRepo tenantRepo;
	 // ✅ Constructor Injection
    public TenantServiceImp(TenantRepo tenantRepo ) {
        this.tenantRepo = tenantRepo;
    }

	@Override
	public TenantQuery findById(Long id) {
		return tenantRepo.findById(id).orElse(null);
	}

	@Override
	public void save(TenantQuery query) {
		tenantRepo.save(query);
		
	}

	@Override
	public List<TenantQuery> findAll() {
		return tenantRepo.findAll();
	}


	@Override
	public List<TenantQuery> findAllQueries() {
		return tenantRepo.findAll();
	}

	@Override
	public List<TenantQuery> findTop5ByOrderByDateSubmittedDesc() {
		// TODO Auto-generated method stub
		return tenantRepo.findTop5ByOrderByDateSubmittedDesc();
	}

	
	@Override
	public List<TenantQuery> addTenant(TenantQuery tenantQuery) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long countByStatus(TenantQuery.Status status) {
		// TODO Auto-generated method stub
		return tenantRepo.countByStatus(status);
	}
	
	public long getTotalTenantQueries() {
        return tenantRepo.count(); // Returns total tenant queries
    }
	public Long countPendingQueries() {
        return tenantRepo.countByStatus(TenantQuery.Status.PENDING);
    }

}
