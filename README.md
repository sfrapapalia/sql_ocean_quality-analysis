# SQL Ocean Quality Analysis

## Deskripsi
Analisis kualitas air laut menggunakan SQL di Google BigQuery.
Dataset: Ocean Water Quality (Kaggle - 100.000 baris data)

## Tools
- Google BigQuery (SQL)
- Dataset: ocean_quality (Temperature, pH, Dissolved Oxygen, Salinity, Turbidity, Chlorophyll, Nitrate)

## Analisis yang dilakukan
1. Ringkasan umum data (COUNT, AVG, MIN, MAX)
2. Distribusi kualitas air (Good vs Bad)
3. Rata-rata parameter per kualitas air
4. Kategorisasi suhu laut (Dingin, Sedang, Panas)
5. Ranking suhu tertinggi per kualitas (Window Function)
6. Deteksi anomali pH dan oksigen (CASE WHEN)
7. Analisis per lokasi laut (JOIN)
8. Ringkasan per zona laut (GROUP BY + JOIN)

## Hasil Temuan
- 90% sampel air laut berkualitas Good
- Suhu laut berkisar antara 20°C - 35°C
- Tidak ada korelasi signifikan antara suhu dan pH
