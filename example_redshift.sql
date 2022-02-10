--vw_bet_summary_reporting
SELECT
    top 1000 brand,
    account_id,
    sport_name,
    start_time_uki,
    ramp_event_id,
    ramp_market_id,
    ramp_selection_id,
    market_name,
    sportex_selection_name as selection_name,
    placed_datetime,
    cast(placed_datetime as date) as placed_date,
    settled_datetime,
    mult_ref,
    leg_price_actual,
    in_play_yn,
    each_way_yn,
    racing_track,
    volume_gbp,
    revenue_gbp,
    leg_winner_yn
FROM
    omni_sportsbook.vw_bet_summary_racing_reporting
WHERE
    settled_datetime > SYSDATE -1
    
;
    

select cast(sysdate as date) as gnksdrklg;


SELECT
    top 1000 r.brand,
    r.account_id,
    sport_name,
    start_time_uki,
    ramp_event_id,
    ramp_market_id,
    ramp_selection_id,
    market_name,
    sportex_selection_name as selection_name,
    placed_datetime,
    settled_datetime,
    mult_ref,
    leg_price_actual,
    in_play_yn,
    each_way_yn,
    racing_track,
    volume_gbp,
    revenue_gbp,
    leg_winner_yn,
    a.gender,
    a.jurisdiction
FROM
    omni_sportsbook.vw_bet_summary_racing_reporting r
LEFT JOIN omni_account.vw_account a on a.account_id = r.account_id    
WHERE
    settled_datetime > SYSDATE -1
    
    ;   
    
    
SELECT
    brand,
    each_way_yn,
    sum(volume_gbp) as total_volume,
    sum(revenue_gbp) as total_revenue,
    100 * sum(revenue_gbp)/sum(volume_gbp) as pct_margin,
    count(*) as no_of_bets
FROM
    omni_sportsbook.vw_bet_summary_racing_reporting
WHERE
    settled_datetime > SYSDATE -1
GROUP BY brand, each_way_yn        

;


SELECT
    brand,
    each_way_yn,
    CASE WHEN leg_price_actual < 8.0 THEN 'UNDER 8.0'
    WHEN leg_price_actual <= 15.0 THEN '8 TO 15'
    ELSE 'OVER 15.0'
    END AS price_group,
    sum(volume_gbp) as total_volume,
    sum(revenue_gbp) as total_revenue,
    100 * sum(revenue_gbp)/sum(volume_gbp) as pct_margin,
    count(*) as no_of_bets
FROM
    omni_sportsbook.vw_bet_summary_racing_reporting
WHERE
    settled_datetime > SYSDATE -1
GROUP BY 1,2,3  

;

--Slides Q1
SELECT count(distinct account_id) as customers,
        sum(volume_gbp) as volume,
        sum(revenue_gbp) as revenue,
        count(*) as bets
        from     omni_sportsbook.vw_bet_summary_sas_reporting
        where sport_name = 'Snooker'
        and placed_datetime > '2020-03-10 10:00:00'
        and placed_datetime < '2020-03-10 22:00:00'

;