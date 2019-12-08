--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = forapi, pg_catalog;

--
-- Data for Name: cat_bitacora; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_bitacora (idbitacora, idproceso, fecha_inicio, fecha_fin, at_inicio, at_fin, estado, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: cat_bitacora_idbitacora_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_bitacora_idbitacora_seq', 50, true);


--
-- Name: cat_bitacora_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_bitacora_seq', 1, false);


--
-- Data for Name: cat_preguntas; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_preguntas (idpregunta, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: cat_preguntas_idpregunta_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('cat_preguntas_idpregunta_seq', 1, false);


--
-- Name: cat_preguntas_seq; Type: SEQUENCE SET; Schema: forapi; Owner: inicio
--

SELECT pg_catalog.setval('cat_preguntas_seq', 100, false);


--
-- Data for Name: cat_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_usuarios (usename, nombre, apepat, apemat, puesto, depto, correoe, direccion_ip, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, idpregunta, respuesta, estatus, telefono, direccion, atl, id_direccion, id_persona, password, id_puesto, id_tipomenu, menu, id_modulo, rfc, llaveprivada, llavepublica, numerotel, imagen) FROM stdin;
inicio	inicio	\N	\N	\N	\N	\N	\N	2019-10-12 14:53:07-06	2019-10-12 15:16:17.631751-06	inicio	inicio	0	\N	1	\N	\N	\N	\N	\N	inicio	\N	1	17	0				\N	\N
usuario20	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 08:13:25-06	2019-10-16 08:13:25-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				565672416	\N
usuario21	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 08:17:22-06	2019-10-16 08:17:22-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				565672416	\N
usuario80	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-16 12:46:49-06	2019-10-16 12:46:49-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				56572416	\N
usuario81	JOSE	LUIS	VASQUEZ	\N	\N	\N	\N	2019-10-16 15:49:04-06	2019-10-16 15:49:04-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario10	JOSE	VASQ	BAR	\N	\N	\N	\N	2019-10-20 07:33:01-06	2019-10-20 07:33:01-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario11	JOSE	VASQUEZ	BARBOSA	\N	\N	\N	\N	2019-10-20 07:41:22-06	2019-10-20 07:41:22-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
inicio5	JOSE	LUIS	VASQUEZ	\N	\N	\N	\N	2019-10-20 07:54:23-06	2019-10-20 07:54:23-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
usuario4	JOSE	VAS	BARBOSA	\N	\N	\N	\N	2019-10-20 07:56:51-06	2019-10-20 07:56:51-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
inicio78	JOSE	LUIS	\N	\N	\N	\N	\N	2019-10-20 14:02:34-06	2019-10-20 14:02:34-06	temporal	temporal	0	\N	0	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\\x31342e786c7378
tmp_jc9	temporal	\N	\N	\N	\N	\N	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:43.784708-06	jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	jc9	\N	1	\N	0				\N	\N
jc9	jc9	\N	\N	\N	\N	\N	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:43.833875-06	jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	jc9	\N	1	17	0				\N	\N
juez1	NOMBRE	PATERNO	\N	\N	\N	\N	\N	2019-10-30 17:18:25-06	2019-10-30 17:23:57.288473-06	tmp_jc9	jc9	0	\N	1	\N	\N	\N	\N	\N	juez11	\N	1	61	0				5556572416	\N
tmp_jc101	temporal	\N	\N	\N	\N	\N	\N	2019-10-31 16:51:33-06	2019-10-31 16:51:32.744554-06	jc101	jc101	0	\N	1	\N	\N	\N	\N	\N	jc101	\N	1	\N	0				\N	\N
jc101	jc101	\N	\N	\N	\N	\N	\N	2019-10-31 16:51:33-06	2019-10-31 16:51:32.784103-06	jc101	jc101	0	\N	1	\N	\N	\N	\N	\N	jc101	\N	1	17	0				\N	\N
jc104	jc104	\N	\N	\N	\N	\N	\N	2019-10-31 17:00:06-06	2019-11-03 09:26:56.914106-07	jc104	jc104	0	\N	1	\N	\N	\N	\N	\N	jc104	\N	1	17	0				\N	\N
tmp_jc104	temporal	\N	\N	\N	\N	\N	\N	2019-10-31 17:00:06-06	2019-11-03 09:30:37.285462-07	jc104	jc104	0	\N	1	\N	\N	\N	\N	\N	jc104	\N	1	\N	0				\N	\N
jlvdantry@hotmail.com	JOSE	LUIS	VASQUEZ	\N	\N	\N	\N	2019-12-05 15:17:02-07	2019-12-06 16:54:15.208557-07	tmp_jc104	jc104	0	\N	1	\N	\N	\N	\N	\N	888aDantryR	\N	1	\N	0				5556572416	\N
\.


--
-- Data for Name: cat_usuarios_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY cat_usuarios_pg_group (usename, grosysid, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, groname) FROM stdin;
inicio	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	admon
temporal1	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	temporalg
forapi	\N	2019-10-27 15:35:24-06	2019-10-27 15:35:24-06	inicio	inicio	accesosistema
forapi	\N	2019-10-27 15:35:53-06	2019-10-27 15:35:53-06	inicio	inicio	accesosistema
forapi	\N	2019-10-27 15:36:50-06	2019-10-27 15:36:50-06	inicio	inicio	accesosistema
tmp_jc9	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:44-06	jc9	jc9	temporalg
jc9	\N	2019-10-27 17:02:44-06	2019-10-27 17:02:44-06	jc9	jc9	admon
juez1	\N	2019-10-30 17:19:30-06	2019-10-30 17:19:30-06	jc9	jc9	juez
tmp_jc101	\N	2019-10-31 16:51:33-06	2019-10-31 16:51:33-06	jc101	jc101	temporalg
jc101	\N	2019-10-31 16:51:33-06	2019-10-31 16:51:33-06	jc101	jc101	admon
tmp_jc104	\N	2019-10-31 17:00:06-06	2019-10-31 17:00:06-06	jc104	jc104	temporalg
jc104	\N	2019-10-31 17:00:06-06	2019-10-31 17:00:06-06	jc104	jc104	admon
jlvdantry@hotmail.com	\N	2019-12-06 11:01:00-07	2019-12-06 11:01:00-07	jc104	jc104	admon
\.


--
-- Data for Name: estados_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY estados_usuarios (estado, descripcion) FROM stdin;
\.


--
-- Data for Name: eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY eventos (idevento, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: eventos_idevento_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('eventos_idevento_seq', 1, false);


--
-- Data for Name: his_cambios_pwd; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cambios_pwd (usename, valor_anterior, valor_nuevo, usuario_alta, fecha_alta, hora_alta) FROM stdin;
\.


--
-- Data for Name: his_cat_usuarios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cat_usuarios (idcambio, usename, nombre, apepat, apemat, puesto, depto, correoe, direccion_ip, fecha_alta, fecha_modifico, idpregunta, respuesta, estatus, telefono, cve_movto, id_personas, atl, id_puesto, usuario_alta, usuario_modifico) FROM stdin;
\.


--
-- Name: his_cat_usuarios_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_idcambio_seq', 109, true);


--
-- Data for Name: his_cat_usuarios_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_cat_usuarios_pg_group (idcambio, usename, grosysid, fecha_alta, usuario_alta, cve_movto) FROM stdin;
\.


--
-- Name: his_cat_usuarios_pg_group_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_pg_group_idcambio_seq', 13, true);


--
-- Name: his_cat_usuarios_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_cat_usuarios_seq', 1, false);


--
-- Data for Name: his_menus; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus (idmenu, descripcion, objeto, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height, cvemovto, fecha_movto, usuario_movto, nspname) FROM stdin;
\.


--
-- Data for Name: his_menus_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus_pg_group (idcambio, idmenu, grosysid, fecha_alta, usuario_alta, cve_movto) FROM stdin;
\.


--
-- Name: his_menus_pg_group_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_group_idcambio_seq', 375, true);


--
-- Name: his_menus_pg_group_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_group_seq', 1, false);


--
-- Data for Name: his_menus_pg_tables; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_menus_pg_tables (idcambio, idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, cve_movto, fecha_alta, usuario_modifico, tgrant) FROM stdin;
\.


--
-- Name: his_menus_pg_tables_idcambio_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('his_menus_pg_tables_idcambio_seq', 886, true);


--
-- Data for Name: his_tablas_cambios; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY his_tablas_cambios (nspname, tabla, attnum, idregcambio, valor_anterior, valor_nuevo, usuario_alta, fecha_alta, idmenu) FROM stdin;
\.


--
-- Data for Name: menus; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus (idmenu, descripcion, objeto, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, php, modoconsulta, idmenupadre, idmovtos, movtos, fuente, presentacion, columnas, tabla, reltype, filtro, limite, orden, menus_campos, dialogwidth, dialogheight, s_table, s_table_height, inicioregistros, nspname, css, imprime, limpiaralta, table_width, table_height, table_align, manual, noconfirmamovtos, icono, ayuda) FROM stdin;
2	Desbloque de usuario		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	u		2	1	cat_usuarios	126000		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
3	Usuarios grupos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,l,f,a,ex		2	2	cat_usuarios_pg_group	126048		100	grosysid	0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00					
4	Registro		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i		2	1	cat_usuarios	126000	usename is null	100	usename	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
5	Historico Usuario		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	s		2	2	his_cat_usuarios	126104		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
6	Solicita usuario a Desbloquear		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	s,S		2	1	cat_usuarios	126000		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
7	Menus eventos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,a,l		2	2	menus_eventos	126274		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
8	accesosistema		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	accesosistema	0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
11	Mtto a usuarios ventanilla		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	10	0	i,u,s,l,p,d,a		2	4	cat_usuarios	126000		50	nombre	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
15	Autorizacion de personal		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	10	0	s,u,l,a		2	1	cat_usuarios	126000	estatus=0	100	fecha_alta desc	0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
21	Grupos Menus		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio		0	0	0	i,d,u,s,a,l		2	2	menus_pg_group	126331		100		0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00					
23	Carga LLave privada y publica		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	e		2	1	cat_usuarios	126000	usuario_alta is null	100		0	500	0	0	300	f	forapi	pupanint.css	0	t	30.00	0.00	center				
24	Cambio de Contraseña		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	u		2	1	cat_usuarios	126000	usename='jlv8'	1		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
25	Cambio de password		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	u		2	1	cat_usuarios	126000	cast(usename as text) = getpgusername()	100		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
26	Log de los menus		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	s,l,a.f		2	2	menus_log	126296		100	fecha_alta desc	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
27	menus_movtos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l		2	2	menus_movtos	126321		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
28	menus_seguimiento		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l,a		2	2	menus_seguimiento	126363		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
29	menus_tiempos		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	man_menus.php	0	0	0	i,d,u,s,l,a		2	2	menus_tiempos	126389		100		0	0	0	0	300	f	forapi		0	t	0.00	0.00					
18	Autorizacion de registro		2019-10-12 14:53:07-06	inicio	2019-10-19 19:36:11-06	inicio	man_menus.php	0	10	0	s,u,l,a		2	2	cat_usuarios	126000	estatus=0	100	fecha_alta desc	0	0	0	0	300	t	forapi	pupanint.css	0	t	60.00	0.00	center				
10	Administración		2019-10-12 14:53:07-06	inicio	2019-10-27 07:57:17-06	inicio		0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
9	Bienvenido		2019-10-12 14:53:07-06	inicio	2019-10-19 19:06:09-06	inicio		0	0	0	l,e,A		2	2	cat_usuarios	126000	usuario_alta is null	100		0	500	0	0	300	f	forapi	pupanint.css	0	t	40.00	0.00	center				
19	Registro Nuevo Usuario		2019-10-12 14:53:07-06	inicio	2019-10-19 19:07:54-06	inicio	man_menus.php	0	0	0	i,a		2	2	cat_usuarios	126000	usename is null	100	usename	0	0	0	0	300	f	forapi	pupanint.css	0	t	60.00	0.00	center				
12	Mtto a grupo de campos		2019-10-12 14:53:07-06	inicio	2019-10-29 14:01:00-06	jc9	man_menus.php	0	10	0	i,d,u,s,l,a		2	2	menus_htmltable	126283		100		0	0	0	0	300	t	forapi	pupanint.css	0	t	0.00	0.00					
13	Reingenieria		2019-10-12 14:53:07-06	inicio	2019-10-29 05:35:23-06	jc9	man_menus.php	0	10	0	s,i,a,l		2	1	tablas	126401		100	relname	0	0	0	0	300	f	forapi	pupanint.css	0	t	30.00	0.00	center				
20	Campos de menus		2019-10-12 14:53:07-06	inicio	2019-11-03 08:53:31-07	jc104	man_menus.php	0	0	0	i,d,u,s,l,a,cc,f		2	2	menus_campos	126222		100	htmltable,orden	0	0	0	0	280	f	forapi	pupanint.css	0	f	0.00	0.00	col-lg-10				
16	Mtto a grupos		2019-10-12 14:53:07-06	inicio	2019-11-02 17:58:45-06	jc104	man_menus.php	0	10	0	i,d,u,s,a,l		2	1	pg_authid	2842	rolcanlogin=false	100	rolname	0	0	0	0	300	t	pg_catalog	pupanint.css	0	t	80.00	0.00	center				
1	Seguridad tablas		2019-10-12 14:53:07-06	inicio	2019-11-03 09:22:54-07	jc104		0	0	0	i,d,u,s,l		2	2	menus_pg_tables	126341		100		0	0	0	0	300	f	forapi	pupanint.css	0	f	0.00	0.00	col-lg-8				
30	Subvistas		2019-10-12 14:53:07-06	inicio	2019-11-03 13:27:09-07	jc104		0	0	0	i,d,u,s,l,a,cc		2	2	menus_subvistas	126370		100	orden	0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00	col-lg-8				
62	Mtto. Grupos de campos	\N	2019-10-29 14:01:00-06	jc9	2019-10-29 14:04:13-06	jc9	man_menus.php	\N	10	\N	i,d,u,s,l,a	\N	2	2	menus_htmltable	134448	\N	100	\N	0	0	0	0	300	t	forapi	\N	0	t	80.00	0.00	center	\N			
32	Catalogos		2019-10-27 07:50:24-06	inicio	2019-10-30 16:14:30-06	jc9		0	0	0	i,d,u,s		2	2		0		100		0	0	0	0	300	f	forapi	pupanint.css	0	t	0.00	0.00					
46	Importa desde script	\N	2019-10-28 18:51:03-06	jc9	2019-11-05 09:29:43-07	jc104	man_menus.php	\N	10	\N	i,d,u,s,l,a	\N	2	1	menus_scripts	134741	\N	100	fecha_modifico desc	0	90	0	0	300	t	forapi	\N	0	t	90.00	0.00	col-lg-10	\N			
66	boletas	\N	2019-10-31 17:25:09-06	jc104	2019-11-06 15:09:33-07	jc104	man_menus.php	\N	\N	\N	i,d,u,s,l,a,H	\N	2	2	boletas	147506	\N	100	\N	0	0	0	0	300	t	jc	\N	0	t	80.00	0.00	col-lg-8	\N			
64	juzgados	\N	2019-10-31 17:25:01-06	jc104	2019-11-02 14:32:08-06	jc104	man_menus.php	\N	\N	\N	i,d,u,s,l,a	\N	2	2	juzgados	147467	\N	100	\N	0	0	0	0	300	f	jc	\N	0	t	80.00	0.00	col-lg-6	\N			
17	Mtto a usuarios		2019-10-12 14:53:07-06	inicio	2019-11-02 17:12:09-06	jc104	man_menus.php	0	10	0	u,s,l,d,a,ex		2	2	cat_usuarios	126000		50	nombre	0	60	0	0	300	t	forapi	pupanint.css	0	t	60.00	0.00	col-lg-8				
14	Mtto a menus		2019-10-12 14:53:07-06	inicio	2019-11-02 17:39:51-06	jc104	man_menus.php	0	10	0	i,d,u,s,l,cc,ex,a	select id_voluntario,no_cred_elect, nombre, apepat, apemat, domicilio, no_ext, id_entidad from cat_voluntarios 	2	2	menus	126182		100	fecha_alta desc	0	0	0	0	300	f	forapi	pupanint.css	1	t	80.00	0.00	col-lg-8				
65	infracciones	\N	2019-10-31 17:25:05-06	jc104	2019-11-02 17:56:23-06	jc104	man_menus.php	\N	\N	\N	i,d,u,s,l,a	\N	2	2	infracciones	147479	\N	100	\N	0	0	0	0	300	f	jc	\N	0	t	80.00	0.00	center	\N			
63	sanciones	\N	2019-10-31 17:24:57-06	jc104	2019-11-02 17:59:47-06	jc104	man_menus.php	\N	\N	\N	i,d,u,s,l,a	\N	2	2	sanciones	147494	\N	100	\N	0	0	0	0	300	f	jc	\N	0	t	80.00	0.00	col-lg-8	\N			
31	Importa desde Excel		2019-10-20 19:38:33-06	inicio	2019-12-01 12:45:09-07	jc104	man_menus.php	0	10	0	a,l,s,i,u,d		2	1	menus_excels	126401		100	fecha_alta desc	0	0	0	0	300	t	forapi	pupanint.css	0	t	30.00	0.00	col-lg-8				
154	opciones	\N	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	man_menus.php	\N	\N	\N	i,d,u,s,l,a	\N	2	2	opciones	152747	\N	100	\N	0	0	0	0	300	f	jc	\N	0	t	80.00	0.00	col-lg-6	\N			
\.


--
-- Data for Name: menus_archivos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_archivos (idarchivo, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, version, idtipoarchivo, "tamaño", ubicacion) FROM stdin;
1	A_F01.xlsx	2019-10-20 09:12:54-06	temporal	2019-10-20 09:12:54-06	temporal	\N	0	0	\N
2	1a Quincena de enero 2017 Oficinas Centrales.xlsx	2019-10-20 09:20:47-06	temporal	2019-10-20 09:20:47-06	temporal	\N	0	0	\N
3	193_736262955.pdf	2019-10-20 09:32:58-06	temporal	2019-10-20 09:32:58-06	temporal	\N	0	0	\N
4	1a Quincena de enero 2017 Oficinas Centrales.xlsx	2019-10-20 09:40:41-06	temporal	2019-10-20 09:40:41-06	temporal	\N	0	0	\N
5	factura_201905.pdf	2019-10-20 09:52:28-06	temporal	2019-10-20 09:52:28-06	temporal	\N	0	0	\N
6	factura_201905.pdf	2019-10-20 09:58:00-06	temporal	2019-10-20 09:58:00-06	temporal	\N	0	0	\N
7	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 10:05:55-06	temporal	2019-10-20 10:05:55-06	temporal	\N	0	0	\N
8	VPN Windows.pdf	2019-10-20 13:43:52-06	temporal	2019-10-20 13:43:52-06	temporal	\N	0	0	\N
9	VPN Windows.pdf	2019-10-20 13:46:40-06	temporal	2019-10-20 13:46:40-06	temporal	\N	0	0	\N
10	AtenticacionLaravel.docx	2019-10-20 13:47:01-06	temporal	2019-10-20 13:47:01-06	temporal	\N	0	0	\N
11	VPN Windows.pdf	2019-10-20 13:48:08-06	temporal	2019-10-20 13:48:08-06	temporal	\N	0	0	\N
12	VPN Windows.pdf	2019-10-20 13:51:15-06	temporal	2019-10-20 13:51:15-06	temporal	\N	0	0	\N
13	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 13:57:14-06	temporal	2019-10-20 13:57:14-06	temporal	\N	0	0	\N
14	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-20 14:01:59-06	temporal	2019-10-20 14:01:59-06	temporal	\N	0	0	\N
15	DEJC CATALOGOS-ADIP.xlsx	2019-10-20 17:50:11-06	temporal	2019-10-20 17:50:11-06	temporal	\N	0	0	\N
16	DEJC CATALOGOS-ADIP.xlsx	2019-10-20 18:24:11-06	temporal	2019-10-20 18:24:11-06	temporal	\N	0	0	\N
17	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-31 10:58:36-06	jc9	2019-10-31 10:58:36-06	jc9	\N	0	0	\N
18	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-10-31 11:08:31-06	jc9	2019-10-31 11:08:31-06	jc9	\N	0	0	\N
19	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-11-01 11:26:47-06	jc104	2019-11-01 11:26:47-06	jc104	\N	0	0	\N
20	AnalisisDeFiltrosEnProteccionCivil.xlsx	2019-11-03 09:30:53-07	tmp_jc104	2019-11-03 09:30:53-07	tmp_jc104	\N	0	0	\N
21	factura_201905.pdf	2019-11-03 13:49:47-07	jc104	2019-11-03 13:49:47-07	jc104	\N	0	0	\N
22	esquema_excel.xlsx	2019-11-03 13:50:38-07	jc104	2019-11-03 13:50:38-07	jc104	\N	0	0	\N
23	esquema_excel.xlsx	2019-11-18 08:59:12-07	jc104	2019-11-18 08:59:12-07	jc104	\N	0	0	\N
24	esquema_excel.xlsx	2019-11-18 09:01:41-07	jc104	2019-11-18 09:01:41-07	jc104	\N	0	0	\N
25	esquema_excel.xlsx	2019-11-18 10:13:23-07	jc104	2019-11-18 10:13:23-07	jc104	\N	0	0	\N
26	esquema_excel.xlsx	2019-11-18 10:13:56-07	jc104	2019-11-18 10:13:56-07	jc104	\N	0	0	\N
27	esquema_excel.xlsx	2019-11-18 10:15:52-07	jc104	2019-11-18 10:15:52-07	jc104	\N	0	0	\N
28	esquema_excel.xlsx	2019-11-18 10:47:04-07	jc104	2019-11-18 10:47:04-07	jc104	\N	0	0	\N
29	esquema_excel.xlsx	2019-11-18 10:47:18-07	jc104	2019-11-18 10:47:18-07	jc104	\N	0	0	\N
30	esquema_excel.xlsx	2019-11-18 11:10:48-07	jc104	2019-11-18 11:10:48-07	jc104	\N	0	0	\N
31	esquema_excel.xlsx	2019-11-18 11:11:29-07	jc104	2019-11-18 11:11:29-07	jc104	\N	0	0	\N
32	esquema_excel.xlsx	2019-11-18 11:19:30-07	jc104	2019-11-18 11:19:30-07	jc104	\N	0	0	\N
33	esquema_excel.xlsx	2019-11-18 11:19:55-07	jc104	2019-11-18 11:19:55-07	jc104	\N	0	0	\N
34	esquema_excel.xlsx	2019-11-18 11:23:35-07	jc104	2019-11-18 11:23:35-07	jc104	\N	0	0	\N
35	esquema_excel.xlsx	2019-11-18 11:24:38-07	jc104	2019-11-18 11:24:38-07	jc104	\N	0	0	\N
36	esquema_excel.xlsx	2019-11-18 11:28:57-07	jc104	2019-11-18 11:28:57-07	jc104	\N	0	0	\N
37	esquema_excel.xlsx	2019-11-18 11:29:57-07	jc104	2019-11-18 11:29:57-07	jc104	\N	0	0	\N
38	esquema_excel.xlsx	2019-11-18 11:31:21-07	jc104	2019-11-18 11:31:21-07	jc104	\N	0	0	\N
39	esquema_excel.xlsx	2019-11-18 11:31:57-07	jc104	2019-11-18 11:31:57-07	jc104	\N	0	0	\N
40	esquema_excel.xlsx	2019-11-18 11:34:07-07	jc104	2019-11-18 11:34:07-07	jc104	\N	0	0	\N
41	esquema_excel.xlsx	2019-11-18 11:34:51-07	jc104	2019-11-18 11:34:51-07	jc104	\N	0	0	\N
42	esquema_excel.xlsx	2019-11-18 11:41:46-07	jc104	2019-11-18 11:41:46-07	jc104	\N	0	0	\N
43	esquema_excel.xlsx	2019-11-18 12:21:44-07	jc104	2019-11-18 12:21:44-07	jc104	\N	0	0	\N
44	esquema_excel.xlsx	2019-11-18 13:19:52-07	jc104	2019-11-18 13:19:52-07	jc104	\N	0	0	\N
45	esquema_excel.xlsx	2019-11-18 16:17:56-07	jc104	2019-11-18 16:17:56-07	jc104	\N	0	0	\N
46	esquema_excel.xlsx	2019-11-18 16:20:08-07	jc104	2019-11-18 16:20:08-07	jc104	\N	0	0	\N
47	esquema_excel.xlsx	2019-11-18 16:29:57-07	jc104	2019-11-18 16:29:57-07	jc104	\N	0	0	\N
48	esquema_excel.xlsx	2019-11-18 16:30:58-07	jc104	2019-11-18 16:30:58-07	jc104	\N	0	0	\N
49	esquema_excel.xlsx	2019-11-18 16:35:37-07	jc104	2019-11-18 16:35:37-07	jc104	\N	0	0	\N
50	esquema_excel.xlsx	2019-11-18 17:05:01-07	jc104	2019-11-18 17:05:01-07	jc104	\N	0	0	\N
51	esquema_excel.xlsx	2019-11-18 17:13:47-07	jc104	2019-11-18 17:13:47-07	jc104	\N	0	0	\N
52	esquema_excel.xlsx	2019-11-18 17:18:40-07	jc104	2019-11-18 17:18:40-07	jc104	\N	0	0	\N
53	esquema_excel.xlsx	2019-11-18 17:20:25-07	jc104	2019-11-18 17:20:25-07	jc104	\N	0	0	\N
54	esquema_excel.xlsx	2019-11-18 17:22:59-07	jc104	2019-11-18 17:22:59-07	jc104	\N	0	0	\N
55	esquema_excel.xlsx	2019-11-18 17:30:19-07	jc104	2019-11-18 17:30:19-07	jc104	\N	0	0	\N
56	esquema_excel.xlsx	2019-11-18 17:44:44-07	jc104	2019-11-18 17:44:44-07	jc104	\N	0	0	\N
57	esquema_excel.xlsx	2019-11-18 17:47:49-07	tmp_jc104	2019-11-18 17:47:49-07	tmp_jc104	\N	0	0	\N
58	esquema_excel.xlsx	2019-11-18 17:53:21-07	jc104	2019-11-18 17:53:21-07	jc104	\N	0	0	\N
59	esquema_excel.xlsx	2019-11-18 19:52:20-07	jc104	2019-11-18 19:52:20-07	jc104	\N	0	0	\N
60	esquema_excel.xlsx	2019-11-18 20:21:05-07	jc104	2019-11-18 20:21:05-07	jc104	\N	0	0	\N
61	60.xlsx	2019-11-21 14:46:12-07	jc104	2019-11-21 14:46:12-07	jc104	\N	0	0	\N
62	60.xlsx	2019-11-21 14:53:27-07	jc104	2019-11-21 14:53:27-07	jc104	\N	0	0	\N
63	62.xlsx	2019-11-21 16:18:54-07	jc104	2019-11-21 16:18:54-07	jc104	\N	0	0	\N
64	62.xlsx	2019-11-21 16:21:27-07	jc104	2019-11-21 16:21:27-07	jc104	\N	0	0	\N
65	62.xlsx	2019-11-21 16:39:19-07	jc104	2019-11-21 16:39:19-07	jc104	\N	0	0	\N
66	consulta_jc104.xls	2019-11-21 16:40:11-07	jc104	2019-11-21 16:40:11-07	jc104	\N	0	0	\N
67	701_1961539241 (1).pdf	2019-11-21 16:40:30-07	jc104	2019-11-21 16:40:30-07	jc104	\N	0	0	\N
68	65.xlsx	2019-11-23 10:09:39-07	jc104	2019-11-23 10:09:39-07	jc104	\N	0	0	\N
69	QueHaceFalta al 30-08-2019.docx	2019-11-25 10:17:44-07	jc104	2019-11-25 10:17:44-07	jc104	\N	0	0	\N
70	QueHaceFalta al 30-08-2019.docx	2019-11-25 12:08:51-07	jc104	2019-11-25 12:08:51-07	jc104	\N	0	0	\N
71	Catálogos Plataforma.xlsx	2019-11-25 12:54:13-07	jc104	2019-11-25 12:54:13-07	jc104	\N	0	0	\N
72	QueHaceFalta al 30-08-2019.docx	2019-11-25 13:24:25-07	jc104	2019-11-25 13:24:25-07	jc104	\N	0	0	\N
73	QueHaceFalta al 30-08-2019.docx	2019-11-25 13:24:30-07	jc104	2019-11-25 13:24:30-07	jc104	\N	0	0	\N
74	68.xlsx	2019-11-25 19:43:58-07	jc104	2019-11-25 19:43:58-07	jc104	\N	0	0	\N
75	74.xlsx	2019-11-30 10:40:50-07	jc104	2019-11-30 10:40:50-07	jc104	\N	0	0	\N
76	74.xlsx	2019-11-30 11:05:15-07	jc104	2019-11-30 11:05:15-07	jc104	\N	0	0	\N
77	74.xlsx	2019-11-30 11:35:46-07	jc104	2019-11-30 11:35:46-07	jc104	\N	0	0	\N
78	74.xlsx	2019-12-01 12:16:13-07	jc104	2019-12-01 12:16:13-07	jc104	\N	0	0	\N
79	78.xlsx	2019-12-01 13:10:37-07	jc104	2019-12-01 13:10:37-07	jc104	\N	0	0	\N
80	78.xlsx	2019-12-01 13:20:35-07	jc104	2019-12-01 13:20:35-07	jc104	\N	0	0	\N
81	80.xlsx	2019-12-01 13:47:05-07	jc104	2019-12-01 13:47:05-07	jc104	\N	0	0	\N
82	80.xlsx	2019-12-01 13:53:32-07	jc104	2019-12-01 13:53:32-07	jc104	\N	0	0	\N
83	80.xlsx	2019-12-01 14:04:28-07	jc104	2019-12-01 14:04:28-07	jc104	\N	0	0	\N
84	80.xlsx	2019-12-01 14:15:21-07	jc104	2019-12-01 14:15:21-07	jc104	\N	0	0	\N
\.


--
-- Name: menus_archivos_idarchivo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_archivos_idarchivo_seq', 84, true);


--
-- Data for Name: menus_campos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_campos (idcampo, idmenu, reltype, attnum, descripcion, size, male, fuente, fuente_campodes, fuente_campodep, fuente_campofil, fuente_where, fuente_evento, orden, idsubvista, dialogwidth, dialogheight, obligatorio, busqueda, altaautomatico, tcase, checaduplicidad, readonly, valordefault, esindex, tipayuda, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, espassword, tabla, nspname, fuente_busqueda, val_particulares, htmltable, fuente_nspname, altaautomatico_idmenu, fuente_busqueda_idmenu, upload_file, formato_td, colspantxt, rowspantxt, autocomplete, imprime, totales, cambiarencambios, link_file, fuente_info, fuente_info_idmenu, fuente_actu, fuente_actu_idmenu, eshidden, fila, clase, clase_label, clase_dato) FROM stdin;
1	25	126000	0	PasswordNuevo	30	30						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
7	2	126000	0	Respuesta_	50	50						0	0	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	0	\N	\N	\N
8	4	126000	0	TecleeDeNuevoPassword	20	30						0	250	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	250	\N	\N	\N
9	11	126000	0	Password	20	20						0	160	0	0	0	f	f	f	0	f	f		f	password	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	\N	\N	\N
11	25	126000	0	TecleedeNuevoPassword	30	30						0	30	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
12	25	126000	0	PasswordAnterior	30	30						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
13	24	126000	0	TecleedeNuevoPassword	30	30						0	30	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
15	23	126000	0	LLavePrivada	10	10						0	15	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	15	\N	\N	\N
16	23	126000	0	LLavePublica	10	10						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
18	5	126104	1	idcambio	8	0						0	10	0	40	30	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
19	21	126331	1	Opcion:	0	0	menus	descripcion	idmenu			0	10	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_group	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
20	11	126000	1	Usuario	20	15						0	10	0	40	30	t	t	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
22	2	126000	1	usename	19	0						0	10	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
23	25	126000	0	Usuario	30	30						0	5	0	0	0	t	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	5	\N	\N	\N
32	24	126000	1	Usuario	30	30						0	5	0	0	0	t	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	5	\N	\N	\N
33	3	126048	1	Usuario	1	0	cat_usuarios	usename	usename			0	10	0	40	30	t	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
10	19	126000	0	TecleeDeNuevoelpassword	30	30						0	250	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
14	18	126000	0	Password	20	30						0	0	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
34	18	126000	1	Usuario	20	15						0	10	0	40	30	f	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
17	20	126222	1	Idcampo	30	0						0	110	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
25	19	126000	1	Usuario	30	50						0	10	0	40	30	t	f	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
36	26	126296	1	idlog	8	0						0	900	0	40	30	t	f	f	0	f	t		t	registro en la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	900	\N	\N	\N
285	20	126222	54	Fila	30	100						0	400	0	0	0	f	f	f	0	f	f		f		2019-10-19 15:45:56-06	inicio	2019-10-19 15:45:56-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	65	col-md-6	\N	\N
40	27	126321	1	idmenu	8	0						0	10	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
41	28	126363	1	idseguimietno	8	0						0	10	0	40	30	t	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
42	2	126000	2	Nombre	30	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
43	15	126000	2	Nombre	20	30						0	20	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
44	4	126000	2	Nombre	20	30						0	20	0	40	30	t	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
45	27	126321	2	idmovto	5	0						0	20	0	40	30	f	f	f	0	f	f		t	i=insert,d=delete,s=select,u=upate,l=limpiar	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
49	28	126363	2	idmenu	8	0						0	20	0	40	30	t	f	f	0	f	f		f	Numero de menu a dar seguimietno si 9999999=todos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
54	26	126296	2	idmenu	1	0	menus	descripcion	idmenu			0	20	0	40	30	t	t	f	0	f	f		f	Numero de menu que utilizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
57	5	126104	2	usename	19	0						0	20	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
37	9	126000	1	Usuario	0	0						0	10	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
47	19	126000	2	Nombre	30	30						0	20	0	40	30	t	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
52	20	126222	2	Menu	1	0	menus	descripcion	idmenu			0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
51	11	126000	2	Nombre	20	30						0	20	0	40	30	t	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
59	7	126274	2	idmenu	8	0						0	20	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
38	12	126283	1	idhtmltable	8	-1						0	10	0	40	30	t	f	f	0	f	t		t	Numero de identificacion de la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
31	13	126401	1	Tabla	0	0						0	11	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	tablas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-12	\N	\N
654	66	147506	14	Calle	30	34					\N	0	140	\N	40	30	f	f	f	0	f	f	\N	f	Calle	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
60	4	126000	3	Apellido Paterno	20	30						0	30	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
61	5	126104	3	nombre	30	0						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
62	3	126048	3	Fecha alta	30	0						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
48	1	126341	2	Tabla	0	0	tablas	relname	relname	nspname		1	12	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
56	14	126182	2	Descripcion	99	0						0	20	0	40	30	t	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	80	3	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
65	7	126274	3	idevento	1	0	eventos	descripcion	idevento			0	30	0	40	30	t	f	t	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
68	27	126321	3	descripcion	30	0						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
69	2	126000	3	Apellido Paterno	30	0						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
72	28	126363	3	usename	24	0						0	30	0	40	30	f	f	f	0	f	f		f	Usuario a dar seguimiento *=todos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
73	15	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
79	5	126104	4	apepat	30	0						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
80	7	126274	4	donde	4	0						0	40	0	40	30	t	f	f	0	f	f		t	0=cliente 1=servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
71	19	126000	3	Apellido Paterno	30	30						0	30	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
50	18	126000	2	Nombre	20	30						0	20	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
64	18	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
75	26	126296	3	movto	5	0						0	910	0	40	30	f	f	f	0	f	t		f	Movimiento que hizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	910	\N	\N	\N
77	11	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
84	28	126363	4	fecha_alta	18	0						0	40	0	40	30	f	f	f	0	f	t		f	Fecha en que hizo el movimiento	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
63	12	126283	3	esdesistema	1	-1						0	30	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
655	66	147506	15	No. interior	19	19					\N	0	150	\N	40	30	f	f	f	0	f	f	\N	f	No. interior	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
656	66	147506	16	No. exterior	19	19					\N	0	160	\N	40	30	f	f	f	0	f	f	\N	f	No. exterior	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
85	11	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
86	15	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
87	27	126321	4	imagen	30	0						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
90	4	126000	4	Apellido Materno	20	30						0	40	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
91	26	126296	4	sql	-1	0						0	40	0	40	30	f	t	f	0	f	f		f	Movimiento que hizo el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
92	2	126000	4	Apellido Materno	30	0						0	40	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
93	3	126048	4	Fecha modifico	30	0						0	40	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	\N	\N	\N
101	26	126296	5	fecha_alta	18	0						0	10	0	40	30	f	f	f	0	f	t		f	Fecha en que hizo el movimiento el usuario	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
102	28	126363	5	usuario_alta	24	0						0	50	0	40	30	f	f	f	0	f	t		f	Usuario hizo el alta 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_seguimiento	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
103	7	126274	5	descripcion	30	0						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
96	20	126222	4	Campo	1	0	campos	attname	attnum	tabla,nspname		2	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
95	19	126000	4	Apellido Materno	30	30						0	40	0	40	30	f	f	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
94	18	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
97	18	126000	5	Puesto	20	50						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
99	15	126000	5	Puesto	20	50						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
105	3	126048	5	Usuario alta	30	0						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
106	5	126104	5	apemat	30	0						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
107	27	126321	5	fecha_alta	18	0						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
89	12	126283	4	Columnas:	4	-1						0	40	0	40	30	f	f	f	0	f	f		f	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
78	13	126401	4	Esquema	1	30	pg_namespace	nspname	nspname			0	0	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	tablas	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-12	\N	\N
110	26	126296	6	usuario_alta	24	0						0	60	0	40	30	f	f	f	0	f	t		f	Usuario hizo el alta 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N	\N	\N
111	5	126104	6	puesto	30	0						0	60	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N	\N	\N
112	27	126321	6	usuario_alta	24	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N	\N	\N
114	3	126048	6	Usuario modifico	30	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N	\N	\N
115	7	126274	6	fecha_alta	18	0						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	\N	\N	\N
121	7	126274	7	usuario_alta	24	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
126	16	2842	7	canlogin	0	0						0	0	0	40	30	f	f	f	0	f	t	0	f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	pg_authid	pg_catalog	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	t	0	\N	\N	\N
127	11	126000	7	Mail	20	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
119	18	126000	6	Depto	20	50						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
108	20	126222	5	Descripcion	30	0						0	140	0	40	30	t	f	f	0	f	f		f	Descripcion del campo en la vista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
120	20	126222	6	Tamaño	30	2						0	150	0	40	30	f	f	f	0	f	f		f	size en el html, para el caso de select la cantidad de renglones	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
122	27	126321	7	fecha_modifico	18	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
123	2	126000	7	Correo Electronico	30	0						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
130	4	126000	7	Correo	20	50						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
133	5	126104	7	depto	30	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	70	\N	\N	\N
135	3	126048	7	Grupo:	0	0	pg_group	groname	groname			0	15	0	40	30	t	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios_pg_group	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	15	\N	\N	\N
116	12	126283	6	usuario_alta	24	24						0	60	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
658	66	147506	18	Colonia	8	-1					\N	0	180	\N	40	30	f	f	f	0	f	f	\N	f	Colonia	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
136	26	126296	7	Es movil:	0	0						0	180	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	\N	\N	\N
138	27	126321	8	usuario_modifico	24	0						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_movtos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N	\N	\N
143	21	126331	8	Grupo	30	30						0	30	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_group	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	30	\N	\N	\N
144	5	126104	8	correoe	30	0						0	80	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N	\N	\N
145	7	126274	8	fecha_modifico	18	0						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	\N	\N	\N
150	26	126296	9	IP:	0	0						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N	\N	\N
132	20	126222	7	Longitud	30	4						0	160	0	40	30	f	f	f	0	f	f		f	Maxima longitud permitida en el html	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
142	14	126182	8	PHP	20	30						0	40	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
137	20	126222	8	Fuente	1	0	tablas	relname	relname	fuente_nspname		1	170	0	40	30	f	f	f	0	f	f		f	Para el campo select se indica la tabla que se va utilizar para seleccionar los valores	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	360	col-md-6	\N	\N
146	26	126296	8	Browser:	0	0						0	160	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	\N	\N	\N
151	11	126000	9	Fecha alta	20	14						0	200	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	\N	\N	\N
152	5	126104	9	direccion_ip	30	0						0	90	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	90	\N	\N	\N
157	7	126274	9	usuario_modifico	24	0						0	90	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	90	\N	\N	\N
160	26	126296	10	Mensaje:	1	1	menus_mensajes	mensaje	idmensaje			0	50	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_log	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	50	\N	\N	\N
161	11	126000	10	Fecha modifico	20	14						0	220	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	\N	\N	\N
166	5	126104	10	fecha_alta	18	0						0	100	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	\N	\N	\N
172	5	126104	11	fecha_modifico	18	0						0	110	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	110	\N	\N	\N
173	11	126000	11	Usuario alta	20	20						0	210	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	210	\N	\N	\N
659	66	147506	19	Alcaldia	8	-1					\N	0	190	\N	40	30	f	f	f	0	f	f	\N	f	Alcaldia	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
154	18	126000	9	Fecha alta	20	14						0	90	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
162	18	126000	10	Fecha modifico	20	14						0	100	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
158	20	126222	9	Descripcion	1	0	campos	attname	attname	fuente_nspname,fuente		2	180	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo en que va mostrar en la seleccion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	380	col-md-6	\N	\N
163	20	126222	10	Liga	1	0	campos	attname	attname	fuente_nspname,fuente		2	190	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo del cual vale la descripcion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	380	col-md-6	\N	\N
181	11	126000	12	Usuario modifico	20	20						0	230	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	230	\N	\N	\N
183	5	126104	12	idpregunta	4	0						0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	\N	\N	\N
184	11	126000	13	Pregunta	1	1	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	130	\N	\N	\N
186	4	126000	13	Pregunta	3	2	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N	\N	\N
190	2	126000	13	idpregunta	4	0	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N	\N	\N
192	5	126104	13	respuesta	30	0						0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	130	\N	\N	\N
194	4	126000	14	Respuesta	20	50						0	140	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	\N	\N	\N
174	20	126222	11	Filtros	30	0						0	200	0	40	30	f	f	f	0	f	f		f	se indica el nombre del campo del cual tiene un filtro, si hay varios separados por, se liga campos de la fuente contra campos de la tabla del menu, si el filtro compara que no son iguales esto se incluye con un;	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	400	col-md-6	\N	\N
176	20	126222	12	Condicion WHERE	30	0						0	202	0	40	30	f	f	f	0	f	f		f	Filtro a aplicar en la fuente si queremos que tome valores de la pantalla al nombre hay que anteponer wl_	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	400	col-md-6	\N	\N
175	18	126000	11	Usuario alta	20	20						0	110	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
196	5	126104	14	estatus	4	0						0	140	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	\N	\N	\N
200	11	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	\N	\N	\N
202	11	126000	15	Estatus	1	5	estados_usuarios	descripcion	estado			0	150	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	150	\N	\N	\N
203	5	126104	15	telefono	30	0						0	150	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N	\N	\N
206	15	126000	15	Estatus	10	5						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	150	\N	\N	\N
210	11	126000	16	Telefono	20	30						0	75	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	75	\N	\N	\N
211	5	126104	16	cve_movto	5	0						0	160	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	\N	\N	\N
198	18	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
207	18	126000	15	Estatus	10	5						0	150	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
199	20	126222	14	Orden	30	0						0	135	0	40	30	f	f	f	0	f	f		f	Campo por el cual se va a ordenar la información	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
661	66	147506	21	Fecha en que ocurrieron los hechos	18	0					\N	0	210	\N	40	30	f	f	f	0	f	t	\N	f	Fecha en que ocurrieron los hechos	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
662	66	147506	22	Fecha en que ocurrieron los hechos	18	0					\N	0	220	\N	40	30	f	f	f	0	f	t	\N	f	Fecha en que ocurrieron los hechos	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
187	1	126341	13	Esquema	0	0	pg_namespace	nspname	nspname			0	5	0	40	30	t	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
212	14	126182	16	Tabla	1	30	tablas	relname	relname	nspname		2	55	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
660	66	147506	20	Fotografía	8	-1					\N	0	200	\N	40	30	f	f	f	0	f	f	\N	f	Fotografa	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	t	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
663	66	147506	23	Calle	30	34					\N	0	230	\N	40	30	f	f	f	0	f	f	\N	f	Calle	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
208	20	126222	15	Subvista	30	0						0	300	0	40	30	f	f	f	0	f	f		f	Si el campos tiene una subvista, habre este numbero de subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
209	20	126222	16	Ancho Subvista	30	0						0	320	0	40	30	f	f	f	0	f	f		f	Ancho de la subvista 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
215	5	126104	17	id_personas	8	0						0	170	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	his_cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	170	\N	\N	\N
228	4	126000	21	Password	20	30						0	240	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	\N	\N	\N
231	11	126000	21	pwd	20	20						0	240	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	240	\N	\N	\N
664	66	147506	24	No. interior	19	19					\N	0	240	\N	40	30	f	f	f	0	f	f	\N	f	No. interior	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
230	19	126000	21	Password	30	30						0	240	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
260	20	126222	33	Esquema	1	0	pg_namespace	nspname	nspname			0	123	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
258	20	126222	32	Tabla	1	30	tablas	relname	relname	nspname		2	125	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
217	20	126222	17	Alto Subvista	30	0						0	325	0	40	30	f	f	f	0	f	f		f	Alto de la subvista 	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
238	11	126000	23	Tipo menu	20	5						0	145	0	0	0	f	f	f	0	f	f		f	0=normal 1=vertical 2=horizontal	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	145	\N	\N	\N
252	19	126000	29	Numero de telefono:	30	50						0	70	0	40	30	t	f	f	2	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
243	11	126000	24	Menu default	1	5	menus	descripcion	idmenu			0	155	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	155	\N	\N	\N
263	20	126222	35	Validacion	30	30						0	1200	0	40	30	f	f	f	0	f	f		f	Indica la validacion especial que se incorpora para este campo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
248	20	126222	26	Tip de ayuda	30	255						0	1200	0	40	30	f	f	f	0	f	f		f	Ayuda que se muestra cuando es mouse esta en el campo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
665	66	147506	25	No. exterior	19	19					\N	0	250	\N	40	30	f	f	f	0	f	f	\N	f	No. exterior	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
676	66	147506	36	Estatus de la boleta	8	-1					\N	0	360	\N	40	30	f	f	f	0	f	f	\N	f	Estatus de la boleta	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	380	col-md-6	\N	\N
242	20	126222	24	Valor de Default	30	100						0	400	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
240	20	126222	23	Solo lectura?	30	0						0	900	0	40	30	f	f	f	0	f	f		f	Este dato no se puede modificar	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
220	14	126182	18	Filtro	20	255						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
234	14	126182	22	Ancho de ventana	20	10						0	120	0	40	30	f	f	f	0	f	f		f	Ancho en abrir la subvista esta en pixeles	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
246	20	126222	25	Iindex?	30	0						0	1100	0	40	30	f	f	f	0	f	f		f	Define este como index ya que existe el caso de las vistas que no tienen indices	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
262	20	126222	34	Busqueda?	30	0						0	205	0	0	0	f	f	f	0	f	f		f	En un campos con opciones se utilizar para hacer una busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	t		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	440	col-md-6	\N	\N
24	15	126000	1	Usuario	20	15						0	10	0	40	30	f	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
278	20	126222	47	Permitir cambios?	30	0						0	510	0	0	0	f	f	f	0	f	f		f	Con este campo se control que no se puedan cambiar datos en cambios, especificamente sirve para los campos de busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	f	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
28	7	126274	1	idmenus_eventos	8	0						0	10	0	40	30	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_eventos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
265	20	126222	36	Tabla HTML	1	0	menus_htmltable	descripcion	idhtmltable			0	137	0	0	0	f	f	t	0	f	f		f	Grupo de campos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
282	20	126222	51	Actualizacion?	30	1						0	625	0	40	30	f	f	f	0	f	f		f	Permite modificar el contenido del campo select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	500	col-md-6	\N	\N
283	20	126222	52	Menu actualizacion	1	1	menus	descripcion	idmenu			0	630	0	40	30	f	f	f	0	f	f		f	Subvista que se utiliza para modificar la informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	500	col-md-6	\N	\N
612	63	147494	6	Horas de Servicio Comunitatio hasta	30	196612					\N	0	60	\N	40	30	f	f	f	0	\N	f	\N	f	Horas de Servicio Comunitatio hasta	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
613	63	147494	7	Horas de arresto desde	30	196612					\N	0	70	\N	40	30	f	f	f	0	\N	f	\N	f	Horas de arresto desde	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
614	63	147494	8	Horas de arresto hasta	30	196612					\N	0	80	\N	40	30	f	f	f	0	\N	f	\N	f	Horas de arresto hasta	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
284	20	126222	53	Dato escondido?	1	1						0	1265	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	340	col-md-6	\N	\N
281	20	126222	50	Menu informacion	1	1	menus	descripcion	idmenu			0	620	0	40	30	f	f	f	0	f	f		f	Indica que subvista se utiliza para mostrar la informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	480	col-md-6	\N	\N
2	23	126000	0	Password	0	0						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
4	6	126000	0	Usuario	0	0						0	0	0	0	0	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	0	\N	\N	\N
5	24	126000	0	PasswordNuevo	30	30						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1		forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	\N	\N	\N
3	9	126000	0	Password	0	0						0	20	0	0	0	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	1	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
633	65	147479	5	Descripción	30	260					\N	0	50	\N	40	30	t	f	f	0	\N	f	\N	f	Descripción	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
21	14	126182	1	Idmenu	20	5						0	1000	0	800	600	f	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	t	240	col-md-6	\N	\N
634	65	147479	6	Conciliación	30	54					\N	0	60	\N	40	30	f	f	f	0	\N	f	\N	f	Conciliación	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
635	65	147479	7	Aplicar si	30	104					\N	0	70	\N	40	30	f	f	f	0	\N	f	\N	f	Aplicar si	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
182	18	126000	12	Usuario modifico	20	20						0	120	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
188	18	126000	13	Pegunta	1	0	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
125	18	126000	7	Mail	20	50						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
218	20	126222	18	Obligatorio?	30	0						0	400	0	40	30	f	f	f	0	f	f		f	El campo es obligatorio	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
223	20	126222	19	Busqueda?	30	0						0	500	0	40	30	f	f	f	0	f	f		f	El campos se puede utilizar en consulta de informacion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
227	20	126222	21	Case	1	0	tcases	descripcion	tcase			0	700	0	40	30	f	f	f	0	f	f		f	Los datos se convierte a mayusculas o minusculas	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
235	20	126222	22	Valida duplicidad?	30	0						0	800	0	40	30	f	f	f	0	f	f		f	Maxima longitud permitida en el html	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
636	65	147479	8	Tipo	7	7					\N	0	80	\N	40	30	t	f	f	0	\N	f	\N	f	Tipo	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
266	14	126182	36	Icono	0	0						0	1300	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
287	31	126401	4	Tabla	0	0	tablas	relname	relname	nspname		2	11	0	40	30	f	f	f	0	f	f		f		2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	0	menus_excels	forapi	f		0	forapi	0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
288	31	126401	3	Esquema	1	30	pg_namespace	nspname	nspname			0	0	0	40	30	t	f	f	0	f	f		f		2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	0	menus_excels	forapi	f		0	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
286	20	126222	55	Clase	30	100						0	410	0	0	0	f	f	f	0	f	f		f		2019-10-19 18:37:08-06	inicio	2019-10-19 18:37:08-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	65	col-md-6	\N	\N
255	20	126222	31	Password?	30	4						0	800	0	0	0	f	f	f	0	f	f		f	1=es pwd 2=subir un archivo(pendiente)	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
271	20	126222	40	SubeArchivo	30	30						0	1210	0	40	30	f	f	f	0	f	f		f	Indica si el campo sirver para subir un archivo	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
276	20	126222	45	Imprime	30	30						0	1212	0	40	30	f	f	f	0	f	f		f	Indica si el campo se imprime	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
277	20	126222	46	Totales	30	30						0	1220	0	40	30	f	f	f	0	f	f		f	Indica si se imprimen totales de un columna	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	300	col-md-6	\N	\N
272	20	126222	41	Formato td	30	1						0	1230	0	40	30	f	f	f	0	f	f		f	0=normal,1=etiqueta y texto junto, 2=Etiqueta y texto junto todo el renglón	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	300	col-md-6	\N	\N
274	20	126222	43	No. de filas	30	3						0	1240	0	40	30	f	f	f	0	f	f		f	Registros para el campos textarea	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	320	col-md-6	\N	\N
273	20	126222	42	No.de columnas	30	3						0	1250	0	40	30	f	f	f	0	f	f		f	Columnas para el campos textarea	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	320	col-md-6	\N	\N
279	20	126222	48	Enlace?	30	30						0	1260	0	40	30	f	f	f	0	f	f		f	Indica si el campo es un link	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	340	col-md-6	\N	\N
268	20	126222	37	Esquema	1	30	pg_namespace	nspname	nspname			0	165	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	pg_catalog	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	360	col-md-6	\N	\N
185	20	126222	13	Evento	30	0						0	203	0	40	30	f	f	f	0	f	f		f	En que evento se cargan los campos select 0=cuando la forma se carga,1=cuando el campo padre cambia,2=cuando el campo recibe el focus,3=cuando el campo recibe el focus solo la primera vez	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	420	col-md-6	\N	\N
275	20	126222	44	Autocompletar	30	1						0	204	0	40	30	f	f	f	0	f	f		f	0=no, 1=si	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	420	col-md-6	\N	\N
270	20	126222	39	Menu busqueda	1	0	menus	descripcion	idmenu			0	207	0	0	0	f	f	f	0	f	f		f	No. de menu para buscar datos	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	440	col-md-6	\N	\N
225	20	126222	20	Alta automatica?	30	0						0	600	0	40	30	f	f	f	0	f	f		f	Para los campos select se pueden dar de alta una descripcion	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	460	col-md-6	\N	\N
269	20	126222	38	Menu alta en automatico	1	1	menus	descripcion	idmenu			0	610	0	40	30	f	f	f	0	f	f		f	Indica que subvista se utiliza para dar de alta un registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	460	col-md-6	\N	\N
280	20	126222	49	Informacion?	30	1						0	615	0	40	30	f	f	f	0	f	f		f	Muestra informacion relevante del contenido del campo select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_campos	forapi	f		1		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	480	col-md-6	\N	\N
39	16	2842	1	Grupo	20	30						0	0	0	0	0	t	t	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	pg_authid	pg_catalog	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-12	\N	\N
600	16	2842	2	Superusuario	\N	\N					\N	0	900	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:33:08-06	jc9	2019-10-30 16:33:08-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6261		\N	\N
380	46	134741	1	idscript	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id del script	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	20	col-md-4	\N	\N
383	46	134741	4	fecha_alta	18	0					\N	0	40	\N	40	30	f	f	f	0	\N	t	\N	f	Fecha en que hizo el movimiento el usuario	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4	\N	\N
384	46	134741	5	usuario_alta	24	24					\N	0	50	\N	40	30	f	f	f	0	\N	t	\N	f	Usuario hizo el alta 	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4	\N	\N
385	46	134741	6	fecha_modifico	18	0					\N	0	60	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	40	col-md-4	\N	\N
386	46	134741	7	usuario_modifico	24	24					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	60	col-md-4	\N	\N
381	46	134741	2	descripcion	30	104					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f		2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-12	\N	\N
382	46	134741	3	sql	-1	-1					\N	0	30	\N	40	30	f	f	f	0	f	f	\N	f	instruccion	2019-10-28 18:51:03-06	jc9	2019-10-28 18:51:03-06	jc9	0	menus_scripts	forapi	f	\N	0		0	0	f	\N	80	10	0	t	f	t	f	f	0	f	0	f	40	col-md-12	\N	\N
601	16	2842	3	Heredable	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:36:28-06	jc9	2019-10-30 16:36:28-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6281		\N	\N
602	16	2842	4	Crea un rol	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:38:35-06	jc9	2019-10-30 16:38:35-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6301		\N	\N
603	16	2842	5	Puede crear una BD	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:39:04-06	jc9	2019-10-30 16:39:04-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6321		\N	\N
604	16	2842	6	Actualiza	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:42:28-06	jc9	2019-10-30 16:42:28-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6341		\N	\N
590	62	134448	1	Numero de identificacion de la tabla	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	Numero de identificacion de la tabla	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6061		\N	\N
594	62	134448	5	fecha_alta	18	-1					\N	0	50	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6141		\N	\N
595	62	134448	6	usuario_alta	24	24					\N	0	60	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6161		\N	\N
596	62	134448	7	fecha_modifico	18	-1					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6181		\N	\N
597	62	134448	8	usuario_modifico	24	24					\N	0	80	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6201		\N	\N
46	12	126283	2	Descripción:	30	259						0	20	0	40	30	f	f	f	1	f	f		f	Caption que va a tener la tabla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
165	12	126283	10	Orden del grupo:	3	3						0	45	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
104	12	126283	5	fecha_alta	18	-1						0	50	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
129	12	126283	7	fecha_modifico	18	-1						0	70	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
147	12	126283	8	usuario_modifico	24	24						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_htmltable	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
591	62	134448	2	Caption que va a tener la tabla	30	259					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f	Caption que va a tener la tabla	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
592	62	134448	3	esdesistema	1	-1					\N	0	30	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
618	63	147494	12	usuario_modifico	24	24					\N	0	120	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6621		\N	\N
593	62	134448	4	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	4	-1					\N	0	40	\N	40	30	f	f	f	0	\N	f	\N	f	Numero de columnas en la tabla si es cero pone las columnas de la tabla maestra	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
598	62	134448	9	Id del menu a la que pertenece el grupo de campos	8	-1					\N	0	90	\N	40	30	f	f	f	0	\N	f	\N	f	Id del menu a la que pertenece el grupo de campos	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
599	62	134448	10	orden del grupo de campos	8	-1					\N	0	100	\N	40	30	f	f	f	0	\N	f	\N	f	orden del grupo de campos	2019-10-29 14:01:00-06	jc9	2019-10-29 14:01:00-06	jc9	0	menus_htmltable	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
605	16	2842	8	Puede Replicar	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:45:14-06	jc9	2019-10-30 16:45:14-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6361		\N	\N
606	16	2842	9	Limite de conexión	\N	\N					\N	0	\N	\N	40	30	\N	f	f	0	\N	f	0	f	\N	2019-10-30 16:47:57-06	jc9	2019-10-30 16:47:57-06	jc9	0	pg_authid	pg_catalog	f	\N	0	0	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6381		\N	\N
607	63	147494	1	id de la sancion	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id de la sancion	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6401		\N	\N
253	19	126000	30	Foto:	0	0						0	80	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	t	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
615	63	147494	9	fecha_alta	18	0					\N	0	90	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6561		\N	\N
616	63	147494	10	usuario_alta	24	24					\N	0	100	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6581		\N	\N
617	63	147494	11	fecha_modifico	18	0					\N	0	110	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6601		\N	\N
55	17	126000	2	Nombre	20	30						0	20	0	40	30	t	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
197	17	126000	14	Respuesta	20	100						0	140	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
237	17	126000	23	Tipo menu	20	5						0	145	0	0	0	f	f	f	0	f	f		f	0=normal 1=vertical 2=horizontal	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
204	17	126000	15	Estatus	1	5	estados_usuarios	descripcion	estado			0	150	0	40	30	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
169	17	126000	11	Usuario alta	20	20						0	210	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
168	17	126000	10	Fecha modifico	20	14						0	220	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
619	64	147467	1	id del juzgado	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id del juzgado	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6641		\N	\N
625	64	147467	7	fecha_alta	18	0					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6761		\N	\N
626	64	147467	8	usuario_alta	24	24					\N	0	80	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6781		\N	\N
627	64	147467	9	fecha_modifico	18	0					\N	0	90	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6801		\N	\N
628	64	147467	10	usuario_modifico	24	24					\N	0	100	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6821		\N	\N
620	64	147467	2	Alcaldia	30	104					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f	Alcaldia	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6 row	\N	\N
621	64	147467	3	Juzgado	30	104					\N	0	30	\N	40	30	f	f	f	0	\N	f	\N	f	Juzgado	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6 row	\N	\N
622	64	147467	4	Direccion	30	104					\N	0	40	\N	40	30	f	f	f	0	\N	f	\N	f	Direccion	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6 row	\N	\N
623	64	147467	5	Turno	30	34					\N	0	50	\N	40	30	f	f	f	0	\N	f	\N	f	Turno	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6 row	\N	\N
624	64	147467	6	horario	30	34					\N	0	60	\N	40	30	f	f	f	0	\N	f	\N	f	horario	2019-10-31 17:25:01-06	jc104	2019-10-31 17:25:01-06	jc104	0	juzgados	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6 row	\N	\N
629	65	147479	1	id de la infraccion	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id de la infraccion	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	6841		\N	\N
608	63	147494	2	Tipo 	6	6					\N	0	20	\N	40	30	t	f	f	0	\N	f	\N	f	Tipo 	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
609	63	147494	3	Unidad de cuenta desde	30	196612					\N	0	30	\N	40	30	f	f	f	0	\N	f	\N	f	Unidad de cuenta desde	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
610	63	147494	4	Unidad de cuenta hasta	30	196612					\N	0	40	\N	40	30	f	f	f	0	\N	f	\N	f	Unidad de cuenta hasta	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
611	63	147494	5	Horas de Servicio Comunitatio desde	30	196612					\N	0	50	\N	40	30	f	f	f	0	\N	f	\N	f	Horas de Servicio Comunitatio desde	2019-10-31 17:24:57-06	jc104	2019-10-31 17:24:57-06	jc104	0	sanciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
70	1	126341	3	tselect	1	1						0	13	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
81	1	126341	4	tinsert	1	1						0	14	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
100	1	126341	5	tupdate	1	1						0	15	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
117	1	126341	6	tdelete	1	1						0	16	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
637	65	147479	9	fecha_alta	18	0					\N	0	90	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7001		\N	\N
638	65	147479	10	usuario_alta	24	24					\N	0	100	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7021		\N	\N
639	65	147479	11	fecha_modifico	18	0					\N	0	110	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7041		\N	\N
640	65	147479	12	usuario_modifico	24	24					\N	0	120	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7061		\N	\N
630	65	147479	2	Infracción 	30	104					\N	0	20	\N	40	30	t	f	f	0	\N	f	\N	f	Infracción 	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
631	65	147479	3	Artículo	8	-1					\N	0	30	\N	40	30	t	f	f	0	\N	f	\N	f	Artículo	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
632	65	147479	4	Fracción	14	14					\N	0	40	\N	40	30	t	f	f	0	\N	f	\N	f	Fracción	2019-10-31 17:25:05-06	jc104	2019-10-31 17:25:05-06	jc104	0	infracciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
134	1	126341	7	tall	1	1						0	17	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
178	1	126341	12	tgrant	1	1						0	18	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
140	1	126341	8	fecha_alta	0	0						0	19	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
149	1	126341	9	fecha_modifico	0	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
641	66	147506	1	id de la boleta	8	-1					\N	0	10	\N	40	30	t	f	f	0	\N	t	\N	t	id de la boleta	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7081		\N	\N
642	66	147506	2	boleta_remision	6	6					\N	0	20	\N	40	30	t	f	f	0	\N	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
643	66	147506	3	Policia uno 	8	-1					\N	0	30	\N	40	30	t	f	f	0	f	f	\N	f	Policia uno 	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2026		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
159	1	126341	10	usuario_alta	0	0						0	21	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
644	66	147506	4	Policia dos 	8	-1					\N	0	40	\N	40	30	f	f	f	0	f	f	\N	f	Policia dos 	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2026		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
645	66	147506	5	Numero de patrulla u medio de transporte	30	34					\N	0	50	\N	40	30	t	f	f	0	f	f	\N	f	Numero de patrulla u medio de transporte	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2026		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
171	1	126341	11	usuario_modifico	0	0						0	22	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
27	1	126341	1	idmenu	0	0						0	800	0	40	30	f	f	f	0	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_pg_tables	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
232	30	126370	21	Orden	4	4						0	0	0	0	0	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
30	30	126370	1	idmenus_subvistas	0	0						0	10	0	40	30	t	f	f	0	f	t		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
53	30	126370	2	idmenu	0	0						0	20	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
76	30	126370	3	texto	0	0						0	30	0	40	30	f	f	f	0	f	f		f	Texto para activas la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
83	30	126370	4	imagen	0	0						0	40	0	40	30	f	f	f	0	f	f		f	Imagen que aparece para activar la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
109	30	126370	5	idsubvista	0	0	menus	descripcion	idmenu			0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0	forapi	0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
221	30	126370	19	Clase	0	0						0	58	0	40	30	f	f	f	0	f	f		f	Clase que se va a ejecutar en el servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
118	30	126370	6	funcion	0	0						0	60	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar en el servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
236	30	126370	22	Ventana	1	1						0	65	0	40	30	f	f	f	0	f	f		f	0=showModalDialog,1=showModelessDialog,2=open,3=misma ventana	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
128	30	126370	7	dialogwidth	0	0						0	70	0	40	30	f	f	f	0	f	f		f	El ancho que va a tener la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
139	30	126370	8	dialogheight	0	0						0	80	0	40	30	f	f	f	0	f	f		f	La altura que va a tener la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
164	30	126370	10	donde	0	0						0	100	0	40	30	f	f	f	0	f	f		f	En donde se va a ejecutar el evento antes de abrir la subvista 0=cliente 1=servidor	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
170	30	126370	11	eventos_antes	0	0						0	110	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar antes de abrir la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
180	30	126370	12	eventos_despues	0	0						0	120	0	40	30	f	f	f	0	f	f		f	Funcion que se va a ejecutar despues de abrir la subvista	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
189	30	126370	13	campo_filtro	0	0						0	130	0	40	30	f	f	f	0	f	f		f	Nombre del campo de la subvista el cual se va hacer el filtro, mas de uno es separado por ;	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
195	30	126370	14	valor_padre	0	0						0	140	0	40	30	f	f	f	0	f	f		f	Valor del campo padre, este lo toma de los campos de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
224	30	126370	20	Posicion	1	1						0	145	0	0	0	f	f	f	0	f	f		f	posicion dondes se ubica el boton o subvistas 0=registro, 1=cabecera	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
205	30	126370	15	fecha_alta	0	0						0	150	0	40	30	f	f	f	0	f	t		f	Fecha en que el usuario dio de alta el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
156	30	126370	9	Esboton	1	1						0	150	0	40	30	f	f	f	0	f	f		f	0=link,1=boton,2=menu select	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
214	30	126370	16	usuario_alta	0	0						0	160	0	40	30	f	f	f	0	f	t		f	Usuario que dio de alta el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
216	30	126370	17	fecha_modifico	0	0						0	170	0	40	30	f	f	f	0	f	t		f	Fecha en que el usuario modifico el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
646	66	147506	6	id_areaadcripcion	8	-1					\N	0	60	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2026		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
647	66	147506	7	Nombre(s)	30	34					\N	0	70	\N	40	30	t	f	f	0	f	f	\N	f	Nombre(s)	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
648	66	147506	8	Primer apellido	30	34					\N	0	80	\N	40	30	f	f	f	0	f	f	\N	f	Primer apellido	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
649	66	147506	9	Segundo apellido	30	34					\N	0	90	\N	40	30	f	f	f	0	f	f	\N	f	Segundo apellido	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
650	66	147506	10	Sexo	5	5					\N	0	100	\N	40	30	f	f	f	0	f	f	\N	f	Sexo	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
651	66	147506	11	Curp	22	22					\N	0	110	\N	40	30	f	f	f	0	f	f	\N	f	Curp	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
652	66	147506	12	Lugar de nacimiento	8	-1					\N	0	120	\N	40	30	f	f	f	0	f	f	\N	f	Lugar de nacimiento	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
653	66	147506	13	Fecha de nacimiento	18	0					\N	0	130	\N	40	30	f	f	f	0	f	t	\N	f	Fecha de nacimiento	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
678	66	147506	38	fecha_alta	18	0					\N	0	380	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7821		\N	\N
679	66	147506	39	usuario_alta	24	24					\N	0	390	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7841		\N	\N
680	66	147506	40	fecha_modifico	18	0					\N	0	400	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7861		\N	\N
681	66	147506	41	usuario_modifico	24	24					\N	0	410	\N	40	30	f	f	f	0	\N	t	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	7881		\N	\N
219	30	126370	18	usuario_modifico	0	0						0	180	0	40	30	f	f	f	0	f	t		f	Usuario que modifico el registro	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus_subvistas	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
657	66	147506	17	Código postal	9	9					\N	0	170	\N	40	30	f	f	f	0	f	f	\N	f	Código postal	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2027		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
688	31	126401	2	Descripción de la vista	\N	\N					\N	0	\N	\N	40	30	t	f	f	0	f	f	\N	f	\N	2019-11-18 09:58:13-07	jc104	2019-11-18 09:58:13-07	jc104	0	menus_excels	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	5	col-md-12	\N	\N
29	17	126000	1	Usuario	20	15						0	10	0	40	30	t	t	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	f	f	f	0	f	0	f	20	col-md-6	\N	\N
66	17	126000	3	Paterno	20	30						0	30	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
82	17	126000	4	Materno	20	30						0	40	0	40	30	f	t	f	1	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
124	17	126000	7	Mail	20	0						0	70	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
213	17	126000	16	Telefono	20	30						0	75	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
191	17	126000	13	Pregunta	1	1	cat_preguntas	descripcion	idpregunta			0	130	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
241	17	126000	24	Menu default	1	5	menus	descripcion	idmenu			0	155	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
153	17	126000	9	Fecha alta	20	14						0	200	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
179	17	126000	12	Usuario modifico	20	20						0	230	0	40	30	f	f	f	0	f	t		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
67	14	126182	3	Objeto	20	30						0	30	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	20	col-md-6	\N	\N
148	14	126182	9	Modo consulta	20	5						0	50	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
249	14	126182	27	Esquema	1	0	pg_namespace	nspname	nspname			0	52	0	0	0	f	t	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	pg_catalog	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	60	col-md-6	\N	\N
201	14	126182	15	Columnas	20	5						0	57	0	40	30	t	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
177	14	126182	12	Movtos	20	30						0	60	0	40	30	t	f	f	0	f	f		f	i=insert,d=delete,u=update,l=limpiar,cc=copiar,a=autodiseño,I=AltaAutomatica,s=Select,S=select sin opcion de seleccionar registro,f=Genera un archivo txt de la consulta,B=Busqueda	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	80	col-md-6	\N	\N
689	31	126401	5	Archivo	\N	\N					\N	0	\N	\N	40	30	t	f	f	0	f	t	\N	f	\N	2019-11-18 09:58:43-07	jc104	2019-11-18 09:58:43-07	jc104	0	menus_excels	forapi	f	\N	0		0	0	t	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	8041	col-md-6	\N	\N
690	31	126401	1	id	\N	\N					\N	0	800	\N	40	30	\N	f	f	0	\N	f	\N	t	\N	2019-11-18 10:15:33-07	jc104	2019-11-18 10:15:33-07	jc104	0	menus_excels	forapi	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	8061		\N	\N
264	14	126182	35	No Confirma movtos.	10	10						0	63	0	40	30	f	f	f	0	f	f		f	No confirma los movimientos por ejemplo si se pone una i no confirma las altas	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
167	14	126182	10	Menu Padre	1	20	menus	descripcion	idmenu			0	65	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	100	col-md-6	\N	\N
222	14	126182	19	Limite	20	10						0	80	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	120	col-md-6	\N	\N
229	14	126182	21	Campos de menu	1	255	menus	descripcion	idmenu			0	110	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0	forapi	0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	140	col-md-6	\N	\N
239	14	126182	23	Altura de ventana	20	10						0	140	0	40	30	f	f	f	0	f	f		f	Altura en que va abrir la subvista esta en pixeles	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
244	14	126182	24	Pone Scroll	20	1						0	150	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	160	col-md-6	\N	\N
245	14	126182	25	Altura de Scroll	20	10						0	160	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
256	14	126182	31	Ancho de tabla	20	10						0	180	0	40	30	f	f	f	0	f	f		f	Ancho en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	180	col-md-6	\N	\N
257	14	126182	32	Alto de tabla	20	10						0	190	0	40	30	f	f	f	0	f	f		f	Alto en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
259	14	126182	33	Alineacion de tabla	20	10						0	200	0	40	30	f	f	f	2	f	f		f	Alto en porcentaje de la tabla de captura	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	200	col-md-6	\N	\N
226	14	126182	20	Orden	20	255						0	990	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
247	14	126182	26	Muestra Registros al Inicio	0	0						0	995	0	0	0	f	f	f	0	f	f		f	Indica si muestra los registro al mostrar la pantalla	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	220	col-md-6	\N	\N
250	14	126182	28	Hoja de estilo	20	50						0	998	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
254	14	126182	30	LimpiarAlta	20	1						0	1000	0	40	30	f	f	f	0	f	f		f	Limpia la pantalla despues de dar de alta	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	240	col-md-6	\N	\N
251	14	126182	29	Imprime	20	1						0	1000	0	40	30	f	f	f	0	f	f		f	0=todo,1=tabla de captura,2=tabla de renglones	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
261	14	126182	34	Manual	20	500						0	1100	0	40	30	f	t	f	0	f	f		f	Manual del sistema	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	80	3	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
267	14	126182	37	Ayuda	0	0						0	1300	0	40	30	f	f	f	0	f	f		f		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	menus	forapi	f		0		0	0	f	1	0	0	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
666	66	147506	26	Código postal	9	9					\N	0	260	\N	40	30	f	f	f	0	f	f	\N	f	Código postal	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	260	col-md-6	\N	\N
667	66	147506	27	Colonia	8	-1					\N	0	270	\N	40	30	f	f	f	0	f	f	\N	f	Colonia	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
668	66	147506	28	Alcaldia	8	-1					\N	0	280	\N	40	30	f	f	f	0	f	f	\N	f	Alcaldia	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	280	col-md-6	\N	\N
669	66	147506	29	Datos de la probable infracción	-1	-1					\N	0	290	\N	40	30	f	f	f	0	f	f	\N	f	Datos de la probable infracción	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	300	col-md-6	\N	\N
670	66	147506	30	Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracción(es)	-1	-1					\N	0	300	\N	40	30	f	f	f	0	f	f	\N	f	Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracción(es)	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	300	col-md-6	\N	\N
671	66	147506	31	Artículos	8	-1					\N	0	310	\N	40	30	f	f	f	0	f	f	\N	f	Artículos	2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2028		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	320	col-md-6	\N	\N
672	66	147506	32	sancion_uc	8	-1					\N	0	320	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	340	col-md-6	\N	\N
673	66	147506	33	sancion_servicio	8	-1					\N	0	330	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	340	col-md-6	\N	\N
674	66	147506	34	sancion_arresto	8	-1					\N	0	340	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	360	col-md-6	\N	\N
675	66	147506	35	sancion_observacion	-1	-1					\N	0	350	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	360	col-md-6	\N	\N
677	66	147506	37	expediente	30	34					\N	0	370	\N	40	30	f	f	f	0	f	f	\N	f		2019-10-31 17:25:09-06	jc104	2019-10-31 17:25:09-06	jc104	0	boletas	jc	f	\N	2029		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	380	col-md-6	\N	\N
35	4	126000	1	Usuario	10	40						0	10	0	40	30	t	f	f	2	f	f		t		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio	0	cat_usuarios	forapi	f		0		0	0	f	0	0	0	0	t	f	t	f	f	0	f	0	f	10	\N	\N	\N
1723	154	152747	1	Tipo	8	-1	opciones_b	descripcion	id		\N	0	10	\N	40	30	t	f	t	0	\N	f	\N	f	Tipo	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0	jc	0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	10	col-md-6	text-danger	\N
1724	154	152747	2	Unidad de cuenta desde	30	5					\N	0	20	\N	40	30	f	f	f	0	\N	f	\N	f	Unidad de cuenta desde	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	text-primary	border-dark
1730	154	152747	8	id	8	-1					\N	0	80	\N	40	30	t	f	f	0	\N	t	\N	t		2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	28861		\N	\N
1731	154	152747	9	fecha_alta	18	0					\N	0	90	\N	40	30	f	f	f	0	\N	t	\N	f		2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	28881		\N	\N
1732	154	152747	10	usuario_alta	8	-1					\N	0	100	\N	40	30	f	f	f	0	\N	t	\N	f		2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	28901		\N	\N
1733	154	152747	11	fecha_modifico	18	0					\N	0	110	\N	40	30	f	f	f	0	\N	t	\N	f		2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	28921		\N	\N
1734	154	152747	12	usuario_modifico	8	-1					\N	0	120	\N	40	30	f	f	f	0	\N	t	\N	f		2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	t	28941		\N	\N
1725	154	152747	3	Unidad de cuenta hasta	30	10					\N	0	30	\N	40	30	f	f	f	0	\N	f	\N	f	Unidad de cuenta hasta	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	20	col-md-6	text-warning	\N
1728	154	152747	6	Horas de arresto desde	8	-1					\N	0	60	\N	40	30	f	f	f	0	\N	t	\N	f	Horas de arresto desde	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	2111		0	0	t	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
1729	154	152747	7	Horas de arresto hasta	30	259					\N	0	70	\N	40	30	f	f	f	0	\N	t	\N	f	Horas de arresto hasta	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	2111		0	0	t	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	40	col-md-6	\N	\N
1726	154	152747	4	Horas de Servicio Comunitatio desde	30	10					\N	0	40	\N	40	30	t	f	f	0	\N	f	\N	f	Horas de Servicio Comunitatio desde	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	2110		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	30	col-md-6	\N	border-danger
1727	154	152747	5	Horas de Servicio Comunitario hasta	-1	-1					\N	0	50	\N	40	30	t	f	f	0	\N	f	\N	f	Horas de Servicio Comunitario hasta	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	0	opciones	jc	f	\N	0		0	0	f	\N	\N	\N	0	t	f	t	f	f	0	f	0	f	30	col-md-6	\N	\N
\.


--
-- Data for Name: menus_campos_eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_campos_eventos (icv, attnum, idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	21	19	5	0	SoloAlfanumerico	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
2	21	4	5	0	SoloAlfanumerico	2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
\.


--
-- Name: menus_campos_eventos_icv_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_campos_eventos_icv_seq', 2, true);


--
-- Name: menus_campos_fila_seq; Type: SEQUENCE SET; Schema: forapi; Owner: inicio
--

SELECT pg_catalog.setval('menus_campos_fila_seq', 28941, true);


--
-- Name: menus_campos_idcampo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_campos_idcampo_seq', 1734, true);


--
-- Data for Name: menus_eventos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_eventos (idmenus_eventos, idmenu, idevento, donde, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	24	7	1	cambiodepasswordsol	2017-03-30 14:35:05.754513-06	jlv	2017-03-30 14:35:05.754513-06	jlv
2	15	7	1	autoriza_usuario	2018-09-20 18:20:55.889685-06	jlv	2018-09-20 18:20:55.889685-06	jlv
3	25	7	1	cambiodepassword	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
4	19	3	1	validapwdtecleado	2009-02-04 12:58:35.816872-07	grecar	2009-02-04 12:58:35.816872-07	grecar
5	19	4	1	salidacontra	2009-02-04 12:58:35.816872-07	grecar	2009-02-04 12:58:35.816872-07	grecar
6	2	7	1	validarespuestadesbloqueo	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
7	18	7	1	autoriza_usuario	2006-06-29 18:53:01-06	siscor	2006-06-29 18:53:01-06	siscor
8	4	3	1	validapwdtecleado	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
9	6	9	1	validausuarioadesbloquear	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
10	4	4	1	salida	2006-06-29 18:53:02-06	siscor	2006-06-29 18:53:02-06	siscor
\.


--
-- Name: menus_eventos_idmenus_eventos_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_eventos_idmenus_eventos_seq', 10, true);


--
-- Data for Name: menus_excels; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_excels (idexcel, descripcion, nspname, relname, archivo, movimiento, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
14	alta desde un excel solamente Etiquetas 	jc	\N	60.xlsx	0	2019-11-18 17:53:25-07	jc104	2019-11-18 17:53:25-07	jc104
15	excel con etiquets y filas	jc	\N	62.xlsx	0	2019-11-21 14:46:17-07	jc104	2019-11-21 14:46:17-07	jc104
16	Alta desde excel, etiquetas, filas y oligatorios	jc	\N	64.xlsx	0	2019-11-21 16:19:05-07	jc104	2019-11-21 16:19:05-07	jc104
17	Alta desde excel, ejemplo de anexar documentos	jc	\N	65.xlsx	0	2019-11-21 16:39:24-07	jc104	2019-11-21 16:39:24-07	jc104
18	creacion de opciones	jc	\N	68.xlsx	0	2019-11-23 10:09:45-07	jc104	2019-11-23 10:09:45-07	jc104
19	creacion de grupos de campos	jc	\N	77.xlsx	0	2019-11-25 19:44:04-07	jc104	2019-11-25 19:44:04-07	jc104
20	crea vista con tipo de datos	jc	\N	78.xlsx	0	2019-12-01 12:16:17-07	jc104	2019-12-01 12:16:17-07	jc104
21	crea vista incluendo clases a nivel campo	jc	\N	84.xlsx	0	2019-12-01 13:10:44-07	jc104	2019-12-01 13:10:44-07	jc104
\.


--
-- Name: menus_excels_idexcel_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_excels_idexcel_seq', 21, true);


--
-- Data for Name: menus_htmltable; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_htmltable (idhtmltable, descripcion, esdesistema, columnas, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, idmenu, orden) FROM stdin;
1	CAMPOS CON OPCIONES	f	0	2007-06-28 18:15:51-06	jlv	2007-06-28 18:15:51-06	jlv	\N	\N
0	SIN HTMLTABLE	f	0	2007-07-14 14:10:10-06	jlv	2007-07-14 14:10:10-06	jlv	\N	\N
2026	POLICIAS	f	0	2019-10-29 14:03:42-06	jc9	2019-10-29 14:03:42-06	jc9	\N	\N
2027	INFRACTORES	f	0	2019-10-29 21:17:05-06	jc9	2019-10-29 21:17:05-06	jc9	\N	\N
2028	INFRACCIONES	f	0	2019-10-29 21:26:36-06	jc9	2019-10-29 21:26:36-06	jc9	\N	\N
2029	SANCIÓN	f	0	2019-10-29 21:33:26-06	jc9	2019-10-29 21:33:26-06	jc9	\N	\N
2050	AGRUPAUNO	f	0	2019-11-30 11:55:46-07	jc104	2019-11-30 11:55:46-07	jc104	132	\N
2051	AGRUPADOS	f	0	2019-11-30 11:55:46-07	jc104	2019-11-30 11:55:46-07	jc104	132	\N
2053	AGRUPAUNO	f	0	2019-12-01 12:22:35-07	jc104	2019-12-01 12:22:35-07	jc104	133	\N
2054	AGRUPADOS	f	0	2019-12-01 12:22:35-07	jc104	2019-12-01 12:22:35-07	jc104	133	\N
2056	AGRUPAUNO	f	0	2019-12-01 12:23:57-07	jc104	2019-12-01 12:23:57-07	jc104	134	\N
2057	AGRUPADOS	f	0	2019-12-01 12:23:57-07	jc104	2019-12-01 12:23:57-07	jc104	134	\N
2059	AGRUPAUNO	f	0	2019-12-01 12:45:21-07	jc104	2019-12-01 12:45:21-07	jc104	135	\N
2060	AGRUPADOS	f	0	2019-12-01 12:45:21-07	jc104	2019-12-01 12:45:21-07	jc104	135	\N
2062	AGRUPAUNO	f	0	2019-12-01 12:48:05-07	jc104	2019-12-01 12:48:05-07	jc104	136	\N
2063	AGRUPADOS	f	0	2019-12-01 12:48:05-07	jc104	2019-12-01 12:48:05-07	jc104	136	\N
2065	AGRUPAUNO	f	0	2019-12-01 12:49:29-07	jc104	2019-12-01 12:49:29-07	jc104	137	\N
2066	AGRUPADOS	f	0	2019-12-01 12:49:29-07	jc104	2019-12-01 12:49:29-07	jc104	137	\N
2068	AGRUPAUNO	f	0	2019-12-01 12:51:08-07	jc104	2019-12-01 12:51:08-07	jc104	138	\N
2069	AGRUPADOS	f	0	2019-12-01 12:51:08-07	jc104	2019-12-01 12:51:08-07	jc104	138	\N
2071	AGRUPAUNO	f	0	2019-12-01 12:52:01-07	jc104	2019-12-01 12:52:01-07	jc104	139	\N
2072	AGRUPADOS	f	0	2019-12-01 12:52:01-07	jc104	2019-12-01 12:52:01-07	jc104	139	\N
2074	AGRUPAUNO	f	0	2019-12-01 13:21:03-07	jc104	2019-12-01 13:21:03-07	jc104	140	\N
2075	AGRUPADOS	f	0	2019-12-01 13:21:03-07	jc104	2019-12-01 13:21:03-07	jc104	140	\N
2077	AGRUPAUNO	f	0	2019-12-01 13:25:13-07	jc104	2019-12-01 13:25:13-07	jc104	141	\N
2078	AGRUPADOS	f	0	2019-12-01 13:25:13-07	jc104	2019-12-01 13:25:13-07	jc104	141	\N
2080	AGRUPAUNO	f	0	2019-12-01 13:28:46-07	jc104	2019-12-01 13:28:46-07	jc104	142	\N
2081	AGRUPADOS	f	0	2019-12-01 13:28:46-07	jc104	2019-12-01 13:28:46-07	jc104	142	\N
2083	AGRUPAUNO	f	0	2019-12-01 13:30:12-07	jc104	2019-12-01 13:30:12-07	jc104	143	\N
2084	AGRUPADOS	f	0	2019-12-01 13:30:12-07	jc104	2019-12-01 13:30:12-07	jc104	143	\N
2086	AGRUPAUNO	f	0	2019-12-01 13:50:43-07	jc104	2019-12-01 13:50:43-07	jc104	144	\N
2087	AGRUPADOS	f	0	2019-12-01 13:50:43-07	jc104	2019-12-01 13:50:43-07	jc104	144	\N
2089	AGRUPAUNO	f	0	2019-12-01 13:53:40-07	jc104	2019-12-01 13:53:40-07	jc104	145	\N
2090	AGRUPADOS	f	0	2019-12-01 13:53:40-07	jc104	2019-12-01 13:53:40-07	jc104	145	\N
2092	AGRUPAUNO	f	0	2019-12-01 14:04:43-07	jc104	2019-12-01 14:04:43-07	jc104	146	\N
2093	AGRUPADOS	f	0	2019-12-01 14:04:43-07	jc104	2019-12-01 14:04:43-07	jc104	146	\N
2095	AGRUPAUNO	f	0	2019-12-01 14:15:30-07	jc104	2019-12-01 14:15:30-07	jc104	147	\N
2096	AGRUPADOS	f	0	2019-12-01 14:15:30-07	jc104	2019-12-01 14:15:30-07	jc104	147	\N
2098	AGRUPAUNO	f	0	2019-12-05 14:23:53-07	jc104	2019-12-05 14:23:53-07	jc104	148	\N
2099	AGRUPADOS	f	0	2019-12-05 14:23:53-07	jc104	2019-12-05 14:23:53-07	jc104	148	\N
2101	AGRUPAUNO	f	0	2019-12-06 13:55:15-07	jc104	2019-12-06 13:55:15-07	jc104	151	\N
2102	AGRUPADOS	f	0	2019-12-06 13:55:15-07	jc104	2019-12-06 13:55:15-07	jc104	151	\N
2104	AGRUPAUNO	f	0	2019-12-06 14:03:59-07	jc104	2019-12-06 14:03:59-07	jc104	152	\N
2105	AGRUPADOS	f	0	2019-12-06 14:03:59-07	jc104	2019-12-06 14:03:59-07	jc104	152	\N
2107	AGRUPAUNO	f	0	2019-12-06 14:08:35-07	jc104	2019-12-06 14:08:35-07	jc104	153	\N
2108	AGRUPADOS	f	0	2019-12-06 14:08:35-07	jc104	2019-12-06 14:08:35-07	jc104	153	\N
2110	AGRUPAUNO	f	0	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	154	\N
2111	AGRUPADOS	f	0	2019-12-06 16:53:46-07	jc104	2019-12-06 16:53:46-07	jc104	154	\N
\.


--
-- Name: menus_htmltable_idhtmltable_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_htmltable_idhtmltable_seq', 2112, true);


--
-- Name: menus_idmenu_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_idmenu_seq', 154, true);


--
-- Data for Name: menus_log; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_log (idlog, idmenu, movto, sql, fecha_alta, usuario_alta, esmovil, browser, ip, idmensaje) FROM stdin;
\.


--
-- Name: menus_log_idlog_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_log_idlog_seq', 1, false);


--
-- Data for Name: menus_mensajes; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_mensajes (idmensaje, mensaje, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: menus_mensajes_idmensaje_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_mensajes_idmensaje_seq', 1, false);


--
-- Data for Name: menus_movtos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_movtos (idmenu, idmovto, descripcion, imagen, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
24	u	CambiarPassword		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
15	u	Autoriza		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
18	u	Autoriza		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
25	u	CambiarPassword		2019-10-12 14:53:07-06	inicio	2019-10-12 14:53:07-06	inicio
\.


--
-- Data for Name: menus_pg_group; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_pg_group (idmenu, grosysid, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, idmenupadre, groname, orden, espublico) FROM stdin;
11	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
15	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admres	0	\N
18	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
16	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
15	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
21	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
10	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
14	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
16	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
25	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
13	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
8	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
17	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
12	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
4	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
23	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
14	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
24	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
18	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
8	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
17	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N		0	\N
10	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
13	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	admon	0	\N
31	\N	2019-10-20 19:38:33-06	2019-10-20 19:38:33-06	inicio	inicio	\N		0	\N
31	\N	2019-10-20 19:38:33-06	2019-10-20 19:38:33-06	inicio	inicio	\N	admon	0	\N
32	\N	2019-10-27 07:50:24-06	2019-10-27 07:50:24-06	inicio	inicio	\N	admon	0	\N
19	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
2	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
9	\N	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	\N	temporalg	0	\N
8	\N	2019-10-27 15:39:33-06	2019-10-27 15:39:33-06	inicio	inicio	\N	temporalg	0	\N
46	\N	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	\N	admon	0	\N
62	\N	2019-10-29 14:01:00-06	2019-10-29 14:01:00-06	jc9	jc9	\N	admon	0	\N
8	\N	2019-10-30 16:48:47-06	2019-10-30 16:48:47-06	jc9	jc9	\N	juez	0	\N
63	\N	2019-10-31 17:24:57-06	2019-10-31 17:24:57-06	jc104	jc104	\N	admon	0	\N
64	\N	2019-10-31 17:25:01-06	2019-10-31 17:25:01-06	jc104	jc104	\N	admon	0	\N
65	\N	2019-10-31 17:25:05-06	2019-10-31 17:25:05-06	jc104	jc104	\N	admon	0	\N
66	\N	2019-10-31 17:25:09-06	2019-10-31 17:25:09-06	jc104	jc104	\N	admon	0	\N
154	\N	2019-12-06 16:53:46-07	2019-12-06 16:53:46-07	jc104	jc104	\N	admon	0	\N
\.


--
-- Name: menus_pg_group_orden_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_pg_group_orden_seq', 1, false);


--
-- Data for Name: menus_pg_tables; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_pg_tables (idmenu, tablename, tselect, tinsert, tupdate, tdelete, tall, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, tgrant, nspname) FROM stdin;
1	menus_pg_tables	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
2	cat_usuarios	0	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
3	cat_usuarios_pg_group	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
5	his_cat_usuarios	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	menus_eventos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
12	menus_htmltable	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
13	tablas	1	1	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	menus	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
16	pg_authid	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
20	menus_campos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
21	menus_pg_group	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
27	menus_movtos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
28	menus_seguimiento	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
29	menus_tiempos	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
30	menus_subvistas	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
5	his_cat_usuarios_idcambio_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	menus_eventos_idmenus_eventos_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
30	menus_subvistas_idmenus_subvistas_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_log_idlog_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
12	menus_htmltable_idhtmltable_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
28	menus_seguimiento_idseguimietno_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	his_cambios_pwd	1	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	pg_authid	1	1	1	1	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
8	menus_presentacion	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_htmltable_idhtmltable_seq	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	his_cat_usuarios_pg_group	1	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
3	pg_group	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
11	cat_usuarios	1	1	1	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus_htmltable_idhtmltable_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	menus_subvistas	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
8	menus_htmltable	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	his_menus	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	his_cat_usuarios_pg_group_idcambio_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	his_cat_usuarios_pg_group_idcambio_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_pg_group	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	tablas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_mensajes	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_campos_eventos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
26	menus	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
1	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
14	menus_eventos_idmenus_eventos_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
19	cat_usuarios	0	1	0	0	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
1	tablas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
11	pg_authid	0	0	0	0	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
17	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_bitacora	1	1	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	menus_pg_tables	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
4	cat_preguntas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_eventos_icv_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	estados_usuarios	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_preguntas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_movtos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_presentacion	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_seguimiento_idseguimietno_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	cat_usuarios_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_usuarios_pg_group	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
11	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_usuarios	1	0	1	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	his_cat_usuarios_pg_group_idcambio_seq	1	0	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_idmenu_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus_campos_idcampo_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_seguimiento	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
11	pg_shadow	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	pg_catalog
11	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
16	menus_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
19	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
7	eventos	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
4	cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	tcases	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	campos	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	cat_bitacora_idbitacora_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	menus	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
20	menus_htmltable	1	1	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
14	tablas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
19	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	tablas	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	his_menus_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_movtos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	estados_usuarios	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	his_menus_pg_group_seq	1	 	1	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	pg_authid	0	0	0	1	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
8	menus_campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_log	 	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos_idcampo_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	menus_campos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
4	cat_preguntas_seq	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_log_idlog_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	tcases	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
19	his_cat_usuarios_seq	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
14	campos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
20	pg_namespace	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	pg_catalog
14	menus_eventos	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
21	menus_pg_group_orden_seq	1	0	1	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
26	menus_log	1	0	0	0	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	cat_usuarios	1	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
18	cat_preguntas	1	0	0	0	0	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	0	forapi
8	menus_subvistas	1	 	1	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	his_cat_usuarios	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
8	menus_eventos	1	 	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
17	cat_usuarios_pg_group	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
1	his_menus_pg_tables	 	 	 	 	1	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
46	menus_scripts	1	1	1	1	0	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	0	forapi
46	menus_scripts_idscript_seq	1	0	1	0	0	2019-10-28 18:51:03-06	2019-10-28 18:51:03-06	jc9	jc9	0	forapi
63	sanciones	1	1	1	1	0	2019-10-31 17:24:57-06	2019-10-31 17:24:57-06	jc104	jc104	0	jc
64	juzgados	1	1	1	1	0	2019-10-31 17:25:01-06	2019-10-31 17:25:01-06	jc104	jc104	0	jc
65	infracciones	1	1	1	1	0	2019-10-31 17:25:05-06	2019-10-31 17:25:05-06	jc104	jc104	0	jc
19	menus_archivos	1	1	 	 	 	2019-10-12 14:53:07-06	2019-10-12 14:53:07-06	inicio	inicio	 	forapi
66	boletas	1	1	1	1	0	2019-10-31 17:25:09-06	2019-10-31 17:25:09-06	jc104	jc104	0	jc
31	menus_excels	1	1	1	1	0	2019-11-18 09:35:24-07	2019-11-18 09:35:24-07	jc104	jc104	0	forapi
154	opciones	1	1	1	1	0	2019-12-06 16:53:46-07	2019-12-06 16:53:46-07	jc104	jc104	0	jc
154	opciones_id_seq	1	0	1	0	0	2019-12-06 16:53:46-07	2019-12-06 16:53:46-07	jc104	jc104	0	jc
154	opciones_b	1	1	1	1	0	2019-12-06 16:53:46-07	2019-12-06 16:53:46-07	jc104	jc104	0	jc
\.


--
-- Data for Name: menus_presentacion; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_presentacion (idpresentacion, descripcion, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
\.


--
-- Name: menus_presentacion_idpresentacion_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_presentacion_idpresentacion_seq', 1, false);


--
-- Data for Name: menus_scripts; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_scripts (idscript, descripcion, sql, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico) FROM stdin;
1	creacion del esquema de juzgados	create schema jc;	2019-10-28 18:51:50-06	jc9	2019-10-28 18:51:50-06	jc9
5	alta del catalogo de juzgados	SET search_path = jc, pg_catalog;\nCREATE TABLE juzgados (\n    idjuzgado integer NOT NULL,\n    alcaldia varchar(100) ,\n    juzgado varchar(100) ,\n    direccion varchar(100) ,\n    turno varchar(30) ,\n    horario varchar(30) ,\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.juzgados OWNER TO postgres;\nCOMMENT ON TABLE juzgados IS 'tabla que contiene el catalogo de juzgados | Juzgados';\n\nCOMMENT ON COLUMN juzgados.idjuzgado IS 'id del juzgado';\n\n\nCOMMENT ON COLUMN juzgados.alcaldia IS 'Alcaldia';\n\nCOMMENT ON COLUMN juzgados.alcaldia IS 'Alcaldia';\n\nCOMMENT ON COLUMN juzgados.juzgado IS 'Juzgado' ;\n\nCOMMENT ON COLUMN juzgados.direccion IS 'Direccion';\nCOMMENT ON COLUMN juzgados.turno IS 'Turno';\nCOMMENT ON COLUMN juzgados.horario IS 'horario';\n\n\n--\n-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE; Schema: jc; Owner: postgres\n--\n\nCREATE SEQUENCE juzgados_idjuzgado_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.juzgados_idjuzgado_seq OWNER TO postgres;\n\n--\n-- Name: juzgados_idjuzgado_seq; Type: SEQUENCE OWNED BY; Schema: jc; Owner: postgres\n--\n\nALTER SEQUENCE juzgados_idjuzgado_seq OWNED BY juzgados.idjuzgado;\n\n\n--\n-- Name: idjuzgado; Type: DEFAULT; Schema: jc; Owner: postgres\n--\n\nALTER TABLE ONLY juzgados ALTER COLUMN idjuzgado SET DEFAULT nextval('juzgados_idjuzgado_seq'::regclass);\n\n\nALTER TABLE ONLY juzgados\n    ADD CONSTRAINT juzgados_pkey PRIMARY KEY (idjuzgado);\n\n\n--\n-- Name: ak1_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace:\n--\n\n\n\n--\n-- Name: ak2_juzgados; Type: INDEX; Schema: jc; Owner: postgres; Tablespace:\n--	2019-10-28 21:02:29-06	jc9	2019-10-28 21:02:29-06	jc9
10	borra infracciones	drop table jc.infracciones;	2019-10-29 07:03:18-06	jc9	2019-10-29 07:03:18-06	jc9
11	crea infracciones	SET search_path = jc, pg_catalog;\n\nCREATE TABLE infracciones (\n    idinfraccion integer NOT NULL,\n    infraccion varchar(100) not null,\n    articulo integer not null,\n    fraccion varchar(10) not null,\n    descripcion varchar(256) not null,\n    conciliacion varchar(50) ,\n    aplicarsi varchar(100) ,\n    sancion varchar(3) not null,\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.infracciones OWNER TO postgres;\nCOMMENT ON TABLE infracciones IS 'tabla que contiene el catalogo de infracciones | Juzgados';\nCOMMENT ON COLUMN infracciones.idinfraccion IS 'id de la infraccion';\nCOMMENT ON COLUMN infracciones.infraccion IS 'Infracción ';\nCOMMENT ON COLUMN infracciones.articulo IS 'Artículo' ;\nCOMMENT ON COLUMN infracciones.fraccion IS 'Fracción';\nCOMMENT ON COLUMN infracciones.conciliacion IS 'Conciliación';\nCOMMENT ON COLUMN infracciones.aplicarsi IS 'Aplicar si';\nCOMMENT ON COLUMN infracciones.sancion IS 'Tipo';\nCOMMENT ON COLUMN infracciones.descripcion IS 'Descripción';\nCREATE SEQUENCE infracciones_idinfraccion_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.infracciones_idinfraccion_seq OWNER TO postgres;\nALTER SEQUENCE infracciones_idinfraccion_seq OWNED BY infracciones.idinfraccion;\n\nALTER TABLE ONLY infracciones ALTER COLUMN idinfraccion SET DEFAULT nextval('infracciones_idinfraccion_seq'::regclass);\nALTER TABLE ONLY infracciones\n    ADD CONSTRAINT infracciones_pkey PRIMARY KEY (idinfraccion);	2019-10-29 07:15:28-06	jc9	2019-10-29 07:15:28-06	jc9
12	crea sanciones	SET search_path = jc, pg_catalog;\n\nCREATE TABLE sanciones (\n    idsancion integer NOT NULL,\n    tipo varchar(2) not null,\n    uc_desde numeric(3) ,\n    uc_hasta numeric(3),\n    servicio_desde numeric(3),\n    servicio_hasta numeric(3),\n    arresto_desde numeric(3),\n    arresto_hasta numeric(3),\n    fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_alta character varying(20) DEFAULT getpgusername(),\n    fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,\n    usuario_modifico character varying(20) DEFAULT getpgusername()\n);\n\n\nALTER TABLE jc.sanciones OWNER TO postgres;\nCOMMENT ON TABLE sanciones IS 'Sanciones';\nCOMMENT ON COLUMN sanciones.idsancion IS 'id de la sancion';\nCOMMENT ON COLUMN sanciones.tipo IS 'Tipo ';\nCOMMENT ON COLUMN sanciones.uc_desde IS 'Unidad de cuenta desde' ;\nCOMMENT ON COLUMN sanciones.uc_hasta IS 'Unidad de cuenta hasta';\nCOMMENT ON COLUMN sanciones.servicio_desde IS 'Horas de Servicio Comunitatio desde';\nCOMMENT ON COLUMN sanciones.servicio_hasta IS 'Horas de Servicio Comunitatio hasta';\nCOMMENT ON COLUMN sanciones.arresto_desde IS 'Horas de arresto desde';\nCOMMENT ON COLUMN sanciones.arresto_hasta IS 'Horas de arresto hasta';\nCREATE SEQUENCE sanciones_idsancion_seq\n    START WITH 1\n    INCREMENT BY 1\n    NO MINVALUE\n    NO MAXVALUE\n    CACHE 1;\n\n\nALTER TABLE jc.sanciones_idsancion_seq OWNER TO postgres;\nALTER SEQUENCE sanciones_idsancion_seq OWNED BY sanciones.idsancion;\n\nALTER TABLE ONLY sanciones ALTER COLUMN idsancion SET DEFAULT nextval('sanciones_idsancion_seq'::regclass);\nALTER TABLE ONLY sanciones\n    ADD CONSTRAINT sanciones_pkey PRIMARY KEY (idsancion);	2019-10-29 07:39:30-06	jc9	2019-10-29 07:39:30-06	jc9
16	crea boletas	SET search_path = jc, pg_catalog;drop TABLE boletas ;CREATE TABLE boletas (Â Â Â  idboleta integer NOT NULL,Â Â Â  boleta_remision varchar(20) ,Â Â Â  id_policia_01 integer ,Â Â Â  id_policia_02 integer ,Â Â Â  patrulla varchar(30) ,Â Â Â  id_areaadcripcion integer,Â Â Â  nombre_inf varchar(30) ,Â Â Â  primer_apellido_inf varchar(30),Â Â Â  segundo_apellido_inf varchar(30),Â Â Â  sexo varchar(1),Â Â Â  curp varchar(18),Â Â Â  id_nacimiento integer,Â Â Â  fecha_nacimiento timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,Â Â Â  calle_inf varchar(30),Â Â Â  interior_inf varchar(15),Â Â Â  exterior_inf varchar(15),Â Â Â  cp_inf varchar(5),Â Â Â  id_colonia_inf integer,Â Â Â  id_alcaldia_inf integer,Â Â Â  id_foto_infÂ Â Â  integer,Â Â Â  fecha_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,Â Â Â  hora_hechos timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,Â Â Â  calle_hechos varchar(30),Â Â Â  interior_hechos varchar(15),Â Â Â  exterior_hechos varchar(15),Â Â Â  cp_hechos varchar(5),Â Â Â  id_colonia_hechos integer,Â Â Â  id_alcaldia_hechos integer,Â Â Â  motivo_infraccion text,Â Â Â  objetos_recogidos text,Â Â Â  idinfraccion integer,Â Â Â  sancion_uc integer,Â Â Â  sancion_servicio integer,Â Â Â  sancion_arrestoÂ  integer,Â Â Â  sancion_observacion text,Â Â Â  estatus integer default 0,Â Â Â  expediente varchar(30),Â Â Â  fecha_alta timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,Â Â Â  usuario_alta character varying(20) DEFAULT getpgusername(),Â Â Â  fecha_modifico timestamp(0) with time zone DEFAULT ('now'::text)::timestamp(0) with time zone,Â Â Â  usuario_modifico character varying(20) DEFAULT getpgusername());ALTER TABLE jc.boletas OWNER TO postgres;COMMENT ON TABLE boletas IS 'Boletas de resmision';COMMENT ON COLUMN boletas.idboleta IS 'id de la boleta';COMMENT ON COLUMN boletas.id_policia_01 IS 'Policia uno ';COMMENT ON COLUMN boletas.id_policia_02 IS 'Policia dos ';COMMENT ON COLUMN boletas.patrulla IS 'Numero de patrulla u medio de transporte' ;COMMENT ON COLUMN boletas.nombre_inf IS 'Nombre(s)';COMMENT ON COLUMN boletas.primer_apellido_inf IS 'Primer apellido';COMMENT ON COLUMN boletas.segundo_apellido_inf IS 'Segundo apellido';COMMENT ON COLUMN boletas.sexo IS 'Sexo';COMMENT ON COLUMN boletas.curp IS 'Curp';COMMENT ON COLUMN boletas.id_nacimiento IS 'Lugar de nacimiento';COMMENT ON COLUMN boletas.fecha_nacimiento IS 'Fecha de nacimiento';COMMENT ON COLUMN boletas.calle_inf IS 'Calle';COMMENT ON COLUMN boletas.interior_inf IS 'No. interior';COMMENT ON COLUMN boletas.exterior_inf IS 'No. exterior';COMMENT ON COLUMN boletas.cp_inf IS 'CÃ³digo postal';COMMENT ON COLUMN boletas.id_colonia_inf IS 'Colonia';COMMENT ON COLUMN boletas.id_alcaldia_inf IS 'Alcaldia';COMMENT ON COLUMN boletas.id_foto_inf IS 'FotografÃ­a';COMMENT ON COLUMN boletas.fecha_hechos IS 'Fecha en que ocurrieron los hechos';COMMENT ON COLUMN boletas.hora_hechos IS 'Fecha en que ocurrieron los hechos';COMMENT ON COLUMN boletas.calle_hechos IS 'Calle';COMMENT ON COLUMN boletas.interior_hechos IS 'No. interior';COMMENT ON COLUMN boletas.exterior_hechos IS 'No. exterior';COMMENT ON COLUMN boletas.cp_hechos IS 'CÃ³digo postal';COMMENT ON COLUMN boletas.id_colonia_hechos IS 'Colonia';COMMENT ON COLUMN boletas.id_alcaldia_hechos IS 'Alcaldia';COMMENT ON COLUMN boletas.motivo_infraccion IS 'Datos de la probable infracciÃ³n';COMMENT ON COLUMN boletas.objetos_recogidos IS 'Objeto(s) recogido(s) relacionado(s) con la(s) probable(s) infracciÃ³n(es)';COMMENT ON COLUMN boletas.idinfraccion IS 'ArtÃ­culos';COMMENT ON COLUMN boletas.estatus IS 'Estatus de la boleta';CREATE SEQUENCE boletas_idboleta_seqÂ Â Â  START WITH 1Â Â Â  INCREMENT BY 1Â Â Â  NO MINVALUEÂ Â Â  NO MAXVALUEÂ Â Â  CACHE 1;ALTER TABLE jc.boletas_idboleta_seq OWNER TO postgres;ALTER SEQUENCE boletas_idboleta_seq OWNED BY boletas.idboleta;ALTER TABLE ONLY boletas ALTER COLUMN idboleta SET DEFAULT nextval('boletas_idboleta_seq'::regclass);ALTER TABLE ONLY boletasÂ Â Â  ADD CONSTRAINT boletas_pkey PRIMARY KEY (idboleta);	2019-10-29 13:26:47-06	jc9	2019-10-29 13:26:47-06	jc9
\.


--
-- Name: menus_scripts_idscript_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_scripts_idscript_seq', 16, true);


--
-- Data for Name: menus_seguimiento; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_seguimiento (idseguimietno, idmenu, usename, fecha_alta, usuario_alta) FROM stdin;
\.


--
-- Name: menus_seguimiento_idseguimietno_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_seguimiento_idseguimietno_seq', 1, false);


--
-- Data for Name: menus_subvistas; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_subvistas (idmenus_subvistas, idmenu, texto, imagen, idsubvista, funcion, dialogwidth, dialogheight, esboton, donde, eventos_antes, eventos_despues, campo_filtro, valor_padre, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, clase, posicion, orden, ventana) FROM stdin;
1	11	Historico		5		1049	511	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
2	14	tablas		1		966	522	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
3	18	Grupos		3		1135	568	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
5	14	grupos		21		1108	714	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
6	17	Log		26		976	602	2	0			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
7	11	Accesos Usuario		0		843	479	2	1			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
10	14	Log		26		976	602	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	950	0
12	16	Menus		21		1108	714	1	1			groname	rolname	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
13	14	Subvistas		30		1052	560	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
14	14	Seguimiento		28		555	476	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	800	0
17	17	Grupos		3		1135	568	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
18	17	Historico		5		1049	511	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
19	11	Cambio de Password		0		845	448	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
20	15	Grupos		3		1135	568	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
21	14	Historico		0		790	574	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
22	17	Accesos Usuario		0		843	479	2	1			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
26	14	Movtos		27		809	526	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
27	9	Registro	fas fa-user-plus	19		635	470	1	1					2019-10-12 00:00:00-06	inicio	\N	\N		1	20	0
29	1	Historico		0		737	474	1	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
30	3	Historico		0		736	306	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
32	14	Eventos		7		1020	463	2	1			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
35	11	Log		26		976	602	2	0			usuario_alta	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
36	17	Cambio de Password		0		845	448	2	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
38	16	Usuarios		3		1135	568	1	1			groname	rolname	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
15	13	Archivo		0	crea_sqlarchivo	40	30	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
16	13	Baja Admon		0	baja_admon	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	1	10	0
23	17	Permisos		0	permisos	50	30	1	1			usename	usename	2019-10-12 00:00:00-06	inicio	\N	\N	src/php/seguridad_class.php	0	0	0
25	14	Copia Opcion		0	copiaopcion	40	30	1	0					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
28	13	Base		0	crea_menusbase	40	30	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/reingenieria_class.php	0	0	0
34	16	PermisosGrupo		0	permisosgrupo	0	0	1	0					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/seguridad_class.php	0	0	0
37	23	Validar FIEL	entrar.gif	0	validafiel	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/firma_digital.php	1	10	0
9	20	Eventos		7		879	433	1	0			idmenu;attnum	idmenu;attnum	2019-10-12 00:00:00-06	inicio	\N	\N		0	10	0
8	14	Campos		20		800	600	2	0			idmenu	idmenu	2019-10-12 00:00:00-06	inicio	\N	\N		0	0	0
33	9	Ingresar	fas fa-sign-in-alt	0	validausuario	0	0	1	1					2019-10-12 00:00:00-06	inicio	\N	\N	src/php/seguridad_class.php	1	10	0
42	46	Ejecuta	\N	0	ejecuta	40	30	1	\N	\N	\N	\N	\N	2019-10-28 19:44:45-06	jc9	2019-10-28 19:44:45-06	jc9	src/php/reingenieria_class.php	0	0	0
41	31	Base		0	crea_desdeexcel	40	30	1	1					2019-10-20 19:38:33.016632-06	inicio	2019-10-20 19:38:33.016632-06	inicio	src/php/reingenieria_class.php	0	0	0
\.


--
-- Name: menus_subvistas_idmenus_subvistas_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_subvistas_idmenus_subvistas_seq', 42, true);


--
-- Data for Name: menus_tiempos; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_tiempos (idtiempo, descripcion, fecha_alta, fecha_modifico, usuario_alta, usuario_modifico, unidadtiempo, tiempo, orden) FROM stdin;
\.


--
-- Name: menus_tiempos_idtiempo_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_tiempos_idtiempo_seq', 1, false);


--
-- Data for Name: tcases; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY tcases (tcase, descripcion) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--

