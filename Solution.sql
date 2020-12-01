raster2pgsql.exe -s 3763 -N -32767 -t 100x100 -I -C -M -d srtm_1arc_v3.tif rasters.dem > dem.sql


raster2pgsql.exe -s 3763 -N -32767 -t 100x100 -I -C -M -d srtm_1arc_v3.tif rasters.dem | psql -d Exercise_7 -h localhost -U postgres -p 5432

raster2pgsql.exe -s 3763 -N -32767 -t 128x128 -I -C -M -d Landsat8_L1TP_RGBN.TIF rasters.landsat8 | psql -d Exercise_7 -h localhost -U postgres -p 5432