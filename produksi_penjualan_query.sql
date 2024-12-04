WITH produksi_filtered AS (
  SELECT 
    id_produk, 
    id_produksi, 
    DATE(tanggal_produksi) AS tanggal_produksi -- Pastikan kolom tanggal_produksi dapat dikonversi ke DATE
  FROM 
    `satria-rizki-ramadhani.Satria_Company.tabel_produksi`
  WHERE 
    MOD(id_produksi, 2) = 0 -- Filter hanya id_produksi bernomor genap
    AND DATE(tanggal_produksi) BETWEEN '2024-01-08' AND '2024-01-27'
),
penjualan_filtered AS (
  SELECT 
    id_produk, 
    SUM(jumlah_terjual) AS total_jumlah_terjual
  FROM 
    `satria-rizki-ramadhani.Satria_Company.tabel_penjualan`
  WHERE 
    DATE(tanggal_penjualan) BETWEEN '2024-01-08' AND '2024-01-27'
  GROUP BY 
    id_produk
)
SELECT 
  pf.id_produk, 
  pf.id_produksi, 
  pf.tanggal_produksi, 
  pa.total_jumlah_terjual
FROM 
  produksi_filtered pf
JOIN 
  penjualan_filtered pa
ON 
  pf.id_produk = pa.id_produk
ORDER BY 
  pa.total_jumlah_terjual DESC;
