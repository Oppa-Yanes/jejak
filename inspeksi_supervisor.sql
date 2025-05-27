-- inspeksi by supervisor
WITH inspection AS (
	SELECT
		bi.id,
		w.odoo_id pemanen_idx,
		i.date inspection_date,
		p.code penalty_code,
		p.description penalty_descr,
		bi.blok block,
		emp.job_level,
		emp.emp_name spv_name,
		bi.qty,
		bi.no_tph,
		bi.no_baris,
		bi.no_pokok,
		bi.description
	FROM
		blok_inspeksi bi
		LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id 
		LEFT JOIN pemanen w ON w.id = bi.pemanen_id
		LEFT JOIN penalty p ON p.id = bi.penalty_id
		LEFT JOIN users u ON u.uuid = i.user_uuid
		LEFT JOIN employee emp ON emp.id = u.odoo_id
	WHERE
		bi.category_id = 1
		AND bi.pemanen_id IS NOT NULL 
		AND bi.penalty_id IS NOT NULL
		AND bi.qty IS NOT NULL
		AND UPPER(emp.job_level) IN (
			'D - ASISTEN KEPALA',
			'E - ASISTEN',
			'F - MANDOR 1',
			'G - MANDOR'
		)
)
SELECT
	emp.estate,
	emp.job_title,
	emp.nip,
	UPPER(emp.emp_name) AS name,
	emp.division,
	ins.block,
	ins.penalty_code,
	ins.penalty_descr,
	ins.job_level,
	ins.spv_name,
	ins.qty,
	ins.inspection_date,
	ins.no_tph,
	ins.no_baris,
	ins.no_pokok,
	ins.description
FROM
	employee emp
	LEFT JOIN inspection ins ON ins.pemanen_idx = emp.id AND TO_CHAR(ins.inspection_date,'YYYYMM') = '202505'
WHERE
	NOT emp.is_deleted
	AND UPPER(emp.job_level) = 'H - NON JABATAN'
	AND UPPER(emp.job_title) ilike '%PEMANEN%'
ORDER BY
	emp.estate,
	emp.division,
	UPPER(emp.emp_name),
	ins.block,
	ins.penalty_code,
	ins.job_level DESC
;

