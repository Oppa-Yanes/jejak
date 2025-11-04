-- form cetak mutu ancak
WITH condition AS (
	SELECT
		10 category_id,
		1 estate_id,
		4 division_id,
		'20251022' inspection_date
)
SELECT
	--bi.estate_id,
	est.name estate,
	--bi.divisi_id,
	div.name divisi,
	--i.user_uuid,
	u.name ||' / '|| u.nomor_induk_pegawai mandor,
	e.emp_name ||' / '|| e.nip harverster,
	b.code block,
	bi.no_baris,
	--p.code penalty,
	--bi.qty penalty_amt
	COALESCE(SUM(CASE WHEN p.code = 'P00' THEN 1 END), 0) AS P00,
	COALESCE(SUM(CASE WHEN p.code = 'P01' THEN bi.qty END), 0) AS P01,
	COALESCE(SUM(CASE WHEN p.code = 'P02' THEN bi.qty END), 0) AS P02,
	COALESCE(SUM(CASE WHEN p.code = 'P03' THEN bi.qty END), 0) AS P03,
	COALESCE(SUM(CASE WHEN p.code = 'P04' THEN bi.qty END), 0) AS P04,	
	COALESCE(SUM(CASE WHEN p.code = 'P05' THEN bi.qty END), 0) AS P05,	
	COALESCE(SUM(CASE WHEN p.code = 'P06' THEN bi.qty END), 0) AS P06,	
	COALESCE(SUM(CASE WHEN p.code = 'P07' THEN bi.qty END), 0) AS P07	
FROM 
	blok_inspeksi bi
	LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
	LEFT JOIN users u ON u.uuid = i.user_uuid
	LEFT JOIN employee e ON e.id = bi.emp_pemanen_id 
	LEFT JOIN blok b ON b.id = bi.blok_id 
	LEFT JOIN estate est ON est.id = bi.estate_id 
	LEFT JOIN divisi div ON div.id = bi.divisi_id 
	LEFT JOIN penalty p ON p.id = bi.penalty_id 
	JOIN condition cond ON 
		bi.category_id = cond.category_id 
		AND bi.estate_id = cond.estate_id 
		AND bi.divisi_id = cond.division_id 
		AND TO_CHAR(i.date,'YYYYMMDD') = cond.inspection_date
GROUP BY
	--bi.estate_id,
	est.name,
	--bi.divisi_id,
	div.name,
	--i.user_uuid,
	u.name,
	u.nomor_induk_pegawai,
	e.emp_name,
	e.nip,
	b.code,
	bi.no_baris
ORDER BY
	u.name,
	u.nomor_induk_pegawai,
	e.emp_name,
	e.nip,
	b.code,
	bi.no_baris
;
