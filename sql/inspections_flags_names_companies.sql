select
    i.vessel_imo,
    i.date,
    i.country,
    i.port,
    i.number_of_deficiencies,
    i.detention,
    f.flag,
    n.vessel_name,
    vc.company_imo,
    vc.role,
    c.company_name,
    c.jurisdiction

from inspections i
left join flags f 
    on i.vessel_imo = f.vessel_imo 
    and i.date >= coalesce(f.start_date, '2000-01-01')
    and i.date <= coalesce(f.end_date, '2024-10-01')
    
left join names n
    on i.vessel_imo = n.vessel_imo
    and i.date >= coalesce(n.start_date, '2000-01-01')
    and i.date <= coalesce(n.end_date, '2024-10-01')
    
left join vessel_company vc
    on i.vessel_imo = vc.vessel_imo
    and i.date >= coalesce(vc.start_date, '2000-01-01')
    and i.date <= coalesce(vc.end_date, '2024-10-01')
    
left join companies c
    on vc.company_imo = c.company_imo
    
where i.date >= '2020-01-01'
    and i.port is not null