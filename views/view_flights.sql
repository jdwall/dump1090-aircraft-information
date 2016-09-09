CREATE OR REPLACE view view_flights
AS
  SELECT p.time        AS DATE,
         f.flight,
         faam.nnumber  AS `N Number`,
         faam.year_mfr AS `Year Manufactured`,
         act.aircraft_type,
         act.manufacturer,
         act.model,
         act.engine_type,
         act.aircraft_category,
         act.mtow,
         eng.mfr       AS `Engine Manufacturer`,
         eng.model     AS `Engine Model`,
         p.squawk,
         p.latitude,
         p.longitude,
         p.track,
         p.altitude,
         p.verticlerate,
         p.speed
  FROM   kdfw_adsb.adsb_positions p
         JOIN kdfw_adsb.adsb_flights f
           ON f.id = p.flight
         JOIN kdfw_adsb.adsb_aircraft adsba
           ON adsba.id = f.aircraft
         LEFT JOIN adsb.faa_master faam
                ON faam.mode_s_code_hex = adsba.icao
         LEFT JOIN adsb.faa_ac_type act
                ON act.`code` = faam.mfr_mdl_code
         LEFT JOIN adsb.faa_engines eng
                ON eng.code = faam.eng_mfr_mdl
  ORDER  BY p.time 
