-- cek users vs employee by nik
SELECT DISTINCT
	u.odoo_id,
	u.nomor_induk_pegawai nip_jejak,
	emp.nip nip_odoo,
	u.nomor_induk_pegawai = emp.nip nip_sama,
	upper(u.name) nama_jejak,
	upper(emp.emp_name) nama_odoo,
	upper(u.name) = upper(emp.emp_name) nama_sama
FROM
    blok_inspeksi bi
    LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
    LEFT JOIN users u ON u.uuid = i.user_uuid
    LEFT JOIN estate e ON e.id = u.estate_id
    LEFT JOIN employee emp ON emp.id = u.odoo_id 
WHERE 
	u.nomor_induk_pegawai = emp.nip
ORDER BY
	u.nomor_induk_pegawai,
	upper(u.name);


