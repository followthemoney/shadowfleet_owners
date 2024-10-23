SELECT
    p.vessel_imo,
    n.vessel_name,
    INITCAP(SPLIT_PART(port_id, '-', 2)) AS port,
    UPPER(LEFT(p.port_id, 3)) AS country,
    p.start_date,
    p.end_date,
    CASE    
        WHEN u.vessel_imo IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS uninsured,
    CASE 
        WHEN s.vessel_imo IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS sanctioned

FROM port_visits p

LEFT JOIN names n
    ON p.vessel_imo = n.vessel_imo
    AND p.start_date >= n.start_date
    AND p.end_date <= n.end_date

LEFT JOIN (
    SELECT
        vessel_imo,
        start_date,
        end_date
    FROM
        uninsured ) u
    ON p.vessel_imo = u.vessel_imo
    AND p.start_date >= u.start_date
    AND p.end_date <= u.end_date
    
LEFT JOIN (
    SELECT
        vessel_imo,
        earliest_sanction_date
        
    FROM
        sanctions ) s
    ON p.vessel_imo = s.vessel_imo
    AND p.start_date >= s.earliest_sanction_date