-- Download Inspeksi insight.gbs.id
SELECT 
	CASE WHEN emp.estate IS NULL THEN 'UNDEFINED' ELSE emp.estate END AS estate,
	emp.job_level,
	emp.job_title,
	emp.nip,
	UPPER(emp.emp_name) AS name,
	emp.division,
	COUNT(bi.id) jml,
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '01') AS "01",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '02') AS "02",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '03') AS "03",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '04') AS "04",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '05') AS "05",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '06') AS "06",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '07') AS "07",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '08') AS "08",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '09') AS "09",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '10') AS "10",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '11') AS "11",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '12') AS "12",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '13') AS "13",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '14') AS "14",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '15') AS "15",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '16') AS "16",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '17') AS "17",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '18') AS "18",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '19') AS "19",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '20') AS "20",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '21') AS "21",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '22') AS "22",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '23') AS "23",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '24') AS "24",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '25') AS "25",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '26') AS "26",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '27') AS "27",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '28') AS "28",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '29') AS "29",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '30') AS "30",
	COUNT(bi.id) FILTER (WHERE to_char(i.date, 'DD') = '31') AS "31"
FROM
	employee emp
	LEFT JOIN users u ON u.odoo_id = emp.id
	LEFT JOIN inspeksi i ON i.user_uuid = u.uuid
	LEFT JOIN blok_inspeksi bi ON bi.inspeksi_id = i.id AND TO_CHAR(i.date, 'YYYYMM') = '202505'
WHERE
	NOT emp.is_deleted
	AND (
		UPPER(emp.job_level) IN (
			'A - DIREKSI',
			'B - GENERAL MANAGER',
			'C - MANAGER',
			'D - ASISTEN KEPALA',
			'E - ASISTEN',
			'F - MANDOR 1',
			'G - MANDOR'
			)
		OR emp.division = 'Keamanan'
		OR emp.job_title ilike '%Quality Control%'
        )
	AND emp.foreman_group NOT IN (
		'Mandor Umum Kantor Jakarta',
		'Mandor Umum Kantor Palembang'
		)
GROUP BY 
	emp.estate,
	emp.job_level,
	emp.job_title,
	emp.nip,
	UPPER(emp.emp_name),
	emp.division
ORDER BY 
	emp.estate,
	emp.job_level,
	emp.job_title,
	COUNT(bi.id) DESC
;
