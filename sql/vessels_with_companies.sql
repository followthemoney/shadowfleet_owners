select
    vwc.vessel_imo as current_vessel_imo,
    lag(company_imo) over (partition by vessel_imo, role order by start_date) as previous_company_imo,
    vwc.company_imo as current_company_imo,
    lag(company_name) over (partition by vessel_imo, role order by start_date) as previous_company_name,
    vwc.company_name as current_company_name,
    lag(jurisdiction) over (partition by vessel_imo, role order by start_date) as previous_jurisdiction,
    vwc.jurisdiction,
    vwc.start_date,
    vwc.end_date,
    vwc.role
from
    (select
    vc.vessel_imo,
    vc.company_imo,
    c.company_name,
    vc.start_date,
    vc.end_date,
    c.jurisdiction,
    vc.role
    from vessel_company vc
    left join vessels v on v.vessel_imo = vc.vessel_imo
    left join companies c on c.company_imo = vc.company_imo) as vwc