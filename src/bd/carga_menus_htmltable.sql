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
-- Data for Name: menus_htmltable; Type: TABLE DATA; Schema: forapi; Owner: postgres
--

COPY menus_htmltable (idhtmltable, descripcion, esdesistema, columnas, fecha_alta, usuario_alta, fecha_modifico, usuario_modifico, idmenu, orden) FROM stdin;
1	CAMPOS CON OPCIONES	f	0	2007-06-28 18:15:51-06	jlv	2007-06-28 18:15:51-06	jlv	\N	\N
0	SIN HTMLTABLE	f	0	2007-07-14 14:10:10-06	jlv	2007-07-14 14:10:10-06	jlv	\N	\N
\.


--
-- Name: menus_htmltable_idhtmltable_seq; Type: SEQUENCE SET; Schema: forapi; Owner: postgres
--

SELECT pg_catalog.setval('menus_htmltable_idhtmltable_seq', 2025, true);


--
-- PostgreSQL database dump complete
--

