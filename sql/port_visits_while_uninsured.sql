select
    p.vessel_imo,
    v.vessel_name,
    p.port_id,
    p.start_date,
    p.end_date,
    p.lat as latitude,
    p.lon as longitude
from port_visits p
left join uninsured u on p.vessel_imo = u.vessel_imo
left join vessels v on p.vessel_imo = v.vessel_imo
where u.start_date <= p.start_date
and u.end_date >= p.end_date
