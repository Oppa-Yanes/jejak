-- CEK INSTALASI VERSI 2.26
WITH inspeksi AS (
	SELECT
		i.user_uuid,
		MAX(TO_CHAR(i.date,'YYYY-MM-DD') || ' ' || TO_CHAR(bi.time,'HH24:MI')) AS date
	FROM
		blok_inspeksi bi
		LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
	WHERE
		bi.description ILIKE '%instalasi%'
		OR bi.description ILIKE '%test%'
	GROUP BY
		i.user_uuid
)
SELECT
	u.name,
	u.job_position,
	u.device_model,
	i.date
FROM
	users u
	LEFT JOIN inspeksi i ON i.user_uuid = u.uuid
WHERE
	u.device_model IS NOT NULL
ORDER BY
	i.date desc
;


/*
select 
	*
from
	blok_inspeksi bi
	left join inspeksi i on i.id = bi.inspeksi_id 
	left join users u on u.uuid = i.user_uuid
where
	u.divisi = 'TRAKSI'


select * from blok_inspeksi where inspeksi_id in (select id from inspeksi where user_uuid = '5d6bef02-3d6f-4d2f-9dac-44633187b4ca')
--update blok_inspeksi set category_id = 5 where inspeksi_id in (select id from inspeksi where user_uuid = '5d6bef02-3d6f-4d2f-9dac-44633187b4ca')
*/


select
	*
from
	blok_inspeksi bi
	left join inspeksi i on i.id = bi.inspeksi_id
	left join picture p on p.blok_inspeksi_id = bi.id
	left join users u on u.uuid = i.user_uuid
where
	u.name = 'AKIP RAHMAD'
;


delete from picture where blok_inspeksi_id in (
	select distinct
		bi.id
	from
		blok_inspeksi bi
		left join inspeksi i on i.id = bi.inspeksi_id
		left join users u on u.uuid = i.user_uuid
	where
		u.name = 'AKIP RAHMAD'
);

delete from blok_inspeksi where id in (
	select distinct
		bi.id
	from
		blok_inspeksi bi
		left join inspeksi i on i.id = bi.inspeksi_id 
		left join users u on u.uuid = i.user_uuid
	where
		u.name = 'AKIP RAHMAD'
);

delete from inspeksi where id in (
	select distinct
		i.id
	from
		inspeksi i
		left join users u on u.uuid = i.user_uuid
	where
		u.name = 'AKIP RAHMAD'
);


update blok_inspeksi set category_id = 5
where id in (
	select distinct
		bi.id
	from
		blok_inspeksi bi
		left join inspeksi i on i.id = bi.inspeksi_id
		left join users u on u.uuid = i.user_uuid
	where
		u.name = 'Devi Hermansa'
);

-- jumlah inspeksi per bulan
SELECT
	TO_CHAR(i.date, 'YYYYMM') periode,
	COUNT(bi.*) inspeksi_cnt
FROM 
	blok_inspeksi bi
	LEFT JOIN inspeksi i on i.id = bi.inspeksi_id
	LEFT JOIN users u on u.uuid = i.user_uuid
WHERE 
	TO_CHAR(i.date, 'YYYYMM') >= '202504'
GROUP BY
	TO_CHAR(i.date, 'YYYYMM')
ORDER BY
	TO_CHAR(i.date, 'YYYYMM')
;

-- pareto per bulan
SELECT
	TO_CHAR(i.date, 'YYYYMM') periode,
	c.name category,
	COUNT(bi.*) jml_inspeksi
FROM 
	blok_inspeksi bi
	LEFT JOIN inspeksi i on i.id = bi.inspeksi_id
	LEFT JOIN users u on u.uuid = i.user_uuid
	left join category c on c.id = bi.category_id
	LEFT JOIN estate e ON e.id = i.estate_id
WHERE 
	TO_CHAR(i.date, 'YYYYMM') >= '202510'
	--AND e.company_id = 2
GROUP BY
	TO_CHAR(i.date, 'YYYYMM'),
	c.name
ORDER BY
	TO_CHAR(i.date, 'YYYYMM'),
	COUNT(bi.*) DESC
;

-- jumlah device by merek
WITH device AS (
	SELECT
		SPLIT_PART(u.device_model, ' ', 1) AS device_brand,
		SPLIT_PART(u.device_model, ' ', 2) || ' - ' || SPLIT_PART(u.device_model, ' ', 3) AS device_type
	FROM 
		users u
		LEFT JOIN inspeksi i ON i.user_uuid = u.uuid
	WHERE 
		TO_CHAR(i.date, 'YYYYMM') >= '202504'
		AND i.id IS NOT NULL
		AND u.device_model IS NOT NULL
		AND u.device_model <> ''
)
SELECT
	UPPER(d.device_brand) device_brand,
	COUNT(DISTINCT d.device_type) jml_device
FROM
	device d
GROUP BY
	d.device_brand
ORDER BY
	jml_device DESC;


