package com.brandenbed.services;

import java.util.List;

import com.brandenbed.entity.TenantQuery;

public interface TenantService {

    TenantQuery findById(Long id);

    void save(TenantQuery query);

    List<TenantQuery> findAll();

    List<TenantQuery> addTenant(TenantQuery tenantQuery);

    List<TenantQuery> findAllQueries();

    List<TenantQuery> findTop5ByOrderByDateSubmittedDesc();

	long countByStatus(TenantQuery.Status status);
	long getTotalTenantQueries();
	Long countPendingQueries();


}
