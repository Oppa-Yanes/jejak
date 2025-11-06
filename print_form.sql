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
	mgr.emp_name manager,
	--bi.divisi_id,
	div.name divisi,
	ass.emp_name assisten,
	--i.user_uuid,
	mandor.emp_name ||' / '|| mandor.nip mandor,
	harvester.emp_name ||' / '|| harvester.nip pemanen,
	block.code block,
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
	LEFT JOIN employee harvester ON harvester.id = bi.emp_pemanen_id 
	LEFT JOIN foreman_group fg ON fg.id = harvester.foreman_group_id 
	LEFT JOIN employee mandor ON mandor.id = fg.foreman_id 
	LEFT JOIN blok block ON block.id = bi.blok_id 
	LEFT JOIN estate est ON est.id = bi.estate_id 
	LEFT JOIN employee mgr ON mgr.id = est.estate_manager_id
	LEFT JOIN divisi div ON div.id = bi.divisi_id 
	LEFT JOIN employee ass ON ass.id = div.asisten_id 
	LEFT JOIN penalty p ON p.id = bi.penalty_id 
	JOIN condition cond ON 
		bi.category_id = cond.category_id 
		AND bi.estate_id = cond.estate_id 
		AND bi.divisi_id = cond.division_id 
		AND TO_CHAR(i.date,'YYYYMMDD') = cond.inspection_date
GROUP BY
	--bi.estate_id,
	est.name,
	mgr.emp_name,
	--bi.divisi_id,
	div.name,
	ass.emp_name,
	--i.user_uuid,
	mandor.emp_name,
	mandor.nip,
	harvester.emp_name,
	harvester.nip,
	block.code,
	bi.no_baris
ORDER BY
	mandor.emp_name,
	mandor.nip,
	harvester.emp_name,
	harvester.nip,
	block.code,
	bi.no_baris
;

-- form cetak mutu buah
WITH condition AS (
	SELECT
		11 category_id,
		3 estate_id,
		18 division_id,
		'20251022' inspection_date
)
SELECT
	bi.estate_id,
	est.name estate,
	bi.divisi_id,
	div.name divisi,
	--i.user_uuid,
	mandor.emp_name ||' / '|| mandor.nip mandor,
	kerani.emp_name ||' / '|| kerani.nip kerani,
	harvester.emp_name ||' / '|| harvester.nip pemanen,
	harvester.fp_id,
	block.code block,
	tph.code tph,
	harvester.fp_id,
	bi.ripe_qty+bi.unripe_qty+bi.rotten_qty+bi.lstalk_qty total_qty,
	bi.ripe_qty,
	bi.unripe_qty,
	bi.rotten_qty,
	bi.lstalk_qty,
	bi.loose_qty,
	bi.abnormal_01_qty,
	bi.abnormal_02_qty,
	bi.abnormal_03_qty,
	bi.abnormal_04_qty
FROM 
	blok_inspeksi bi
	LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
	LEFT JOIN users u ON u.uuid = i.user_uuid
	LEFT JOIN employee spv ON spv.id = u.odoo_id
	LEFT JOIN employee harvester ON harvester.id = bi.emp_pemanen_id 
	LEFT JOIN foreman_group fg ON fg.id = harvester.foreman_group_id 
	LEFT JOIN employee mandor ON mandor.id = fg.foreman_id 	
	LEFT JOIN employee kerani ON kerani.id = fg.kerani_id 
	LEFT JOIN blok block ON block.id = bi.blok_id 
	LEFT JOIN tph tph ON tph.id = bi.tph_id 
	LEFT JOIN estate est ON est.id = bi.estate_id 
	LEFT JOIN divisi div ON div.id = bi.divisi_id 
	LEFT JOIN penalty p ON p.id = bi.penalty_id 
	JOIN condition cond ON 
		bi.category_id = cond.category_id 
		AND bi.estate_id = cond.estate_id 
		AND bi.divisi_id = cond.division_id 
		AND TO_CHAR(i.date,'YYYYMMDD') = cond.inspection_date
WHERE
	LEFT(spv.job_level,1) IN ('A','B','C','D')
ORDER BY
	bi.estate_id,
	bi.divisi_id,
	mandor.emp_name,
	mandor.nip,
	kerani.emp_name,
	kerani.nip,
	harvester.emp_name,
	harvester.nip,
	block.code,
	tph.code
;
