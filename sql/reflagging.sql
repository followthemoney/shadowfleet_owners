select
    f.vessel_imo,
    f.start_date,
    lag(flag) over (partition by vessel_imo order by start_date) as previous_flag,
    f.flag as next_flag
from
    flags f