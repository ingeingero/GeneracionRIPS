ALTER VIEW [dbo].[ServiciosRIPS]
AS
SELECT     dbo.ServiciosMedicos.ID, dbo.ServiciosMedicos.Nombre, dbo.SubSistemas.Codigo + dbo.ServiciosMedicos.Codigo AS CodCompleto -- dbo.SubSistemas.Codigo + dbo.ServiciosMedicos.Codigo 
FROM         dbo.ServiciosMedicos INNER JOIN
                      dbo.Sistemas ON dbo.ServiciosMedicos.IDSistemas = dbo.Sistemas.ID INNER JOIN
                      dbo.SubSistemas ON dbo.ServiciosMedicos.IDSubsistemas = dbo.SubSistemas.ID

-----------------------------------------------------------------------------------------------------------------
ALTER VIEW [dbo].[ConsultasRIPS]
AS
SELECT     dbo.DocsFacturas.Codigo as fac,'252900032901' as codigo_resolucion,dbo.PacientesRIPS.CodTipoIdentificacion AS CodTipoIdentificacionPaciente,dbo.PacientesRIPS.NumeroIdentificacion AS CodPaciente,CONVERT(VARCHAR(10), dbo.DocsFacturas.Fecha, 103) as fecha1,
dbo.DocsFacturasDetalles.CodAutorizacion as CodAutorizacion, 

CASE WHEN dbo.ServiciosRIPS.CodCompleto = '895101' THEN '890202'
WHEN dbo.ServiciosRIPS.CodCompleto = '86863102' THEN '863102'
WHEN dbo.ServiciosRIPS.CodCompleto = '89898001' THEN '898001'
 else dbo.ServiciosRIPS.CodCompleto END CodCompleto ,

 '10' as diez, '13' as trece,
CASE WHEN dbo.Diagnosticos.Codigo = '0' OR dbo.Diagnosticos.Codigo = '' THEN 'Z719' ELSE dbo.Diagnosticos.Codigo END dx ,
'' as uno, '' as dos, '' as tres, '1' unoo,
case when dbo.DocsFacturasDetalles.Cantidad > 0 then CAST(dbo.DocsFacturasDetalles.VlrEPS/dbo.DocsFacturasDetalles.Cantidad AS INT) 
else 0 end eps1

, '0' as cero0,
case when dbo.DocsFacturasDetalles.Cantidad > 0 then CAST(dbo.DocsFacturasDetalles.VlrEPS/dbo.DocsFacturasDetalles.Cantidad AS INT) 
else 0 end eps2, dbo.DocsFacturas.Fecha as fecha2, cast(dbo.DocsFacturasDetalles.VlrPaciente as int) as paciente, dbo.DocsFacturasDetalles.Cantidad as cantidad, dbo.ServiciosRIPS.Nombre as ServicioNombre, dbo.PacientesRIPS.Edad as PacienteEdad

FROM         dbo.DocsConsultas INNER JOIN
                      dbo.PacientesRIPS ON dbo.DocsConsultas.IDPaciente = dbo.PacientesRIPS.ID INNER JOIN
					  dbo.DocsFacturasDetalles ON dbo.DocsConsultas.IDDocsFacturasDetalles = dbo.DocsFacturasDetalles.ID INNER JOIN
					  dbo.DocsFacturas ON dbo.DocsFacturasDetalles.IDDocsFacturas = dbo.DocsFacturas.ID INNER JOIN
				
                      dbo.BAS_MotivosConsulta ON dbo.DocsConsultas.IDBAS_MotivosConsulta = dbo.BAS_MotivosConsulta.ID INNER JOIN
                      dbo.Diagnosticos ON dbo.DocsConsultas.IDDiagnosticosPpal = dbo.Diagnosticos.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_1 ON dbo.DocsConsultas.IDDiagnosticos1 = Diagnosticos_1.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_2 ON dbo.DocsConsultas.IDDiagnosticos2 = Diagnosticos_2.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_3 ON dbo.DocsConsultas.IDDiagnosticos3 = Diagnosticos_3.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_4 ON dbo.DocsConsultas.IDDiagnosticosMuerte = Diagnosticos_4.ID LEFT OUTER JOIN
                      dbo.BAS_DestinosSalida ON dbo.DocsConsultas.IDBAS_DestinosSalida = dbo.BAS_DestinosSalida.ID LEFT OUTER JOIN
                      dbo.BAS_EstadosSalida ON dbo.DocsConsultas.IDBAS_EstadosSalida = dbo.BAS_EstadosSalida.ID INNER JOIN
                      dbo.ServiciosRIPS ON dbo.DocsConsultas.IDServiciosMedicos = dbo.ServiciosRIPS.ID INNER JOIN
                      dbo.BAS_FinalidadesConsulta ON dbo.DocsConsultas.IDBAS_FinalidadesConsulta = dbo.BAS_FinalidadesConsulta.ID INNER JOIN
                      dbo.BAS_TiposDiagnosticos ON dbo.DocsConsultas.IDBAS_TiposDiagnosticos = dbo.BAS_TiposDiagnosticos.ID INNER JOIN
                      dbo.BAS_AmbitosRealizaProceds ON dbo.DocsConsultas.IDBAS_AmbitosRealizaProceds = dbo.BAS_AmbitosRealizaProceds.ID
-------------------------------------------------------------------------------------------------------------------


ALTER VIEW [dbo].[ProcedimientosRIPS]
AS
SELECT      dbo.DocsFacturas.Codigo,'252900032901' as codigo_resolucion,dbo.PacientesRIPS.CodTipoIdentificacion AS CodTipoIdentificacionPaciente1,dbo.PacientesRIPS.NumeroIdentificacion AS CodPaciente1,CONVERT(VARCHAR(10), dbo.DocsFacturas.Fecha, 103) as fecha1,
dbo.DocsFacturasDetalles.CodAutorizacion as CodAutorizacion,
CASE --WHEN dbo.ServiciosRIPS.CodCompleto = '898001' THEN '898003'
WHEN dbo.ServiciosRIPS.CodCompleto = 'S55115' THEN 'S55104'
 else dbo.ServiciosRIPS.CodCompleto END CodCompleto ,


'1' as uno,'4' as cuatro,'5' as cinco,
CASE WHEN dbo.Diagnosticos.Codigo = '0' OR dbo.Diagnosticos.Codigo = '' THEN 'Z000' ELSE dbo.Diagnosticos.Codigo END dx
,'' as esp1,'' as esp2,
case when dbo.DocsFacturasDetalles.Cantidad > 0 then CAST(dbo.DocsFacturasDetalles.VlrEPS/dbo.DocsFacturasDetalles.Cantidad AS INT) 
else 0
end eps, 

dbo.DocsFacturas.Fecha as fecha2,CAST(dbo.DocsFacturasDetalles.VlrPaciente AS INT) as paciente, dbo.DocsFacturasDetalles.Cantidad as cantidad, dbo.ServiciosRIPS.Nombre as ServicioNombre , dbo.PacientesRIPS.Edad as PacienteEdad

FROM         dbo.DocsProcedimientos INNER JOIN
                      dbo.PacientesRIPS ON dbo.DocsProcedimientos.IDPaciente = dbo.PacientesRIPS.ID INNER JOIN
                      dbo.ServiciosRIPS ON dbo.DocsProcedimientos.IDServiciosMedicos = dbo.ServiciosRIPS.ID INNER JOIN
                      dbo.DocsFacturasDetalles ON dbo.DocsProcedimientos.IDDocsFacturasDetalles = dbo.DocsFacturasDetalles.ID INNER JOIN
					  dbo.DocsFacturas ON dbo.DocsFacturasDetalles.IDDocsFacturas = dbo.DocsFacturas.ID INNER JOIN

dbo.BAS_FinalidadesProcedimiento ON 
                      dbo.DocsProcedimientos.IDBAS_FinalidadesProcedimiento = dbo.BAS_FinalidadesProcedimiento.ID INNER JOIN
                      dbo.BAS_AmbitosRealizaProceds ON dbo.DocsProcedimientos.IDBAS_AmbitosRealizaProceds = dbo.BAS_AmbitosRealizaProceds.ID INNER JOIN
                      dbo.Diagnosticos ON dbo.DocsProcedimientos.IDDiagnosticosPpal = dbo.Diagnosticos.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_2 ON dbo.DocsProcedimientos.IDDiagnosticos2 = Diagnosticos_2.ID INNER JOIN
                      dbo.Diagnosticos Diagnosticos_3 ON dbo.DocsProcedimientos.IDDiagnosticos3 = Diagnosticos_3.ID INNER JOIN
                      dbo.BAS_FormasRealizacionProced ON 
                      dbo.DocsProcedimientos.IDBAS_FormasRealizacionProced = dbo.BAS_FormasRealizacionProced.ID INNER JOIN
                      dbo.BAS_TiposDiagnosticos ON dbo.DocsProcedimientos.IDBAS_TiposDiagnosticos = dbo.BAS_TiposDiagnosticos.ID INNER JOIN
                      dbo.Medicos ON dbo.DocsProcedimientos.IDMedicos = dbo.Medicos.ID INNER JOIN
                      dbo.BAS_ClasesEspecialistas ON dbo.Medicos.IDBAS_ClasesEspecialistas = dbo.BAS_ClasesEspecialistas.ID
---------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[HC](
	[fac] [int] NULL,
	[CodTipoIdentificacionPaciente] [nvarchar](5) COLLATE Modern_Spanish_CI_AS NULL,
	[CodPaciente] [varchar](150) COLLATE Modern_Spanish_CI_AS NULL,
	[fecha2] [smalldatetime] NULL,
	[CodCompleto] [nvarchar](152) COLLATE Modern_Spanish_CI_AS NULL,
	[dx] [nvarchar](5) COLLATE Modern_Spanish_CI_AS NULL,
	[valor_eps] [int] NULL,
	[valor_paciente] [int] NULL,
	[tipo] [int] NULL,
	[CodAutorizacion] [varchar](max) COLLATE Modern_Spanish_CI_AS NULL,
	[cantidad] [int] NULL,
	[nombre_servicio] [varchar](150) COLLATE Modern_Spanish_CI_AS NULL,
	[PacienteEdad] [varchar](150) COLLATE Modern_Spanish_CI_AS NULL
) ON [PRIMARY]


------------------------------------------------------------------------------------------------------------------------

CREATE view [dbo].[RIPSAC] AS
select a.fac, '252900032901' as habilitacion, 


CodTipoIdentificacionPaciente  = CASE 
WHEN PacienteEdad<10 AND PacienteEdad>= 0 THEN 'RC'
WHEN PacienteEdad>=10 AND PacienteEdad<18 THEN 'TI'
ELSE 'CC' END,


REPLACE(LTRIM(RTRIM(CodPaciente)), '.', '') as CodPaciente,CONVERT(VARCHAR(10), fecha2, 103) as fecha,(select top (1) CodAutorizacion from HC b where b.fac = a.fac and LEN(b.CodAutorizacion) > 3 ) as CodAutorizacion , CodCompleto, '10' as diez, '13' as trece, dx, '' as esp1,
'' as esp2, '' as esp3 , '1' as uno , (valor_eps+valor_paciente) as total, valor_paciente, valor_eps, PacienteEdad  from HC a where  SUBSTRING(CodCompleto, 1, 3) = '890' ;


------------------------------------------------------------------------------------------------------------------------
CREATE view [dbo].[RIPSAP] AS
select a.fac, '252900032901' as habilitacion, 
CodTipoIdentificacionPaciente  = CASE 
WHEN PacienteEdad<10 AND PacienteEdad>= 0 THEN 'RC'
WHEN PacienteEdad>=10 AND PacienteEdad<18 THEN 'TI'
ELSE 'CC' END,


REPLACE(LTRIM(RTRIM(CodPaciente)), '.', '') as CodPaciente,CONVERT(VARCHAR(10), fecha2, 103) as fecha,(select top 1 CodAutorizacion from HC b where b.fac = a.fac and LEN(b.CodAutorizacion) > 3 ) as CodAutorizacion, 
	 CodCompleto = CASE WHEN len(CodCompleto) > 6 THEN SUBSTRING(CodCompleto, 3, len(CodCompleto)) 

		ELSE CodCompleto end
, '1' as unoo, '4' as cuatro, '5' as cinco, dx, '' as esp1,
'' as esp2, '' as acto ,  valor_eps , PacienteEdad from HC a where  not SUBSTRING(CodCompleto, 1, 3) = '890' ;

---------------------------------------------------------------------------------------------------------------
CREATE  VIEW [dbo].[PacientesRIPS1]
AS
SELECT       
CodTipoIdentificacion = CASE 

/*WHEN B.Codigo = 'NU' THEN 'RC'
WHEN B.Codigo = 'SNI' THEN 'RC' 
WHEN B.Codigo = 'AS' THEN 'CC'
WHEN B.Codigo = 'MS' THEN 'RC'
ELSE B.Codigo END,*/

WHEN len(A.codigo)<=9 THEN 'CC'
WHEN len(A.codigo)<=10 THEN 'RC'
ELSE 'TI' end,

--=SI(LARGO(B1)<=9;"CC";SI(LARGO(B1)<=10;"RC";"TI"))
REPLACE(LTRIM(RTRIM(A.codigo)), '.', '') AS NumeroIdentificacion, G.Codigo AS CodEPS, '1' AS CodTipoRegimen, A.Apellido1 AS PrimerApellido, 
                      A.Apellido2 AS SegundoApellido, A.Nombre1 AS PrimerNombre, A.Nombre2 AS SegundoNombre , 
                       Edad = CASE 

						WHEN DATEDIFF(d, A.FNacimiento, GETDATE()) < 30 THEN DATEDIFF(d, 
                      A.FNacimiento, GETDATE()) WHEN DATEDIFF(d, A.FNacimiento, GETDATE()) >= 30 AND DATEDIFF(m, A.FNacimiento, GETDATE()) 
                      < 12 THEN DATEDIFF(m, A.FNacimiento, GETDATE()) WHEN DATEDIFF(yy, A.FNacimiento, GETDATE()) >= 1 THEN DATEDIFF(yy, A.FNacimiento, 
                      GETDATE()) END,
/*WHEN len(A.codigo)<=9 THEN ROUND(((78 - 21 -1) * RAND() + 21), 0)
WHEN len(A.codigo)<=10 THEN ROUND(((6 - 1 -1) * RAND() + 1), 0)
ELSE ROUND(((17 - 10 -1) * RAND() + 10), 0) 
END,*/


 '1' as unidad_edad, C.Codigo AS Sexo, '25' AS CodDepartamento, '290' AS CodMunicipio, F.Codigo AS ZonaResidencial, a.ID AS PacienteID
FROM         dbo.Pacientes A INNER JOIN
                      dbo.BAS_TiposDocIdentificacion B ON A.IDBAS_TiposDocIdentificacion = B.ID INNER JOIN
                      dbo.BAS_Generos C ON A.IDBAS_Generos = C.ID INNER JOIN
                      dbo.Departamentos D ON A.IDDepartamentos = D .ID INNER JOIN
                      dbo.Municipios E ON A.IDMunicipios = E.ID INNER JOIN
                      dbo.BAS_ZonasResidenciales F ON A.IDBAS_ZonasResidenciales = F.ID INNER JOIN
                      dbo.EPS G ON A.IDEPS = G.ID INNER JOIN
                      dbo.BAS_TiposAfiliacion H ON A.IDBAS_TiposAfiliacion = H.ID INNER JOIN
                      dbo.BAS_Oficios I ON A.IDBAS_Oficios = I.ID INNER JOIN
                      dbo.AppParametros J ON 1 = 1 INNER JOIN
                      dbo.PlanesEPS K ON A.IDPlanesEPS = K.ID INNER JOIN
                      dbo.BAS_TiposRegimenes L ON K.IDBAS_TiposRegimenes = L.ID

--------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[FacturasRIPS] as
select '252900032901' as habilitacion,'MEDSALUD IPS' as ips, 'NI' AS ni, '900013381' as nit, dbo.DocsFacturas.Codigo,'05/04/2014' as fecha_rips, '01/01/2014' as fecha_ini,'031/01/2014' as fecha_fin, dbo.EPS.Codigo  as eps_codigo, dbo.EPS.Nombre as eps_nombre, dbo.EPS.Codigo as eps_codigo2,'' as va1,'' as va2,cast(sum(dbo.DocsFacturasDetalles.VlrPaciente)as int) as Valortotalpaciente,'0' as cer1,'0' as cer2,cast(sum(dbo.DocsFacturasDetalles.VlrEPS)as int)AS ValortotalEPS, dbo.DocsFacturas.Fecha  as fecha2, dbo.Pacientes.Codigo as Paciente, dbo.DocsFacturas.IDPaciente  as PacienteID
 from dbo.DocsFacturas,dbo.DocsFacturasDetalles,dbo.Pacientes, dbo.EPS
where 
dbo.EPS.ID = dbo.DocsFacturas.IDEPS and
dbo.DocsFacturas.ID = dbo.DocsFacturasDetalles.IDDocsFacturas and dbo.DocsFacturas.IDPaciente = dbo.Pacientes.ID
group by dbo.EPS.Codigo,dbo.EPS.Nombre,dbo.DocsFacturas.Codigo,dbo.DocsFacturas.Fecha, dbo.Pacientes.Codigo, dbo.Pacientes.Nombre1, dbo.Pacientes.Nombre2, dbo.Pacientes.Apellido1, dbo.Pacientes.Apellido2,dbo.DocsFacturas.IDPaciente


---------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[facturas](
	[codigo] [nchar](10) COLLATE Modern_Spanish_CI_AS NULL,
	[documento] [varchar](50) COLLATE Modern_Spanish_CI_AS NULL,
	[codigo2] [nchar](10) COLLATE Modern_Spanish_CI_AS NULL,
) ON [PRIMARY]


------------------------------------------------------------------------------------------------------------------

truncate table HC;
insert into HC select fac,CodTipoIdentificacionPaciente, CodPaciente,fecha2, CodCompleto, dx,eps1, paciente, '1', CodAutorizacion, cantidad, ServicioNombre, PacienteEdad from dbo.ConsultasRIPS --where fecha2 >= '20100101'
insert into HC select Codigo,CodTipoIdentificacionPaciente1, CodPaciente1,fecha2, CodCompleto, dx,eps, paciente, '2', CodAutorizacion, cantidad, ServicioNombre, PacienteEdad from dbo.ProcedimientosRIPS --where fecha2 >= '20100101'


-------------------------------------------------------------------------------------------------------------------------

truncate table facturas;
bulk INSERT dbo.facturas FROM 'C:\subir.csv'
WITH (
DATAFILETYPE = 'char',
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
)
select * from facturas ;
------------------------------------------------------------------------------------

select fac, CodTipoIdentificacionPaciente, CodPaciente, fecha2, (select top 1 CodAutorizacion from HC b where b.fac = a.fac and LEN(b.CodAutorizacion) > 3 ) as CodAutorizacion,
CodCompleto = CASE WHEN len(CodCompleto) > 6 THEN SUBSTRING(CodCompleto, 3, len(CodCompleto)) 
ELSE CodCompleto end,
nombre_servicio,
dx, cantidad,
moderadora = case when (valor_paciente = 2400 or valor_paciente = 2300 or valor_paciente = 9500 or valor_paciente = 9100 or valor_paciente = 24900) then valor_paciente
else 0 end,
copago = case when not(valor_paciente = 2400  or valor_paciente = 2300 or valor_paciente = 9500 or valor_paciente = 9100 or valor_paciente = 24900) then valor_paciente
else 0 end,
valor_eps,
(valor_eps * cantidad) as total_eps,
((valor_eps * cantidad)+ valor_paciente) as total
from HC a, facturas b where a.fac = b.codigo; 

select * from FacturasRIPS a, dbo.facturas b where a.Codigo = b.codigo

---------------------------------------------------------------------------------------------------------------

SELECT j.Fecha, a.Codigo, a.Apellido1, a.Apellido2, a.Nombre1, a.Nombre2, a.Direccion, a.TelRecidencia,   
K.Nombre, l.Nombre, DAY(a.FNacimiento) dia,MONTH(a.FNacimiento) mes ,YEAR(a.FNacimiento) anio, DATEDIFF(yy,a.FNacimiento,GETDATE()) AS edad ,c.Nombre, f.Nombre, p.Nombre, M.Codigo,
n.Peso, n.Talla, n.IMC, o.Nombre, j.Observaciones, j.Analisis
FROM dbo.Pacientes a, dbo.BAS_Oficios b, BAS_Generos c, BAS_NivelesEducativos d, BAS_TiposDocIdentificacion e, EPS f,
BAS_TiposDocIdentificacion g, BAS_TiposAfiliacion h, DocsConsultas j, Municipios k, BAS_ZonasResidenciales l, Diagnosticos m, DocsConsultasChequeoFisico n, BAS_IMC o, BAS_TiposRegimenes p
where  
a.IDBAS_Oficios = b.ID AND
a.IDBAS_GenerOs = c.ID AND 
a.IDBAS_NivelesEducativos = d.ID AND
a.IDBAS_TiposDocIdentificacion = e.ID AND
a.IDEPS = f.ID AND 
f.IDBAS_TiposRegimenes = p.ID AND
a.IDBAS_TiposDocIdentificacion = g.ID AND
a.IDBAS_TiposAfiliacion = h.ID AND
j.IDPaciente = a.ID AND
a.IDMunicipios = k.ID AND
a.IDBAS_ZonasResidenciales = l.ID AND
j.IDDiagnosticosPpal = m.ID AND
j.ID = n.ID AND
n.IDBAS_IMC = o.ID AND
j.Fecha > '20140401' 
------------------------------------------------------------------------------------------------------------------------------
SELECT  a.Codigo, g.Codigo FROM dbo.Pacientes a, dbo.BAS_Oficios b, BAS_Generos c, BAS_NivelesEducativos d, BAS_TiposDocIdentificacion e, EPS f,
BAS_TiposDocIdentificacion g, BAS_TiposAfiliacion h
where  
a.IDBAS_Oficios = b.ID AND
a.IDBAS_GenerOs = c.ID AND 
a.IDBAS_NivelesEducativos = d.ID AND
a.IDBAS_TiposDocIdentificacion = e.ID AND
a.IDEPS = f.ID AND 
a.IDBAS_TiposDocIdentificacion = g.ID AND
a.IDBAS_TiposAfiliacion = h.ID
--------------------------------------------------------------------------------------------

select a.factura2, cc.CodAutorizacion from dbo.Autorizaciones a, DocsFacturas c, DocsFacturasDetalles cc 
where  a.factura2 = c.Codigo and cc.IDDocsFacturas = c.ID order by cc.CodAutorizacion desc
--SELECT * FROM Autorizaciones a LEFT JOIN DocsFacturas b ON a.factura1 = b.Codigo;

--459598 
------------------------------------------
select * from RIPSAC a, dbo.facturas b where a.fac = b.codigo

CREATE TABLE [dbo].[Autorizaciones](
	[factura1] [int] NULL,
	[factura2] [int] NULL
) ON [PRIMARY]


------------------------------------------------------------------------------

--select * from hc;

select 
factura1 = CASE 
WHEN a.fac > b.fac THEN CONVERT(VARCHAR, b.fac)+'*'+b.nombre_servicio+'*'+CONVERT(VARCHAR(10), b.fecha2, 103)
WHEN b.fac > a.fac THEN CONVERT(VARCHAR, a.fac)+'*'+a.nombre_servicio+'*'+CONVERT(VARCHAR(10), a.fecha2, 103)
end,
factura2 = CASE 
WHEN a.fac > b.fac THEN CONVERT(VARCHAR, a.fac)+'*'+a.nombre_servicio+'*'+CONVERT(VARCHAR(10), a.fecha2, 103)
WHEN b.fac > a.fac THEN CONVERT(VARCHAR, b.fac)+'*'+b.nombre_servicio+'*'+CONVERT(VARCHAR(10), b.fecha2, 103)
end  

from hc a, hc1 b where a.CodPaciente = b.CodPaciente and a.fecha2 = b.fecha2 and a.nombre_servicio = b.nombre_servicio and a.fac <> b.fac;


