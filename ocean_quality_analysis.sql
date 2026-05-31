-- Query 1: Ambil semua kolom
SELECT *
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 10

-- Query 2: Ambil kolom tertentu
SELECT Temperature, pH, Quality
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 10

-- WHERE: Filter Quality Good
SELECT *
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
WHERE Quality = 'Good'
LIMIT 10

-- BETWEEN: Temperature antara 25-30
SELECT *
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
WHERE Temperature BETWEEN 25 AND 30
LIMIT 10

-- ORDER BY: Urutkan Temperature tertinggi
SELECT *
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
ORDER BY Temperature DESC
LIMIT 10

-- DISTINCT: Nilai unik Quality
SELECT DISTINCT Quality
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`

-- COUNT, AVG, MIN, MAX
SELECT 
  COUNT(*) AS total_data,
  AVG(Temperature) AS rata_suhu,
  MIN(Temperature) AS suhu_terendah,
  MAX(Temperature) AS suhu_tertinggi
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`

-- GROUP BY
SELECT Quality, COUNT(*) AS jumlah
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY Quality

-- HAVING
SELECT Quality, COUNT(*) AS jumlah
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY Quality
HAVING COUNT(*) > 5000

CREATE TABLE `praxis-road-456312-p3.latihan_SQL.ocean_location` AS
SELECT 
  ROW_NUMBER() OVER() AS id,
  Temperature,
  CASE 
    WHEN Temperature < 25 THEN 'Zona Dingin'
    WHEN Temperature BETWEEN 25 AND 30 THEN 'Zona Sedang'
    ELSE 'Zona Panas'
  END AS zona,
  CASE
    WHEN Temperature < 25 THEN 'Laut Selatan'
    WHEN Temperature BETWEEN 25 AND 30 THEN 'Laut Jawa'
    ELSE 'Laut Banda'
  END AS lokasi
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
-- Lihat isi tabel ocean_location dulu
SELECT *
FROM `praxis-road-456312-p3.latihan_SQL.ocean_location`
LIMIT 10

-- INNER JOIN: Gabungkan ocean_quality + ocean_location
SELECT 
  o.Temperature,
  o.pH,
  o.Quality,
  l.zona,
  l.lokasi
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality` o
INNER JOIN `praxis-road-456312-p3.latihan_SQL.ocean_location` l
ON o.Temperature = l.Temperature
LIMIT 10

-- LEFT JOIN
SELECT 
  o.Temperature,
  o.Quality,
  l.zona,
  l.lokasi
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality` o
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.ocean_location` l
ON o.Temperature = l.Temperature
LIMIT 10

-- ROW_NUMBER: Beri nomor urut setiap baris
SELECT 
  ROW_NUMBER() OVER(ORDER BY Temperature DESC) AS nomor_urut,
  Temperature,
  pH,
  Quality
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- RANK: Peringkat berdasarkan Temperature tertinggi
SELECT 
  RANK() OVER(ORDER BY Temperature DESC) AS peringkat,
  Temperature,
  Quality
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- DENSE_RANK: Peringkat tanpa loncat
SELECT 
  DENSE_RANK() OVER(ORDER BY Temperature DESC) AS peringkat_dense,
  Temperature,
  Quality
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- PARTITION BY: Ranking per kelompok Quality
SELECT 
  RANK() OVER(PARTITION BY Quality ORDER BY Temperature DESC) AS ranking_per_quality,
  Quality,
  Temperature,
  pH
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- CASE WHEN: Kategorikan Temperature
SELECT 
  Temperature,
  pH,
  Quality,
  CASE 
    WHEN Temperature < 25 THEN 'Dingin'
    WHEN Temperature BETWEEN 25 AND 30 THEN 'Sedang'
    ELSE 'Panas'
  END AS kategori_suhu
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- CASE WHEN dengan agregat: Hitung per kategori suhu
SELECT 
  CASE 
    WHEN Temperature < 25 THEN 'Dingin'
    WHEN Temperature BETWEEN 25 AND 30 THEN 'Sedang'
    ELSE 'Panas'
  END AS kategori_suhu,
  COUNT(*) AS jumlah,
  AVG(pH) AS rata_pH,
  AVG(Temperature) AS rata_suhu
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY kategori_suhu
ORDER BY jumlah DESC
-- Fungsi tanggal dasar
SELECT 
  CURRENT_DATE() AS hari_ini,
  CURRENT_TIMESTAMP() AS waktu_sekarang,
  EXTRACT(YEAR FROM CURRENT_DATE()) AS tahun,
  EXTRACT(MONTH FROM CURRENT_DATE()) AS bulan,
  EXTRACT(DAY FROM CURRENT_DATE()) AS hari

-- ================================
-- MINI PROJECT: Analisis Kualitas Laut
-- Dataset: ocean_quality
-- ================================

-- 1. RINGKASAN UMUM DATA
SELECT 
  COUNT(*) AS total_sampel,
  ROUND(AVG(Temperature), 2) AS rata_suhu,
  ROUND(AVG(pH), 2) AS rata_pH,
  ROUND(AVG(Dissolved_Oxygen), 2) AS rata_oksigen,
  ROUND(AVG(Salinity), 2) AS rata_salinitas,
  ROUND(MIN(Temperature), 2) AS suhu_terendah,
  ROUND(MAX(Temperature), 2) AS suhu_tertinggi
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`

-- 2. DISTRIBUSI KUALITAS AIR
SELECT 
  Quality,
  COUNT(*) AS jumlah,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS persentase
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY Quality
ORDER BY jumlah DESC

-- 3. RATA-RATA PARAMETER PER KUALITAS
SELECT 
  Quality,
  ROUND(AVG(Temperature), 2) AS rata_suhu,
  ROUND(AVG(pH), 2) AS rata_pH,
  ROUND(AVG(Dissolved_Oxygen), 2) AS rata_oksigen,
  ROUND(AVG(Salinity), 2) AS rata_salinitas,
  ROUND(AVG(Turbidity), 2) AS rata_kekeruhan,
  ROUND(AVG(Chlorophyll), 2) AS rata_klorofil
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY Quality

-- 4. KATEGORISASI SUHU + KUALITAS
SELECT 
  CASE 
    WHEN Temperature < 25 THEN 'Dingin (<25°C)'
    WHEN Temperature BETWEEN 25 AND 30 THEN 'Sedang (25-30°C)'
    ELSE 'Panas (>30°C)'
  END AS kategori_suhu,
  Quality,
  COUNT(*) AS jumlah,
  ROUND(AVG(pH), 2) AS rata_pH
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
GROUP BY kategori_suhu, Quality
ORDER BY kategori_suhu, Quality

-- 5. RANKING SUHU TERTINGGI PER KUALITAS
SELECT 
  RANK() OVER(PARTITION BY Quality ORDER BY Temperature DESC) AS ranking,
  Quality,
  Temperature,
  pH,
  Dissolved_Oxygen
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
QUALIFY RANK() OVER(PARTITION BY Quality ORDER BY Temperature DESC) <= 5

-- 6. DETEKSI ANOMALI pH
SELECT 
  Temperature,
  pH,
  Quality,
  CASE
    WHEN pH < 6.5 THEN 'Terlalu Asam'
    WHEN pH BETWEEN 6.5 AND 8.5 THEN 'Normal'
    ELSE 'Terlalu Basa'
  END AS status_pH,
  CASE
    WHEN Dissolved_Oxygen < 3 THEN 'Oksigen Rendah'
    WHEN Dissolved_Oxygen BETWEEN 3 AND 7 THEN 'Oksigen Normal'
    ELSE 'Oksigen Tinggi'
  END AS status_oksigen
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality`
LIMIT 20

-- 7. GABUNGKAN DENGAN TABEL LOKASI
SELECT 
  o.Temperature,
  o.pH,
  o.Quality,
  l.zona,
  l.lokasi,
  CASE
    WHEN o.pH < 6.5 THEN 'Terlalu Asam'
    WHEN o.pH BETWEEN 6.5 AND 8.5 THEN 'Normal'
    ELSE 'Terlalu Basa'
  END AS status_pH
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality` o
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.ocean_location` l
ON o.Temperature = l.Temperature
LIMIT 20

-- 8. RINGKASAN PER LOKASI
SELECT 
  l.lokasi,
  l.zona,
  COUNT(*) AS jumlah_sampel,
  ROUND(AVG(o.Temperature), 2) AS rata_suhu,
  ROUND(AVG(o.pH), 2) AS rata_pH,
  COUNTIF(o.Quality = 'Good') AS jumlah_good,
  COUNTIF(o.Quality = 'Bad') AS jumlah_bad
FROM `praxis-road-456312-p3.latihan_SQL.ocean_quality` o
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.ocean_location` l
ON o.Temperature = l.Temperature
GROUP BY l.lokasi, l.zona
ORDER BY jumlah_sampel DESC