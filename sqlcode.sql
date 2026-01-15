-- ERA ADJUSTMENT
CREATE DATABASE nba;
USE nba;
CREATE TABLE reg_raw (
    player_id INT,
    player_name VARCHAR(100),
    nickname VARCHAR(50),
    team_id INT,
    team_abbreviation VARCHAR(5),
    age INT,
    gp INT,
    w INT,
    l INT,
    w_pct DECIMAL(5,4),
    min DECIMAL(6,2),
    fgm DECIMAL(6,2),
    fga DECIMAL(6,2),
    fg_pct DECIMAL(5,4),
    fg3m DECIMAL(6,2),
    fg3a DECIMAL(6,2),
    fg3_pct DECIMAL(5,4),
    ftm DECIMAL(6,2),
    fta DECIMAL(6,2),
    ft_pct DECIMAL(5,4),
    oreb DECIMAL(6,2),
    dreb DECIMAL(6,2),
    reb DECIMAL(6,2),
    ast DECIMAL(6,2),
    tov DECIMAL(6,2),
    stl DECIMAL(6,2),
    blk DECIMAL(6,2),
    blka DECIMAL(6,2),
    pf DECIMAL(6,2),
    pfd DECIMAL(6,2),
    pts DECIMAL(6,2),
    plus_minus DECIMAL(6,2),
    nba_fantasy_pts DECIMAL(7,2),
    dd2 INT,
    td3 INT,
    team_count INT,
    season VARCHAR(10)
);

CREATE TABLE off_raw (
    player_id INT,
    player_name VARCHAR(100),
    nickname VARCHAR(50),
    team_id INT,
    team_abbreviation VARCHAR(5),
    age INT,
    gp INT,
    w INT,
    l INT,
    w_pct DECIMAL(5,4),
    min DECIMAL(6,2),
    fgm DECIMAL(6,2),
    fga DECIMAL(6,2),
    fg_pct DECIMAL(5,4),
    fg3m DECIMAL(6,2),
    fg3a DECIMAL(6,2),
    fg3_pct DECIMAL(5,4),
    ftm DECIMAL(6,2),
    fta DECIMAL(6,2),
    ft_pct DECIMAL(5,4),
    oreb DECIMAL(6,2),
    dreb DECIMAL(6,2),
    reb DECIMAL(6,2),
    ast DECIMAL(6,2),
    tov DECIMAL(6,2),
    stl DECIMAL(6,2),
    blk DECIMAL(6,2),
    blka DECIMAL(6,2),
    pf DECIMAL(6,2),
    pfd DECIMAL(6,2),
    pts DECIMAL(6,2),
    plus_minus DECIMAL(6,2),
    nba_fantasy_pts DECIMAL(7,2),
    dd2 INT,
    td3 INT,
    team_count INT,
    season VARCHAR(10)
);

CREATE TABLE pof_raw (
    player_id INT,
    player_name VARCHAR(100),
    nickname VARCHAR(50),
    team_id INT,
    team_abbreviation VARCHAR(5),
    age INT,
    gp INT,
    w INT,
    l INT,
    w_pct DECIMAL(5,4),
    min DECIMAL(6,2),
    fgm DECIMAL(6,2),
    fga DECIMAL(6,2),
    fg_pct DECIMAL(5,4),
    fg3m DECIMAL(6,2),
    fg3a DECIMAL(6,2),
    fg3_pct DECIMAL(5,4),
    ftm DECIMAL(6,2),
    fta DECIMAL(6,2),
    ft_pct DECIMAL(5,4),
    oreb DECIMAL(6,2),
    dreb DECIMAL(6,2),
    reb DECIMAL(6,2),
    ast DECIMAL(6,2),
    tov DECIMAL(6,2),
    stl DECIMAL(6,2),
    blk DECIMAL(6,2),
    blka DECIMAL(6,2),
    pf DECIMAL(6,2),
    pfd DECIMAL(6,2),
    pts DECIMAL(6,2),
    plus_minus DECIMAL(6,2),
    nba_fantasy_pts DECIMAL(7,2),
    dd2 INT,
    td3 INT,
    team_count INT,
    season VARCHAR(10)
);

CREATE TABLE fp_all (
    player_id INT NOT NULL,
    season VARCHAR(10) NOT NULL,
    competition_type ENUM('REGULAR', 'PLAYOFF', 'PRESEASON') NOT NULL,

    team_id INT,
    team_abbreviation VARCHAR(5),
    age INT,

    gp INT,
    min DECIMAL(10,3),

    pts DECIMAL(10,3),
    reb DECIMAL(10,3),
    ast DECIMAL(10,3),
    stl DECIMAL(10,3),
    blk DECIMAL(10,3),
    tov DECIMAL(10,3),

    fgm DECIMAL(10,3),
    fga DECIMAL(10,3),
    fg_pct DECIMAL(6,5),

    fg3m DECIMAL(10,3),
    fg3a DECIMAL(10,3),
    fg3_pct DECIMAL(6,5),

    ftm DECIMAL(10,3),
    fta DECIMAL(10,3),
    ft_pct DECIMAL(6,5),

    oreb DECIMAL(10,3),
    dreb DECIMAL(10,3),

    pf DECIMAL(10,3),
    plus_minus DECIMAL(10,3),

    PRIMARY KEY (player_id, season, competition_type)
);

INSERT INTO fp_all(
    player_id,
    season,
    competition_type,
    team_id,
    team_abbreviation,
    age,
    gp,
    min,
    pts,
    reb,
    ast,
    stl,
    blk,
    tov,
    fgm,
    fga,
    fg_pct,
    fg3m,
    fg3a,
    fg3_pct,
    ftm,
    fta,
    ft_pct,
    oreb,
    dreb,
    pf,
    plus_minus
)
SELECT
    PLAYER_ID,
    SEASON,
    'REGULAR',
    TEAM_ID,
    TEAM_ABBREVIATION,
    AGE,
    GP,
    MIN,
    PTS,
    REB,
    AST,
    STL,
    BLK,
    TOV,
    FGM,
    FGA,
    FG_PCT,
    FG3M,
    FG3A,
    FG3_PCT,
    FTM,
    FTA,
    FT_PCT,
    OREB,
    DREB,
    PF,
    PLUS_MINUS
FROM reg_raw
WHERE GP > 0;


INSERT INTO fp_all(
    player_id,
    season,
    competition_type,
    team_id,
    team_abbreviation,
    age,
    gp,
    min,
    pts,
    reb,
    ast,
    stl,
    blk,
    tov,
    fgm,
    fga,
    fg_pct,
    fg3m,
    fg3a,
    fg3_pct,
    ftm,
    fta,
    ft_pct,
    oreb,
    dreb,
    pf,
    plus_minus
)
SELECT
    PLAYER_ID,
    SEASON,
    'PLAYOFF',
    TEAM_ID,
    TEAM_ABBREVIATION,
    AGE,
    GP,
    MIN,
    PTS,
    REB,
    AST,
    STL,
    BLK,
    TOV,
    FGM,
    FGA,
    FG_PCT,
    FG3M,
    FG3A,
    FG3_PCT,
    FTM,
    FTA,
    FT_PCT,
    OREB,
    DREB,
    PF,
    PLUS_MINUS
FROM off_raw
WHERE GP > 0;

CREATE VIEW season_bl AS
SELECT
    season,
    COUNT(DISTINCT player_id) AS player_count,
    SUM(gp) AS total_games,
    SUM(pts) / SUM(gp) AS avg_ppg,
    SUM(reb) / SUM(gp) AS avg_rpg,
    SUM(ast) / SUM(gp) AS avg_apg,
    AVG(fg_pct) AS avg_fgp,
    AVG(fg3_pct) AS avg_fg3p,
    AVG(ft_pct) AS avg_ftp,
    AVG(
      CASE 
        WHEN fga > 0 THEN fg3a / fga 
        ELSE NULL 
      END
    ) AS avg_3pt_rate,
    SUM(tov) / SUM(gp) AS avg_tov_pg,
    SUM(pf) / SUM(gp) AS avg_pf_pg
FROM fp_all
WHERE competition_type = 'REGULAR'
  AND gp >= 20
GROUP BY season;

CREATE VIEW player_era_adj AS
SELECT
    p.player_id,
    p.season,
    p.team_abbreviation,
    p.gp,
    p.pts / p.gp AS ppg,
    l.avg_ppg AS lg_ppg,
    (p.pts / p.gp) / l.avg_ppg AS ppg_idx,
    p.reb / p.gp AS rpg,
    l.avg_rpg AS lg_rpg,
    (p.reb / p.gp) / l.avg_rpg AS rpg_idx,
    p.ast / p.gp AS apg,
    l.avg_apg AS lg_apg,
    (p.ast / p.gp) / l.avg_apg AS apg_idx
FROM fp_all p
JOIN season_bl l
  ON p.season = l.season
WHERE p.competition_type = 'REGULAR'
  AND p.gp >= 20;

CREATE VIEW season_env_delta AS
SELECT
    season,
    avg_ppg,
    avg_fg3p,
    avg_3pt_rate,
    avg_ppg - LAG(avg_ppg) OVER (ORDER BY season) AS d_ppg,
    avg_fg3p - LAG(avg_fg3p) OVER (ORDER BY season) AS d_fg3p,
    avg_3pt_rate - LAG(avg_3pt_rate) OVER (ORDER BY season) AS d_3pt_rate
FROM season_bl;

CREATE VIEW season_era AS
SELECT
    season,
    CASE
        WHEN season < '2004-05' THEN 'ERA_1'
        WHEN season < '2014-15' THEN 'ERA_2'
        ELSE 'ERA_3'
    END AS era
FROM season_bl;

SELECT
    e.era,
    AVG(b.avg_ppg) AS era_avg_ppg,
    AVG(b.avg_fg3p) AS era_avg_fg3p,
    AVG(b.avg_3pt_rate) AS era_avg_3pt_rate
FROM season_bl b
JOIN season_era e
  ON b.season = e.season
GROUP BY e.era
ORDER BY era_avg_ppg;

CREATE VIEW era_profile AS
SELECT
    e.era,
    COUNT(*) AS seasons_in_era,
    AVG(b.avg_ppg) AS era_avg_ppg,
    STDDEV(b.avg_ppg) AS era_ppg_sd,
    AVG(b.avg_rpg) AS era_avg_rpg,
    AVG(b.avg_apg) AS era_avg_apg,
    AVG(b.avg_fg3p) AS era_avg_fg3p,
    AVG(b.avg_3pt_rate) AS era_avg_3pt_rate,
    AVG(b.avg_tov_pg) AS era_avg_tov_pg,
    AVG(b.avg_pf_pg) AS era_avg_pf_pg

FROM season_bl b
JOIN season_era e
  ON b.season = e.season
GROUP BY e.era;

SELECT
    100 * (b.era_avg_ppg - a.era_avg_ppg) / a.era_avg_ppg AS ppg_change_1_2,
    100 * (c.era_avg_ppg - b.era_avg_ppg) / b.era_avg_ppg AS ppg_change_2_3,
    100 * (c.era_avg_ppg - a.era_avg_ppg) / a.era_avg_ppg AS ppg_change_1_3,
    100 * (b.era_avg_3pt_rate - a.era_avg_3pt_rate) / a.era_avg_3pt_rate AS three_pt_rate_change_1_2,
    100 * (c.era_avg_3pt_rate - b.era_avg_3pt_rate) / b.era_avg_3pt_rate AS three_pt_rate_change_2_3,
    100 * (c.era_avg_3pt_rate - a.era_avg_3pt_rate) / a.era_avg_3pt_rate AS three_pt_rate_change_1_3
FROM era_profile a
CROSS JOIN era_profile b
CROSS JOIN era_profile c
WHERE a.era = 'ERA_1'
  AND b.era = 'ERA_2'
  AND c.era = 'ERA_3';



-- PLAYER ERA ADJUSTMENTS
CREATE VIEW player_era_adj_labeled AS
SELECT
    p.player_id,
    p.season,
    e.era,
    p.team_abbreviation,
    p.gp,
    p.ppg,
    p.lg_ppg,
    p.ppg_idx,
    p.rpg,
    p.lg_rpg,
    p.rpg_idx,
    p.apg,
    p.lg_apg,
    p.apg_idx

FROM player_era_adj p
JOIN season_era e
  ON p.season = e.season;

CREATE VIEW player_season_dom AS
SELECT
    player_id,
    season,
    era,
    gp,
    ppg_idx,
    rpg_idx,
    apg_idx,
    (
        0.5 * ppg_idx +
        0.25 * rpg_idx +
        0.25 * apg_idx
    ) AS dom_idx

FROM player_era_adj_labeled;

SELECT
    c.player_id,
    n.player_name,
    c.seasons_played,
    c.career_gp,
    c.weighted_dom_idx,
    p.peak_dom,
    c.dom_volatility
FROM player_career_dom c
JOIN (
    SELECT
        player_id,
        MAX(dom_idx) AS peak_dom
    FROM player_season_dom
    GROUP BY player_id
) p
  ON c.player_id = p.player_id
JOIN (
    SELECT
        player_id,
        MAX(player_name) AS player_name
    FROM reg_raw
    GROUP BY player_id
) n
  ON c.player_id = n.player_id
ORDER BY c.weighted_dom_idx DESC;


SELECT
    e.player_id,
    n.player_name,
    COUNT(DISTINCT e.era) AS eras_played,
    COUNT(DISTINCT e.season) AS seasons_played,
    SUM(e.gp) AS career_gp
FROM player_season_dom e
JOIN (
    SELECT
        player_id,
        MAX(player_name) AS player_name
    FROM reg_raw
    GROUP BY player_id
) n
  ON e.player_id = n.player_id
GROUP BY e.player_id, n.player_name
ORDER BY eras_played DESC, seasons_played DESC, career_gp DESC;

-- PLAYOFF STATISTICS

CREATE VIEW player_playoff_era_adj AS
SELECT
    p.player_id,
    p.season,
    -- raw playoff per-game
    p.pts / p.gp AS po_ppg,
    p.reb / p.gp AS po_rpg,
    p.ast / p.gp AS po_apg,
    -- regular-season baselines
    l.avg_ppg AS lg_ppg,
    l.avg_rpg AS lg_rpg,
    l.avg_apg AS lg_apg,
    -- era-adjusted playoff indices
    (p.pts / p.gp) / l.avg_ppg AS po_ppg_idx,
    (p.reb / p.gp) / l.avg_rpg AS po_rpg_idx,
    (p.ast / p.gp) / l.avg_apg AS po_apg_idx,
    p.gp AS po_gp
FROM fp_all p
JOIN season_bl l
  ON p.season = l.season
WHERE p.competition_type = 'PLAYOFF'
  AND p.gp >= 5;


CREATE VIEW player_playoff_translation AS
SELECT
    r.player_id,
    r.season,
    r.era,
    -- regular season indices
    r.ppg_idx AS reg_ppg_idx,
    r.rpg_idx AS reg_rpg_idx,
    r.apg_idx AS reg_apg_idx,
    -- playoff indices
    p.po_ppg_idx,
    p.po_rpg_idx,
    p.po_apg_idx,
    -- translation deltas
    p.po_ppg_idx - r.ppg_idx AS ppg_translation,
    p.po_rpg_idx - r.rpg_idx AS rpg_translation,
    p.po_apg_idx - r.apg_idx AS apg_translation,
    p.po_gp
FROM player_era_adj_labeled r
JOIN player_playoff_era_adj p
  ON r.player_id = p.player_id
 AND r.season    = p.season;

CREATE VIEW player_career_playoff_translation AS
SELECT
    player_id,
    COUNT(*) AS playoff_seasons,
    SUM(po_gp) AS playoff_gp,
    AVG(ppg_translation) AS avg_ppg_translation,
    AVG(rpg_translation) AS avg_rpg_translation,
    AVG(apg_translation) AS avg_apg_translation,
    (
        0.5 * AVG(ppg_translation) +
        0.25 * AVG(rpg_translation) +
        0.25 * AVG(apg_translation)
    ) AS playoff_translation_idx
FROM player_playoff_translation
GROUP BY player_id
HAVING SUM(po_gp) >= 20;

SELECT
    t.player_id,
    n.player_name,
    100*(t.playoff_translation_idx) AS playoff_translation_idx,
    t.playoff_gp,
    t.playoff_seasons
FROM player_career_playoff_translation t
JOIN (
    SELECT
        player_id,
        MAX(player_name) AS player_name
    FROM reg_raw
    GROUP BY player_id
) n
  ON t.player_id = n.player_id
ORDER BY playoff_translation_idx DESC;


CREATE VIEW po_era_adj AS
SELECT
    p.player_id,
    p.season,
    -- playoff per-game
    p.pts / p.gp AS po_ppg,
    p.reb / p.gp AS po_rpg,
    p.ast / p.gp AS po_apg,
    -- regular-season baselines
    b.avg_ppg AS lg_ppg,
    b.avg_rpg AS lg_rpg,
    b.avg_apg AS lg_apg,
    -- era-adjusted playoff indices
    (p.pts / p.gp) / b.avg_ppg AS po_ppg_idx,
    (p.reb / p.gp) / b.avg_rpg AS po_rpg_idx,
    (p.ast / p.gp) / b.avg_apg AS po_apg_idx,
    p.gp AS po_gp
FROM fp_all p
JOIN season_bl b
  ON p.season = b.season
WHERE p.competition_type = 'PLAYOFF'
  AND p.gp >= 5;   -- minimum stability threshold


CREATE VIEW po_translation AS
SELECT
    r.player_id,
    r.season,
    r.era,
    -- regular indices
    r.ppg_idx AS reg_ppg_idx,
    r.rpg_idx AS reg_rpg_idx,
    r.apg_idx AS reg_apg_idx,
    -- playoff indices
    p.po_ppg_idx,
    p.po_rpg_idx,
    p.po_apg_idx,
    -- translation (playoff minus regular)
    p.po_ppg_idx - r.ppg_idx AS ppg_tr,
    p.po_rpg_idx - r.rpg_idx AS rpg_tr,
    p.po_apg_idx - r.apg_idx AS apg_tr,
    p.po_gp
FROM player_era_adj_labeled r
JOIN po_era_adj p
  ON r.player_id = p.player_id
 AND r.season    = p.season;


SELECT
    COUNT(*) AS "rows",
    COUNT(DISTINCT player_id) AS players,
    SUM(po_gp) AS total_po_gp
FROM po_translation;


SELECT
    AVG(ppg_tr) AS mean_ppg_tr,
    AVG(rpg_tr) AS mean_rpg_tr,
    AVG(apg_tr) AS mean_apg_tr,
    STDDEV(ppg_tr) AS sd_ppg_tr,
    STDDEV(rpg_tr) AS sd_rpg_tr,
    STDDEV(apg_tr) AS sd_apg_tr
FROM po_translation;


SELECT
    CASE
        WHEN po_gp < 10 THEN 'LOW_GP'
        WHEN po_gp < 30 THEN 'MID_GP'
        ELSE 'HIGH_GP'
    END AS gp_bucket,
    COUNT(*) AS rows,
    STDDEV(ppg_tr) AS sd_ppg_tr
FROM po_translation
GROUP BY gp_bucket
ORDER BY gp_bucket;


SELECT
    CASE
        WHEN STDDEV_POP(reg_ppg_idx) = 0 OR STDDEV_POP(po_ppg_idx) = 0
        THEN NULL
        ELSE
            (AVG(reg_ppg_idx * po_ppg_idx)- AVG(reg_ppg_idx) * AVG(po_ppg_idx)) /
            (STDDEV_POP(reg_ppg_idx) * STDDEV_POP(po_ppg_idx))
    END AS corr_ppg,
    CASE
        WHEN STDDEV_POP(reg_rpg_idx) = 0 OR STDDEV_POP(po_rpg_idx) = 0
        THEN NULL
        ELSE
            (AVG(reg_rpg_idx * po_rpg_idx)- AVG(reg_rpg_idx) * AVG(po_rpg_idx)) /
            (STDDEV_POP(reg_rpg_idx) * STDDEV_POP(po_rpg_idx))
    END AS corr_rpg,
    CASE
        WHEN STDDEV_POP(reg_apg_idx) = 0 OR STDDEV_POP(po_apg_idx) = 0
        THEN NULL
        ELSE
            (AVG(reg_apg_idx * po_apg_idx)- AVG(reg_apg_idx) * AVG(po_apg_idx)) /
            (STDDEV_POP(reg_apg_idx) * STDDEV_POP(po_apg_idx))
    END AS corr_apg
FROM po_translation;


SELECT
    era,
    AVG(ppg_tr) AS mean_ppg_tr,
    STDDEV(ppg_tr) AS sd_ppg_tr
FROM po_translation
GROUP BY era
ORDER BY era;

-- PRESEASON STATISTICS

INSERT INTO fp_all(
    player_id,
    season,
    competition_type,
    team_id,
    team_abbreviation,
    age,
    gp,
    min,
    pts,
    reb,
    ast,
    stl,
    blk,
    tov,
    fgm,
    fga,
    fg_pct,
    fg3m,
    fg3a,
    fg3_pct,
    ftm,
    fta,
    ft_pct,
    oreb,
    dreb,
    pf,
    plus_minus
)
SELECT
    PLAYER_ID,
    SEASON,
    'PRESEASON',
    TEAM_ID,
    TEAM_ABBREVIATION,
    AGE,
    GP,
    MIN,
    PTS,
    REB,
    AST,
    STL,
    BLK,
    TOV,
    FGM,
    FGA,
    FG_PCT,
    FG3M,
    FG3A,
    FG3_PCT,
    FTM,
    FTA,
    FT_PCT,
    OREB,
    DREB,
    PF,
    PLUS_MINUS
FROM pre_raw
WHERE GP > 0;


CREATE VIEW pre_pg AS
SELECT
    player_id,
    season,
    pts / gp AS pre_ppg,
    reb / gp AS pre_rpg,
    ast / gp AS pre_apg,
    gp AS pre_gp
FROM fp_all
WHERE competition_type = 'PRESEASON'
  AND gp >= 3;


CREATE VIEW pre_vs_reg AS
SELECT
    r.player_id,
    r.season,
    r.era,
    -- regular season indices (era-adjusted)
    r.ppg_idx AS reg_ppg_idx,
    r.rpg_idx AS reg_rpg_idx,
    r.apg_idx AS reg_apg_idx,
    -- preseason raw per-game
    p.pre_ppg,
    p.pre_rpg,
    p.pre_apg,
    p.pre_gp
FROM player_era_adj_labeled r
JOIN pre_pg p
  ON r.player_id = p.player_id
 AND r.season    = p.season;


CREATE VIEW pre_era_adj AS
SELECT
    x.player_id,
    x.season,
    x.era,
    -- preseason indices
    x.pre_ppg / b.avg_ppg AS pre_ppg_idx,
    x.pre_rpg / b.avg_rpg AS pre_rpg_idx,
    x.pre_apg / b.avg_apg AS pre_apg_idx,
    -- regular indices
    x.reg_ppg_idx,
    x.reg_rpg_idx,
    x.reg_apg_idx,
    x.pre_gp
FROM pre_vs_reg x
JOIN season_bl b
  ON x.season = b.season;


CREATE VIEW pre_error AS
SELECT
    player_id,
    season,
    era,
    pre_ppg_idx - reg_ppg_idx AS ppg_err,
    pre_rpg_idx - reg_rpg_idx AS rpg_err,
    pre_apg_idx - reg_apg_idx AS apg_err,
    pre_gp
FROM pre_era_adj;
