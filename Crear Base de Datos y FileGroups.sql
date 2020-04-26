CREATE DATABASE Ventas ON	PRIMARY ( 
										NAME = Ventas1_dat, 
										FILENAME = 'C:\data_course\Ventas1_dat.mdf', 
										SIZE = 10, 
										MAXSIZE = 50, 
										FILEGROWTH = 15% 
									), 
							FILEGROUP GrupoVentasData 
									( 
										NAME = Ventas3_dat, 
										FILENAME = 'C:\data_course\Ventas3_dat.ndf', 
										SIZE = 10, 
										MAXSIZE = 50, 
										FILEGROWTH = 5 
									), 
									( 
										NAME = Ventas4_dat, 
										FILENAME = 'C:\data_course\Ventas4_dat.ndf', 
										SIZE = 10, 
										MAXSIZE = 50, 
										FILEGROWTH = 5 
									), 
							FILEGROUP GrupoVentasIndices 
							( 
										NAME = Ventas_ind, 
										FILENAME = 'C:\data_course\deep\Ventas1_ind.ndf', 
										SIZE = 10, 
										MAXSIZE = 50, 
										FILEGROWTH = 5 
							), 
							( 
										NAME = Ventas2_ind, 
										FILENAME = 'C:\data_course\deep\Ventas2_ind.ndf', 
										SIZE = 10, 
										MAXSIZE = 50, 
										FILEGROWTH = 5 
							) 
							LOG ON 
							( 
										NAME = 'Ventas_log', 
										FILENAME = 'C:\data_course\deep\salelog.ldf', 
										SIZE = 5MB, 
										MAXSIZE = 25MB, 
										FILEGROWTH = 5MB 
							) 
							GO