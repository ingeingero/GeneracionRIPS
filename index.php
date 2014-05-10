<?php
$sufijo = "042014";
$fecha_generacion = "05/04/2014";
$fecha_ini = "01/03/2014";
$fecha_fin = "31/03/2014";
$replace = "/03/";
$replace1 = "2014";
$eps = "RES004";
ini_set('max_execution_time', 30000);
$serverName = 'INGERA-VAIO\SQLEXPRESS';
$connParams = array('UID'=>'sa', 'PWD'=>'sa', 'Database'=>'SUNTTEL_DBMEDICS','ReturnDatesAsStrings'=> true);
$conn = sqlsrv_connect($serverName, $connParams);
if(!$conn){
    $errors = sqlsrv_errors();
    die(var_dump($errors));
}
$params = array();
$options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
$texto = "";
$sql_string = "select * from RIPSAP a, dbo.facturas b where a.fac = b.codigo";
    $stmt1 = sqlsrv_query( $conn, $sql_string , $params, $options );
    $CONT_AP = 0;

    while ($sub_fila = sqlsrv_fetch_array($stmt1, MYSQL_BOTH)) {
        $cont=0;
       $fecha =  str_replace(substr($sub_fila[4], 2, 4),$replace,$sub_fila[4]);
       $fecha =  str_replace(substr($fecha, 6, 4),$replace1,$fecha);
       $fecha =  str_replace("31","30",$fecha);
        while($cont<=14){
            if($cont>0)$texto = $texto.",";
        
             if($cont == 0 && $eps == "EPS002")$texto =$texto.trim($sub_fila[17],' ');  
             else if($cont == 4) $texto = $texto.$fecha;
    
            else $texto = $texto.$sub_fila[''.$cont];  
            $cont++;
            }
            
  $texto = $texto."\r\n";
  $CONT_AP++;  
    }
//echo $texto;
//exit();

$af_nombre = "AP".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);


$texto = "";
$sql_string = "select * from RIPSAC a, dbo.facturas b where a.fac = b.codigo";
    $stmt1 = sqlsrv_query( $conn, $sql_string , $params, $options );
   $CONT_AC=0;

    while ($sub_fila = sqlsrv_fetch_array($stmt1, MYSQL_BOTH)) {
        $cont=0;
          $fecha =  str_replace(substr($sub_fila[4], 2, 4),$replace,$sub_fila[4]);
       $fecha =  str_replace(substr($fecha, 6, 4),$replace1,$fecha);
       $fecha =  str_replace("31","30",$fecha);
  
                
        while($cont<=16){
            
            if($cont>0)$texto = $texto.",";            
            if($cont == 0 && $eps == "EPS002")$texto =$texto.trim($sub_fila[19],' '); 
            else if($cont == 4) $texto = $texto.$fecha;
            else $texto = $texto.$sub_fila[''.$cont];                                                
           
        
         
            $cont++;
            }
            
  $texto = $texto."\r\n";
  $CONT_AC++;  
    }
//echo $texto;
//exit();

$af_nombre = "AC".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);

$texto = "";
$sql_string = "select * from FacturasRIPS a, dbo.facturas b where a.Codigo = b.codigo";
    $stmt1 = sqlsrv_query( $conn, $sql_string , $params, $options );
      $CONT_AF=0;
    while ($sub_fila = sqlsrv_fetch_array($stmt1, MYSQL_BOTH)) {
        $cont=0;
              
        while($cont<=16){
            if($cont>0)$texto = $texto.",";
              if($cont == 6) {
                $texto = $texto.$fecha_ini;
                $texto =$texto.",".$fecha_fin;
                $cont = $cont +1;       
            }
            else if($cont == 4 && $eps == "EPS002")$texto =$texto.trim($sub_fila['codigo2']);  
            else $texto = $texto.$sub_fila[''.$cont];
            $cont++;
            }
            
  $texto = $texto."\r\n";
   $CONT_AF++;  
    }
//echo $texto;
//exit();

$af_nombre = "AF".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);

$texto = "";
$sql_string = "select DISTINCT a.NumeroIdentificacion,  CodTipoIdentificacion, a.NumeroIdentificacion, CodEPS,CodTipoRegimen,
PrimerApellido,SegundoApellido,PrimerNombre, SegundoNombre, Edad, unidad_edad,
Sexo, CodDepartamento, CodMunicipio, ZonaResidencial 
from PacientesRIPS1 a, facturas b where a.NumeroIdentificacion = b.documento";
    $stmt1 = sqlsrv_query( $conn, $sql_string , $params, $options );
     $CONT_US=0;
     $tipoDoc = "";
    while ($sub_fila = sqlsrv_fetch_array($stmt1, MYSQL_BOTH)) {
        $cont=1;
          if ($sub_fila['Edad']<10) $tipoDoc = "RC";
          else if ($sub_fila['Edad']>=10 && $sub_fila['Edad']<18 ) $tipoDoc = "TI";
          else if ($sub_fila['Edad']>=18) $tipoDoc = "CC";
          
          if($sub_fila['Edad'] <0) {
            $sub_fila[9] = 65;
            $tipoDoc = "CC";
            }
        while($cont<=14){
            if($cont>1)
                $texto = $texto.",";
            if($cont == 3) 
                $texto = $texto.$eps;
            else if($cont == 1)
                $texto = $texto.$tipoDoc;
            else
                $texto = $texto.$sub_fila[''.$cont];
            $cont++;
            }
            
  $texto = $texto."\r\n";
   $CONT_US++;  
    }
//echo $texto;
//exit();

$af_nombre = "US".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);

$texto = "252900032901,$fecha_generacion,AF$sufijo,$CONT_AF
252900032901,$fecha_generacion,US$sufijo,$CONT_US
252900032901,$fecha_generacion,AD$sufijo,4
252900032901,$fecha_generacion,AC$sufijo,$CONT_AC
252900032901,$fecha_generacion,AP$sufijo,$CONT_AP
252900032901,$fecha_generacion,CT$sufijo,6
";


$af_nombre = "CT".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);

$texto = "427579,252900032901,01,$CONT_AC,17500,17500
432766,252900032901,01,$CONT_AC,17500,17500
435369,252900032901,02,$CONT_AP,26959,26959
436817,252900032901,02,$CONT_AP,47718,47718
";
$af_nombre = "AD".$sufijo;
$archivo =fopen("$af_nombre.txt","w+");
fwrite($archivo, $texto);
fclose($archivo);

EXIT();
$sql = "select  dbo.DocsFacturas.Codigo as factura, dbo.EPS.Nombre as epsNombre,  dbo.EPS.CodigoContable as nit,  dbo.DocsFacturas.Fecha as fecha,  dbo.Pacientes.Apellido1+' '+dbo.Pacientes.Apellido2+' '+dbo.Pacientes.Nombre1+' '+dbo.Pacientes.Nombre2,dbo.Pacientes.Codigo,  sum(dbo.DocsFacturasDetalles.VlrPaciente) as Valortotalpaciente,
 sum(dbo.DocsFacturasDetalles.VlrEPS)AS ValortotalEPS, sum(dbo.DocsFacturasDetalles.VlrEPS)+ sum(dbo.DocsFacturasDetalles.VlrPaciente) AS ValorTotal
 from dbo.DocsFacturas,dbo.DocsFacturasDetalles,dbo.Pacientes, dbo.EPS
where dbo.EPS.ID = dbo.DocsFacturas.IDEPS and
dbo.DocsFacturas.ID = dbo.DocsFacturasDetalles.IDDocsFacturas and dbo.DocsFacturas.IDPaciente = dbo.Pacientes.ID  and dbo.DocsFacturas.Fecha > '2013-31-07'
group by dbo.DocsFacturas.Codigo,dbo.EPS.CodigoContable,dbo.EPS.Nombre,dbo.DocsFacturas.Fecha, dbo.Pacientes.Codigo, dbo.Pacientes.Nombre1, dbo.Pacientes.Nombre2, dbo.Pacientes.Apellido1, dbo.Pacientes.Apellido2 ORDER BY dbo.DocsFacturas.Fecha
";
$params = array();
$options =  array( "Scrollable" => SQLSRV_CURSOR_KEYSET );
$stmt = sqlsrv_query( $conn, $sql , $params, $options );

$row_count = sqlsrv_num_rows( $stmt );
   
if ($row_count === false)
   echo "Error in retrieveing row count.";
else
 //  echo $row_count;
   
echo "<table border='1'>";
while ($fila = sqlsrv_fetch_array($stmt, MYSQL_NUM)) {
    $factura = $fila['factura'];
    $fecha = substr($fila['fecha'],0,10);
    $epsNombre = $fila['epsNombre'];
    $paciente = round($fila['Valortotalpaciente']);
    $eps = round($fila['ValortotalEPS']);
    $total = round($fila['ValorTotal']);
    echo    "<tr><td>$fecha</td><td>$epsNombre</td><td>$factura</td><td>$eps</td></tr>
             <tr><td>$fecha</td><td>$epsNombre</td><td>$factura</td><td>$paciente</td></tr>
             <tr><td>$fecha</td><td>$epsNombre</td><td>$factura</td><td>$total</td></tr>";
}
echo "</table>";
//mysql_free_result($resultado);
?>
