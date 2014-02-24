create table PERSONA (
    pers 		int 				not null,
    N1 			varchar(20) 		not null,
    N2 			varchar(20) 		null,
    A1 			varchar(20) 		not null,
    A2 			varchar(20) 		not null,
    direccion 	varchar(100) 		not null,
    
    constraint PK_PERSONA primary key (pers),
    constraint C_PERSONA_N1 check (N1 ~*'^[A-Z][a-z]+'), 
    constraint C_PERSONA_N2 check (N2 ~*'^[A-Z][a-z]+'),
    constraint C_PERSONA_A1 check (A1 ~*'^[A-Z][a-z]+'),
    constraint C_PERSONA_A2 check (A2 ~*'^[A-Z][a-z]+')
);

create table telfPERSONA (
    pers 		int 				not null,
    numero 		varchar(12) 		not null,
    
    constraint PK_telfPERSONA primary key (pers, numero),
    constraint FK_telfPERSONA_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_telfPERSONA_numero check (numero ~* '^0[\d]{3}[-][\d]{7}')
);

create table MENOR (
    partidaNac 	varchar(20)			not null,
    pers 		int					not null,
    
    constraint PK_MENOR primary key (partidaNac),
    constraint FK_MENOR_PERSONA foreign key (pers) references PERSONA (pers),
    constraint AK_MENOR unique (pers)
    
);

create table VENEZOLANO (
    CI 			varchar(12)			not null,
    pers 		int					not null,

    constraint PK_VENEZOLANO primary key (CI),
    constraint FK_VENEZOLANO_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_VENEZOLANO_CI check (CI ~* '^[VE][-][0-9]+')

);

create table EXTRANJERO (
    numeroPas 	varchar(20)			not null,
    paisPas 	varchar(20)			not null,
    pers 		int					not null,
    
    constraint PK_EXTRANJERO primary key (numeroPas, paisPas),
    constraint FK_EXTRANJERO_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_EXTRANJERO_numeroPas check (numeroPas ~* '^[0-9][0-9]+'),
    constraint C_EXTRANJERO_paisPas check (paisPas ~* '^[A-Z][a-z]+')
);

create table PACIENTE (
    pers 		int					not null,
    sexo 		char				not null,
    ocupacion 	varchar(20)			not null,
    edad 		int					not null,
    
    constraint PK_PACIENTE primary key (pers),
    constraint FK_PACIENTE_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_PACIENTE_sexo check (sexo ~~ 'f|F|m|M'),
    constraint C_PACIENTE_edad check (edad >= 0)
);

create table contactoPACIENTE (
    pers 		int					not null,
    nombre 		varchar(80)			not null,
    
    constraint PK_contactoPACIENTE primary key (pers, nombre),
    constraint FK_contactoPACIENTE_PACIENTE foreign key (pers) references PACIENTE (pers),
    constraint C_nombre check (nombre ~*'^[A-Z][a-z]+')    
);

create table telfcontactoPACIENTE (
    pers 		int					not null,
    nombre 		varchar(80)			not null,
    numero 		varchar(20)			not null,
    
    constraint PK_telfcontactoPACIENTE primary key (pers, nombre, numero),
    constraint FK_telfcontactoPACIENTE_contactoPACIENTE foreign key (pers, nombre) references contactoPACIENTE (pers, nombre),
    constraint C_telfcontactoPACIENTE_nombre check (nombre ~*'^[A-Z][a-z]+'),
    constraint C_telfcontactoPACIENTE_numero check (numero ~* '^0[\d]{3}[-][\d]{7}')
);

create table OBRERO (
    pers 			int 			not null,
    tipoContrato 	varchar(20) 	not null,
    cargo 			varchar(20) 	not null,
    monto 			int 			not null,
    formaPago 		varchar(20)	 	not null,
    
    constraint PK_OBRERO primary key (pers),
    constraint FK_OBRERO_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_OBRERO_MONTO check (monto >= 0),
    constraint C_OBRERO_CARGO check (cargo ~*'Camarer[oa]' OR cargo ~ 'Camiller[oa]' OR cargo ~*'Cociner[oa]' OR cargo ~*'Servicio de [Ll]impieza'),
	constraint C_OBRERO_PAGO check (formaPago = 'Quincenal' OR formaPago = 'Mensual' OR formaPago = 'Por honorarios'),
   	constraint C_OBRERO_CONTRATO check (tipoContrato = 'Anual' OR tipoContrato = 'Ilimitado' OR tipoContrato = 'Periodo de prueba')
);

create table SEGURIDAD (
    pers 			int				not null,
    tipoContrato 	varchar(20)		not null,
    cargo 			varchar(20)		not null,
    monto 			int				not null,
    formaPago 		varchar(20)		not null,

    
    constraint PK_SEGURIDAD primary key (pers),
    constraint FK_SEGURIDAD_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_SEGURIDAD_MONTO check (monto >= 0),
    constraint C_SEGURIDAD_CARGO check (cargo = 'Seguridad'),
	constraint C_SEGURIDAD_PAGO check (formaPago = 'Quincenal' OR formaPago = 'Mensual' OR formaPago = 'Por honorarios'),
   	constraint C_SEGURIDAD_CONTRATO check (tipoContrato = 'Anual' OR tipoContrato = 'Ilimitado' OR tipoContrato = 'Periodo de prueba')
);

create table PARAMEDICO (
    pers 			int				not null,
    tipoContrato 	varchar(20)		not null,
    cargo 			varchar(20)		not null,
    monto 			int				not null,
    formaPago 		varchar(20)		not null,

    constraint PK_PARAMEDICO primary key (pers),
    constraint FK_PARAMEDICO_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_PARAMEDICO_MONTO check (monto >= 0),
    constraint C_PARAMEDICO_CARGO check (cargo = 'Nutricionista' OR cargo = 'Bioanalaista' OR cargo ~* 'Enfermer[oa]' OR cargo ~* 'Tecnico [Rr]adiologo'),
	constraint C_PARAMEDICO_PAGO check (formaPago = 'Quincenal' OR formaPago = 'Mensual' OR formaPago = 'Por honorarios'),
	constraint C_PARAMEDICO_CONTRATO check (tipoContrato = 'Anual' OR tipoContrato = 'Ilimitado' OR tipoContrato = 'Periodo de prueba')
);

create table ADMINISTRACION (
    pers 			int				not null,
    tipoContrato 	varchar(20)		not null,
    cargo 			varchar(20)		not null,
    monto 			int				not null,
    formaPago 		varchar(20)		not null,
    
    constraint PK_ADMINISTRACION primary key (pers),
    constraint FK_ADMINISTRACION_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_ADMINISTRACION_MONTO check (monto >= 0),
    constraint C_ADMINISTRACION_CARGO check (cargo ~* 'Secretari[oa]' OR cargo = 'Administrador' OR cargo = 'Recepcionista' OR cargo = 'Cajero'),
	constraint C_ADMINISTRACION_PAGO check (formaPago = 'Quincenal' OR formaPago = 'Mensual' OR formaPago = 'Por honorarios'),
   	constraint C_ADMINISTRACION_CONTRATO check (tipoContrato = 'Anual' OR tipoContrato = 'Ilimitado' OR tipoContrato = 'Periodo de prueba')
);

create table MEDICO (
    pers 			int				not null,
    tipoContrato 	varchar(20)		not null,
    cargo 			varchar(20)		not null,
    monto 			int				not null,
    formaPago 		varchar(20)		not null,
    mpps 			int				not null,
    numConsultorio 	varchar(10)		not null,
    especialidad 	varchar(20)		not null,
    
    constraint PK_MEDICO primary key (pers),
    constraint AK_MEDICO unique (mpps),
    constraint FK_MEDICO_PERSONA foreign key (pers) references PERSONA (pers),
    constraint C_MEDICO_MONTO check (monto >= 0),
    constraint C_MEDICO_CARGO check (cargo = 'Titular' OR cargo = 'Pasante' OR cargo = 'Invitado'),
   	constraint C_MEDICO_PAGO check (formaPago = 'Quincenal' OR formaPago = 'Mensual' OR formaPago = 'Por honorarios'),
   	constraint C_MEDICO_CONTRATO check (tipoContrato = 'Anual' OR tipoContrato = 'Ilimitado' OR tipoContrato = 'Periodo de prueba')
);

create table cursosMEDICO (
    pers 		int					not null,
    curso 		varchar(20)			not null,
    
    constraint PK_cursosMEDICO primary key (pers, curso),
    constraint FK_cursosMEDICO_MEDICO foreign key (pers) references MEDICO (pers),
    constraint C_cursoMEDICO_A2 check (curso~*'^[A-Z].*')
);

create table estudioMEDICO (
    pers 			int				not null,
    titulo 			varchar(20)		not null,
    lugarDeEstudio 	varchar(40)		not null,
    
    constraint PK_estudioMEDICO primary key (pers, titulo, lugarDeEstudio),
    constraint FK_estudioMEDICO_MEDICO foreign key (pers) references MEDICO (pers),
    constraint C_estudioMEDICO_titulo check (titulo ~*'^[A-Z].*'),
    constraint C_estudioMEDICO_lugarEstudio check (lugarDeEstudio~*'^[A-Z].*')
);

create table HISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    
    constraint PK_HISTORIAL primary key (pers, fecha),
    constraint FK_HISTORIAL_PACIENTE foreign key (pers) references PACIENTE (pers)
);

create table alergiaHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    alergia 	varchar(20)			not null,
    
    constraint PK_alergiaHISTORIAL primary key (pers, fecha, alergia),
    constraint FK_alergiaHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
	constraint C_alergiaHISTORIAL_alergia check (alergia ~*'^[A-Z].*')
);

create table observacionHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    observacion varchar(20)			not null,
    
    constraint PK_observacionHISTORIAL primary key (pers, fecha, observacion),
    constraint FK_observacionHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
    constraint C_observacionHISTORIAL_observacion check (observacion ~*'^[A-Z].*')
);

create table radiografiaHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    radiografia varchar(20)			not null,
    
    constraint PK_radiografiaHISTORIAL primary key (pers, fecha, radiografia),
    constraint FK_radiografiaHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha)
);

create table enfFamiliaHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    enfFamilia 	varchar(20)			not null,
    
    constraint PK_enfFamiliaHISTORIAL primary key (pers, fecha, enfFamilia),
    constraint FK_enfFamiliaHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
    constraint C_enfFamiliaHISTORIAL_enfFamilia check (enfFamilia ~*'^[A-Z].*')
);

create table enfCronicaHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    enfCronica 	varchar(20)			not null,
    
    constraint PK_enfCronicaHISTORIAL primary key (pers, fecha, enfCronica),
    constraint FK_enfCronicaHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
    constraint C_enfCronicaHISTORIAL_enfCronica check (enfCronica ~*'^[A-Z].*')
);

create table examenHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    examen 		varchar(20)			not null,
    
    constraint PK_examenHISTORIAL primary key (pers, fecha, examen),
    constraint FK_examenHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
    constraint C_examenHISTORIAL_examen check (examen ~*'^[A-Z].*')
);

create table operacionPrevHISTORIAL (
    pers 		int					not null,
    fecha 		date				not null,
    operacionPrev varchar(20)		not null,
    
    constraint PK_operacionPrevHISTORIAL primary key (pers, fecha, operacionPrev),
    constraint FK_operacionPrevHISTORIAL_HISTORIAL foreign key (pers, fecha) references HISTORIAL (pers, fecha),
    constraint C_operacionPrevHISTORIAL_operacionPrev check (operacionPrev  ~*'^[A-Z].*')
);

create table R_POSTERIOR_A (
    persPrev 	int					not null,
    fechaPrev 	date				not null,
    persActual 	int					not null,
    fechaActual date				not null,
    
    constraint PK_R_POSTERIOR_A primary key (persPrev, fechaPrev, persActual, fechaActual),
    constraint FK_R_POSTERIOR_A_Prev_HISTORIAL foreign key (persPrev, fechaPrev) references HISTORIAL (pers, fecha),
    constraint FK_R_POSTERIOR_A_Actual_HISTORIAL foreign key (persActual, fechaActual) references HISTORIAL (pers, fecha),
    constraint C_R_POSTERIOR_A_Fecha check (fechaPrev < fechaActual),
    constraint C_R_POSTERIOR_A_Pers check (persPrev = persActual)
);

create table PAGO (
	pago 		int					not null,
	monto_total int					not null,
	
	constraint PK_PAGO primary key (pago),	
	constraint C_PAGO_monto_total check (monto_total > 0)
);

create table EFECTIVO (
	numPago 	int					not null,
	fkpago 		int					not null,
	monto		int					not null,
		
	constraint PK_EFECTIVO primary key (numPago),
	constraint AK_EFECTIVO unique (fkpago),
	constraint FK_EFECTIVO_PAGO foreign key (fkpago) references PAGO (pago),
	constraint C_EFECTIVO_monto check (0 < monto AND monto < 200000)
);

create table TCREDITO (
	numTarjeta_c 	int				not null,
	fkpago 			int				not null,
	banco 			varchar(20)		not null,
	fechaven 		date			not null,
	monto			int				not null,
		
	constraint PK_TCREDITO primary key (numTarjeta_c),
	constraint AK_TCREDITO unique (fkpago),
	constraint FK_TCREDITO_PAGO foreign key (fkpago) references PAGO (pago),
	constraint C_TCREDITO_monto check (monto > 0)
);

create table TDEBITO (
	numTarjeta_d 	int				not null,
	fkpago 			int				not null,
	banco 			varchar(20)		not null,
	tipo 			varchar(20)		not null,
	numCuenta		int				not null,
	monto			int				not null,
	
		
	constraint PK_TDEBITO primary key (numTarjeta_d),
	constraint AK_TDEBITO unique (fkpago),
	constraint FK_TDEBITO_PAGO foreign key (fkpago) references PAGO (pago),
	constraint C_TDEBITO_monto check (monto > 0)
);

create table CHEQUE (
	numCheque 	int					not null,
	fkpago 		int					not null,
	clave_conf 	int					not null,
	monto		int					not null,
	
	constraint PK_CHEQUE primary key (numCheque),
	constraint AK_CHEQUE unique (fkpago),
	constraint FK_CHEQUE_PAGO foreign key (fkpago) references PAGO (pago),
	constraint C_CHEQUE_monto check (monto > 0)
);

create table SEGURO (
	numAprobacion	int				not null,
	fkpago 			int				not null,
	compania 		varchar(30)		not null,
	asegurado 		varchar(80)		not null,
	numContrato 	varchar(20)		not null,
	tipo 			varchar(20)		not null,
	monto			int				not null,
	
	constraint PK_SEGURO primary key (numAprobacion),
	constraint AK_SEGURO unique (fkpago),
	constraint FK_SEGURO_PAGO foreign key (fkpago) references PAGO (pago),
	constraint C_SEGURO_monto check (monto > 0)
);

create table CONSULTA (
	fecha 		date				not null,
	hora 		time				not null,
	pers_m 		int					not null,
	pers_p 		int					not null,
	diagnostico varchar(50)			not null,
	fecha_prox 	date				null,
	hora_prox 	time				null,
	razon		varchar(30)			not null,
	
	constraint PK_CONSULTA primary key (fecha, hora, pers_m, pers_p),
	constraint FK_CONSULTA_MEDICO foreign key (pers_m) references MEDICO (pers),
	constraint FK_CONSULTA_PERSONA foreign key (pers_p) references PERSONA (pers),
	constraint C_CONSULTA_diagnostico check (diagnostico ~*'^[A-Z][a-z]+'),
	constraint C_CONSULTA_razon check (razon ~*'^[A-Z][a-z]+'),
	constraint C_CONSULTA_fecha_prox check ((fecha_prox > fecha) OR (hora_prox > hora))
);

create table SINTOMA (
	fecha 	date					not null,
	hora 	time					not null,
	pers_m 	int						not null,
	pers_p 	int						not null,
	sintoma varchar(20)				not null,

	constraint PK_SINTOMA primary key (fecha, hora, pers_m, pers_p, sintoma),
	constraint FK_CONSULTA_MEDICO foreign key (pers_m, pers_p, fecha, hora) references CONSULTA (pers_m, pers_p, fecha, hora),
	constraint C_SINTOMA_sintoma check (sintoma ~*'^[A-Z][a-z]+')
);

create table EXAMEN_ORDENADO (
	fecha 	date					not null,
	hora 	time					not null,
	pers_m 	int						not null,
	pers_p 	int						not null,
	examen 	varchar(20)				not null,
	
	constraint PK_EXAMEN_ORDENADO primary key (fecha, hora, pers_m, pers_p, examen),
	constraint FK_EXAMEN_ORDENADO_CONSULTA foreign key (pers_m, pers_p, fecha, hora) references CONSULTA (pers_m, pers_p, fecha, hora),
	constraint C_EXAMEN_ORDENADO_examen check (examen ~*'^[A-Z][a-z]+')
);

create table INTERVENCION (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	tiempo				time		not null,
	edo_final			varchar(30)	not null,
	tipo_anestesia		varchar(30)	not null,
	cantidad_anestesia	varchar(30)	not null,
	razon				varchar(30)	not null,
	
	constraint PK_INTERVENCION primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint FK_INTERVENCION_MEDICO foreign key (pers_m) references MEDICO (pers),
	constraint FK_INTERVENCION_PERSONA foreign key (pers_p) references PERSONA (pers),
	constraint FK_INTERVENCION_ANESTESIOLOGO foreign key (anestesiologo) references MEDICO (pers),
	constraint C_INTERVENCION_edo_final check (edo_final ~*'^[A-Z][a-z]+'),
	constraint C_INTERVENCION_cantidad_anestesia check (cantidad_anestesia ~*'^[0-9]+[a-z]+$'),
	constraint C_INTERVENCION_razon check (razon ~*'^[A-Z][a-z]+'),
	constraint C_INTERVENCION_pers_m_anestesiologo check (pers_m != anestesiologo)
);

create table observacionINTER (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	observacion 		varchar(50)	not null,
		
	constraint PK_observacionINTER primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, observacion),
	constraint FK_observacionINTER_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_observacionINTER_observacion check (observacion ~*'^[A-Z][a-z]+')	
);

create table complicacionINTER (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	complicacion 		varchar(50)	not null,
		
	constraint PK_complicacionINTER primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, complicacion),
	constraint FK_copmlicacionINTER_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_complicacionINTER_complicacion check (complicacion ~*'^[A-Z][a-z]+')
);

create table examenprevINTER (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	examen 				varchar(50)	not null,
		
	constraint PK_examenprevINTER primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, examen),
	constraint FK_examenprevINTER_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_examenprevINTER_examen check (examen ~*'^[A-Z][a-z]+')
);

create table utensilioINTER (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	nombre				varchar(10) not null,
	cantidad 			int			not null,
	
	constraint PK_utensilioINTER primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, cantidad),
	constraint FK_utensilioINTER_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_utensilioINTER check (cantidad > 0),
	constraint C_utensilioINTER_nombre check (nombre ~*'^[A-Z][a-z]+')
);

create table PARTO (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	huella_del_pie 		varchar(50)	not null,
	nombre 				varchar(80)	not null,
	sexo 				char		not null,
	tamano 				int			not null,
	tipo_sangre 		varchar(4)	not null,
	
	constraint PK_PARTO primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, huella_del_pie),
	constraint FK_PARTO_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_PARTO_nombre check (nombre ~*'^[A-Z][a-z]+'),
	constraint C_PARTO_sexo check (sexo ~*'f|F|m|M'),
	constraint C_PARTO_tipo_sangre check (tipo_sangre ~*'A+|A-|AB+|AB-|O+|O-|B+|B-'),
	constraint C_PARTO_tamano check (tamano > 0)
);


create table anomaliaPARTO (
	numQuirofano 		varchar(10)	not null,
	fecha 				date		not null,
	hora 				time		not null,
	pers_m 				int			not null,
	pers_p 				int			not null,
	anestesiologo		int			not null,
	huella_del_pie 		varchar(50)	not null,
	anomalia 			varchar(20)	not null,
	
	constraint PK_anomaliaPARTO primary key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, huella_del_pie, anomalia),
	constraint FK_anomaliaPARTO_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, huella_del_pie) references PARTO (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo, huella_del_pie),
	constraint C_anomaliaPARTO_anomalia check (anomalia ~* '^[A-Z][a-z]+')
);

create table R_PAGA_CONSULTA (
	pers_m 		int					not null,
	pers_p 		int					not null,
	fecha 		date				not null,
	hora 		time				not null,
	pers 		int					not null,
	pago 		int					not null,
	numFactura 	int					not null,
	
	constraint PK_PAGA_CONSULTA primary key (pers_m, pers_p, fecha, hora, pers, pago),
	constraint FK_PAGA_CONSULTA_PACIENTE foreign key (pers) references PACIENTE (pers),
	constraint FK_PAGA_CONSULTA_PAGO foreign key (pago) references PAGO (pago),
	constraint FK_PAGA_CONSULTA_CONSULTA foreign key (pers_m, pers_p, fecha, hora) references CONSULTA (pers_m, pers_p, fecha, hora)
);

create table R_PAGA_INTERVENCION (
	fecha 			date			not null,
	hora 			time			not null,
	pers_m 			int				not null,
	pers_p 			int				not null,
	anestesiologo	int				not null,
	numQuirofano	varchar(10)		not null,
	pers 			int				not null,
	pago 			int				not null,
	numFactura 		int				not null,
	
	constraint PK_PAGA_INTERVENCION primary key (fecha, hora, pers_m, pers_p, anestesiologo, numQuirofano, pers, pago),
	constraint FK_PAGA_INTERVENCION_PACIENTE foreign key (pers) references PACIENTE (pers),
	constraint FK_PAGA_INTERVENCION_PAGO foreign key (pago) references PAGO (pago),
	constraint FK_PAGA_INTERVENCION_INTERVENCION foreign key (fecha, hora, pers_m, pers_p, numQuirofano, anestesiologo) references INTERVENCION (fecha, hora, pers_m, pers_p, numQuirofano, anestesiologo)
);
	
create table R_ASISTE (
	pers 			int				not null,
	numQuirofano 	varchar(10)		not null,
	fecha 			date			not null,
	hora 			time			not null,
	pers_m 			int				not null,
	pers_p 			int				not null,
	anestesiologo 	int				not null,
	
	constraint PK_R_ASISTE primary key (pers, numQuirofano, pers_m, pers_p, fecha, hora, anestesiologo),
	constraint FK_R_ASISTE_MEDICO foreign key (pers) references MEDICO (pers),
	constraint FK_R_ASISTE_INTERVENCION foreign key (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo) references INTERVENCION (numQuirofano, fecha, hora, pers_m, pers_p, anestesiologo),
	constraint C_R_ASISTE_pers_m_pers_anestesiologo check ((pers != pers_m) AND (pers != anestesiologo))
);

CREATE TABLE R_TRATA (
	pers	int						not null,
	med		int						not null,
	actual	char(2) 				not null,

	constraint PK_R_TRATA primary key (pers, med),
	constraint FK_R_TRATA_PERSONA foreign key (pers) references PERSONA (pers),
	constraint FK_R_TRATA_MEDICO foreign key (med) references MEDICO (pers),
	constraint C_TRATA_pers_med check (pers != med),
	constraint C_TRATA_actual check (actual ~* 'si|no')
);

CREATE TABLE R_ES_FAMILIA (
	pers 		int					not null,
	paciente	int					not null,
	relacion	varchar(10)			not null,
	
	constraint PK_R_ES_FAMILIA primary key (pers, paciente),
	constraint FK_R_ES_FAMILIA_PERSONA foreign key (pers) references PERSONA (pers),
	constraint FK_R_ES_FAMILIA_PACIENTE foreign key (paciente) references PACIENTE (pers),
	constraint C_R_ES_FAMILIA_RELACION check (relacion = 'Conyugue' OR relacion = 'Hijo' OR relacion = 'Padre'),
	constraint C_R_ES_FAMILIA_pers_paciente check (pers != paciente)
);