---
--- GPU Cache Functions
---
CREATE FUNCTION pgstrom.gpucache_recovery(regclass)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_gpucache_recovery'
  LANGUAGE C CALLED ON NULL INPUT;

---
--- Portable Shared Memory
---
CREATE FUNCTION pgstrom.shared_buffer_info()
  RETURNS json
  AS 'MODULE_PATHNAME','pgstrom_shared_buffer_info'
  LANGUAGE C STRICT;

---
--- Hyper-Log-Log COUNT(distinct) support
---
CREATE FUNCTION pgstrom.hll_hash(int1)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_int1'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, int1)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_int1'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(int2)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_int2'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, int2)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_int2'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(int4)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_int4'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, int4)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_int4'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(int8)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_int8'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, int8)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_int8'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(numeric)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_numeric'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, numeric)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_numeric'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(date)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_date'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, date)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_date'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(time)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_time'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, time)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_time'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(timetz)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_timetz'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, timetz)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_timetz'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(timestamp)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_timestamp'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, timestamp)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_timestamp'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(timestamptz)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_timestamptz'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, timestamptz)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_timestamptz'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(bpchar)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_bpchar'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, bpchar)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_bpchar'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(text)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_varlena'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, text)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_varlena'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_hash(uuid)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_hash_uuid'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_update(bytea, uuid)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_count_update_uuid'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_pcount(bigint)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_pcount'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_combined(bytea, bytea)
  RETURNS bytea
  AS 'MODULE_PATHNAME','pgstrom_hll_combined'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE FUNCTION pgstrom.hll_count_final(bytea)
  RETURNS bigint
  AS 'MODULE_PATHNAME','pgstrom_hll_count_final'
  LANGUAGE C CALLED ON NULL INPUT PARALLEL SAFE;

CREATE AGGREGATE pgstrom.hll_count(bytea)
(
  sfunc = pgstrom.hll_combined,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(int1)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(int2)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(int4)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(int8)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(numeric)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(date)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(time)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(timetz)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(timestamp)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(timestamptz)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(bpchar)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(text)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

CREATE AGGREGATE pg_catalog.hll_count(uuid)
(
  sfunc = pgstrom.hll_count_update,
  stype = bytea,
  finalfunc = pgstrom.hll_count_final,
  parallel = safe
);

---
--- Re-define of VARIANCE/STDDEV
---
CREATE FUNCTION pgstrom.float8_combine(float8[], float8[])
  RETURNS float8[]
  AS 'MODULE_PATHNAME','pgstrom_float8_combine'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_stddev_samp(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_stddev_samp'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_stddev_pop(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_stddev_pop'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_var_samp(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_var_samp'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_var_pop(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_var_pop'
  LANGUAGE C STRICT PARALLEL SAFE;

DROP AGGREGATE IF EXISTS pgstrom.stddev(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.stddev_numeric(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.stddev_pop(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.stddev_pop_numeric(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.stddev_samp(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.stddev_samp_numeric(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.variance(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.variance_numeric(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.var_pop(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.var_pop_numeric(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.var_samp(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.var_samp_numeric(float8[]);

CREATE AGGREGATE pgstrom.stddev(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  finalfunc = pgstrom.float8_stddev_samp,
  parallel = safe
);

CREATE AGGREGATE pgstrom.stddev_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  finalfunc = pgstrom.float8_stddev_samp_numeric,
  parallel = safe
);

CREATE AGGREGATE pgstrom.stddev_pop(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_stddev_pop,
  parallel = safe
);

CREATE AGGREGATE pgstrom.stddev_pop_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_stddev_pop_numeric,
  parallel = safe
);

CREATE AGGREGATE pgstrom.stddev_samp(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_stddev_samp,
  parallel = safe
);

CREATE AGGREGATE pgstrom.stddev_samp_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_stddev_samp_numeric,
  parallel = safe
);

CREATE AGGREGATE pgstrom.variance(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_samp,
  parallel = safe
);

CREATE AGGREGATE pgstrom.variance_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_samp_numeric,
  parallel = safe
);

CREATE AGGREGATE pgstrom.var_pop(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_pop,
  parallel = safe
);

CREATE AGGREGATE pgstrom.var_pop_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_pop_numeric,
  parallel = safe
);

CREATE AGGREGATE pgstrom.var_samp(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_samp,
  parallel = safe
);

CREATE AGGREGATE pgstrom.var_samp_numeric(float8[])
(
  sfunc = pgstrom.float8_combine,
  stype = float8[],
  initcond = "{0,0,0}",
  finalfunc = pgstrom.float8_var_samp_numeric,
  parallel = safe
);

---
--- Re-define of COVAR/REGR_*
---
CREATE FUNCTION pgstrom.float8_regr_combine(float8[], float8[])
  RETURNS float8[]
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_combine'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_corr(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_corr'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_covar_pop(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_covar_pop'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_covar_samp(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_covar_samp'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_avgx(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_avgx'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_avgy(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_avgy'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_intercept(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_intercept'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_r2(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_r2'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_slope(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_slope'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_sxx(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_sxx'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_syy(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_syy'
  LANGUAGE C STRICT PARALLEL SAFE;

CREATE FUNCTION pgstrom.float8_regr_sxy(float8[])
  RETURNS float8
  AS 'MODULE_PATHNAME','pgstrom_float8_regr_sxy'
  LANGUAGE C STRICT PARALLEL SAFE;

DROP AGGREGATE IF EXISTS pgstrom.corr(float8[]);;
DROP AGGREGATE IF EXISTS pgstrom.covar_pop(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.covar_samp(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_avgx(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_avgy(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_intercept(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_r2(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_slope(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_sxx(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_sxy(float8[]);
DROP AGGREGATE IF EXISTS pgstrom.regr_syy(float8[]);

CREATE AGGREGATE pgstrom.corr(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_corr,
  parallel = safe
);

CREATE AGGREGATE pgstrom.covar_pop(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_covar_pop,
  parallel = safe
);

CREATE AGGREGATE pgstrom.covar_samp(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_covar_samp,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_avgx(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_avgx,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_avgy(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_avgy,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_intercept(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_intercept,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_r2(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_r2,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_slope(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_slope,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_sxx(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_sxx,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_sxy(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_sxy,
  parallel = safe
);

CREATE AGGREGATE pgstrom.regr_syy(float8[])
(
  sfunc = pgstrom.float8_regr_combine,
  stype = float8[],
  initcond = "{0,0,0,0,0,0}",
  finalfunc = pgstrom.float8_regr_syy,
  parallel = safe
);

---
--- Deprecated Functions
---
DROP FUNCTION IF EXISTS pgstrom.arrow_fdw_export_cupy(regclass, text[], int);
DROP FUNCTION IF EXISTS pgstrom.arrow_fdw_export_cupy_pinned(regclass, text[], int);
DROP FUNCTION IF EXISTS pgstrom.arrow_fdw_unpin_gpu_buffer(text);
DROP FUNCTION IF EXISTS pgstrom.arrow_fdw_put_gpu_buffer(text);