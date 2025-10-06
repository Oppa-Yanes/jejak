-- Report Inspeksi Per Karyawan
select
	u.uuid,
	u.nomor_induk_pegawai AS nip,
    u.name,
    u.job_position,
    e.name estate,
    u.divisi,
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
    blok_inspeksi bi
    LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
    LEFT JOIN picture p ON p.blok_inspeksi_id = bi.id
    LEFT JOIN users u ON u.uuid = i.user_uuid
    LEFT JOIN estate e ON e.id = u.estate_id
--WHERE
----    to_char(i.date, 'YYYYMM') = '202504'
 --   and u.estate_id = 3
GROUP BY
	u.uuid,
    u.nomor_induk_pegawai,
    u.name,
    u.job_position,
    e.name,
    u.divisi
ORDER BY
    UPPER(u.name)
;

-- Cek Hasil Upload
SELECT
    u.nomor_induk_pegawai AS nip,
    u.name,
    u.job_position,
    e.name estate,
    u.divisi,
    COUNT(bi.id) jumlah_inspeksi
FROM
    blok_inspeksi bi
    LEFT JOIN inspeksi i ON i.id = bi.inspeksi_id
    LEFT JOIN picture p ON p.blok_inspeksi_id = bi.id
    LEFT JOIN users u ON u.uuid = i.user_uuid
    LEFT JOIN estate e ON e.id = u.estate_id
WHERE
    to_char(i.date, 'YYYYMM') = '202504'
    and u.estate_id = 3
GROUP BY
    u.nomor_induk_pegawai,
    u.name,
    u.job_position,
    e.name,
    u.divisi
ORDER BY
    u.name
;

