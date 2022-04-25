/*
 * xpu_textlib.h
 *
 * Misc definitions for xPU(GPU/DPU/SPU).
 * --
 * Copyright 2011-2022 (C) KaiGai Kohei <kaigai@kaigai.gr.jp>
 * Copyright 2014-2022 (C) PG-Strom Developers Team
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the PostgreSQL License.
 */
#ifndef XPU_TEXTLIB_H
#define XPU_TEXTLIB_H

#define PGSTROM_VARLENA_DEVTYPE_TEMPLATE(NAME)							\
	PUBLIC_FUNCTION(bool)												\
	sql_##NAME##_datum_ref(kern_context *kcxt,							\
						   sql_##NAME##_t *result,						\
						   void *addr)									\
	{																	\
		if (!addr)														\
			result->isnull = true;										\
		else															\
		{																\
			result->isnull = false;										\
			result->length = -1;										\
			result->value = addr;										\
		}																\
		return true;													\
	}																	\
	PUBLIC_FUNCTION(bool)												\
	sql_##NAME##_param_ref(kern_context *kcxt,							\
						   sql_##NAME##_t *result,						\
						   uint32_t param_id)							\
	{																	\
		void   *addr = kparam_get_value(kcxt->kparams, param_id);		\
																		\
		return sql_##NAME##_datum_ref(kcxt, result, addr);				\
	}																	\
	PUBLIC_FUNCTION(bool)												\
	arrow_##NAME##_datum_ref(kern_context *kcxt,						\
							 sql_##NAME##_t *result,					\
							 kern_data_store *kds,						\
							 kern_colmeta *cmeta,						\
							 uint32_t rowidx)							\
	{																	\
		void	   *addr;												\
		uint32_t	len;												\
																		\
		addr = KDS_ARROW_REF_VARLENA_DATUM(kds, cmeta, rowidx, &len);	\
		if (!addr)														\
			result->isnull = true;										\
		else															\
		{																\
			result->isnull = false;										\
			result->length = len;										\
			result->value  = addr;										\
		}																\
		return true;													\
	}																	\
	PUBLIC_FUNCTION(int)												\
	sql_##NAME##_datum_store(kern_context *kcxt,						\
							 char *buffer,								\
							 sql_##NAME##_t *datum)						\
	{																	\
		char   *data;													\
		int		len;													\
																		\
		if (datum->isnull)												\
			return 0;													\
		if (datum->length < 0)											\
		{																\
			data = VARDATA_ANY(datum->value);							\
			len = VARSIZE_ANY_EXHDR(datum->value);						\
		}																\
		else															\
		{																\
			data = datum->value;										\
			len = datum->length;										\
		}																\
		if (buffer)														\
		{																\
			memcpy(buffer + VARHDRSZ, data, len);						\
			SET_VARSIZE(buffer, len + VARHDRSZ);						\
		}																\
		 return len + VARHDRSZ;											\
	}																	\
	bool																\
	sql_##NAME##_hash(kern_context*kcxt,								\
					  uint32_t *p_hash,									\
					  sql_##NAME##_t*datum)								\
	{																	\
		if (datum->isnull)												\
			*p_hash = 0;												\
		else if (datum->length >= 0)									\
			*p_hash = pg_hash_any(datum->value, datum->length);			\
		else if (!VARATT_IS_COMPRESSED(datum->value) &&					\
				 !VARATT_IS_EXTERNAL(datum->value))						\
			*p_hash = pg_hash_any(VARDATA_ANY(datum->value),			\
								  VARSIZE_ANY_EXHDR(datum->value));		\
		else															\
		{																\
			STROM_CPU_FALLBACK(kcxt, ERRCODE_STROM_VARLENA_UNSUPPORTED,	\
							   #NAME " datum is compressed or external"); \
			return false;												\
		}																\
		return true;													\
	}

PGSTROM_VARLENA_DEVTYPE_DECLARATION(bytea)
PGSTROM_VARLENA_DEVTYPE_DECLARATION(text)
PGSTROM_VARLENA_DEVTYPE_DECLARATION(bpchar)

#endif  /* XPU_TEXTLIB_H */
