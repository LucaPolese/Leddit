--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

-- Started on 2021-01-02 14:37:50

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3141 (class 1262 OID 16641)
-- Name: leddit; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE leddit WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';


ALTER DATABASE leddit OWNER TO postgres;

\connect leddit

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16649)
-- Name: amicizia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.amicizia (
    utente1 character varying(20) NOT NULL,
    utente2 character varying(20) NOT NULL
);


ALTER TABLE public.amicizia OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16804)
-- Name: award; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.award (
    utente character varying(20) NOT NULL,
    commento integer NOT NULL,
    tipo character(1) NOT NULL,
    dataacquisto date NOT NULL
);


ALTER TABLE public.award OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16864)
-- Name: ban; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ban (
    sub character varying(20) NOT NULL,
    utente character varying(20) NOT NULL,
    moderatore character varying(20) NOT NULL,
    modsub character varying(20) NOT NULL,
    databan date NOT NULL,
    scadenza date,
    motivo character varying(255) NOT NULL
);


ALTER TABLE public.ban OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16745)
-- Name: commento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commento (
    id integer NOT NULL,
    datacommento date NOT NULL,
    contenuto character varying(500) NOT NULL,
    isrisposta integer,
    utente character varying(20) NOT NULL,
    post integer NOT NULL,
    isdeleted bit(1) DEFAULT '0'::"bit" NOT NULL,
    votocommento integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.commento OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16743)
-- Name: commento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commento_id_seq OWNER TO postgres;

--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 209
-- Name: commento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commento_id_seq OWNED BY public.commento.id;


--
-- TOC entry 216 (class 1259 OID 16824)
-- Name: feed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feed (
    utente character varying(20) NOT NULL,
    nome character varying(30) NOT NULL
);


ALTER TABLE public.feed OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16834)
-- Name: include; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.include (
    feed character varying(20) NOT NULL,
    utente character varying(20) NOT NULL,
    sub character varying(20) NOT NULL
);


ALTER TABLE public.include OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16692)
-- Name: iscrizione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iscrizione (
    utente character varying(20) NOT NULL,
    sub character varying(20) NOT NULL
);


ALTER TABLE public.iscrizione OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16787)
-- Name: media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media (
    id integer NOT NULL,
    nome character varying(30),
    descrizione character varying(30),
    percorso character varying(60) NOT NULL,
    tipo character varying(5) NOT NULL,
    tag character varying(100),
    CONSTRAINT media_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['foto'::character varying, 'video'::character varying, 'link'::character varying])::text[])))
);


ALTER TABLE public.media OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16785)
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.media_id_seq OWNER TO postgres;

--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 212
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.media_id_seq OWNED BY public.media.id;


--
-- TOC entry 203 (class 1259 OID 16666)
-- Name: messaggio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messaggio (
    id integer NOT NULL,
    datainvio date NOT NULL,
    contenuto character varying(255) NOT NULL,
    mittente character varying(20) NOT NULL,
    destinatario character varying(20) NOT NULL
);


ALTER TABLE public.messaggio OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16664)
-- Name: messaggio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messaggio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messaggio_id_seq OWNER TO postgres;

--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 202
-- Name: messaggio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messaggio_id_seq OWNED BY public.messaggio.id;


--
-- TOC entry 218 (class 1259 OID 16849)
-- Name: moderatore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moderatore (
    utente character varying(20) NOT NULL,
    sub character varying(20) NOT NULL,
    datainizio date NOT NULL
);


ALTER TABLE public.moderatore OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16709)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    titolo character varying(100) NOT NULL,
    datacreazione date NOT NULL,
    contenuto character varying(500) NOT NULL,
    nsfw bit(1) NOT NULL,
    creatore character varying(20) NOT NULL,
    sub character varying(20) NOT NULL,
    numerovoti integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16707)
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_id_seq OWNER TO postgres;

--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 206
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_id_seq OWNED BY public.post.id;


--
-- TOC entry 214 (class 1259 OID 16799)
-- Name: prezzo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prezzo (
    tipo character(1) NOT NULL,
    costo numeric(3,1)
);


ALTER TABLE public.prezzo OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16682)
-- Name: sub; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub (
    nome character varying(20) NOT NULL,
    datacreazione date NOT NULL,
    descrizione character varying(255) NOT NULL,
    ispremium bit(1) NOT NULL,
    nsfw bit(1) NOT NULL,
    creatore character varying(20) NOT NULL
);


ALTER TABLE public.sub OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16642)
-- Name: utente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utente (
    username character varying(20) NOT NULL,
    password character varying(30) NOT NULL,
    email character varying(320) NOT NULL,
    dataiscrizione date NOT NULL,
    isadmin bit(1) DEFAULT '0'::"bit" NOT NULL,
    isdeleted bit(1) DEFAULT '0'::"bit" NOT NULL
);


ALTER TABLE public.utente OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16770)
-- Name: votocommento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votocommento (
    utente character varying(20) NOT NULL,
    commento integer NOT NULL,
    valore integer NOT NULL
);


ALTER TABLE public.votocommento OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16728)
-- Name: votopost; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votopost (
    utente character varying(20) NOT NULL,
    post integer NOT NULL,
    valore integer NOT NULL
);


ALTER TABLE public.votopost OWNER TO postgres;

--
-- TOC entry 2923 (class 2604 OID 16748)
-- Name: commento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commento ALTER COLUMN id SET DEFAULT nextval('public.commento_id_seq'::regclass);


--
-- TOC entry 2926 (class 2604 OID 16790)
-- Name: media id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_id_seq'::regclass);


--
-- TOC entry 2920 (class 2604 OID 16669)
-- Name: messaggio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messaggio ALTER COLUMN id SET DEFAULT nextval('public.messaggio_id_seq'::regclass);


--
-- TOC entry 2921 (class 2604 OID 16712)
-- Name: post id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post ALTER COLUMN id SET DEFAULT nextval('public.post_id_seq'::regclass);


--
-- TOC entry 3117 (class 0 OID 16649)
-- Dependencies: 201
-- Data for Name: amicizia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.amicizia VALUES ('kharrow0', 'gbleything7');
INSERT INTO public.amicizia VALUES ('kharrow0', 'spetrashov8');
INSERT INTO public.amicizia VALUES ('kharrow0', 'asawerse');
INSERT INTO public.amicizia VALUES ('kharrow0', 'dcrunkhorng');
INSERT INTO public.amicizia VALUES ('gbleything7', 'dcrunkhorng');
INSERT INTO public.amicizia VALUES ('gbleything7', 'spetrashov8');


--
-- TOC entry 3131 (class 0 OID 16804)
-- Dependencies: 215
-- Data for Name: award; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.award VALUES ('mslineyc', 3, 'a', '2021-01-02');
INSERT INTO public.award VALUES ('mslineyc', 0, 'o', '2021-01-02');
INSERT INTO public.award VALUES ('smedgwick6', 3, 'p', '2021-01-02');


--
-- TOC entry 3135 (class 0 OID 16864)
-- Dependencies: 219
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ban VALUES ('gaming', 'rsatterfitt3', 'kharrow0', 'gaming', '2021-01-02', '2021-01-12', 'Commenti inappropriati.');
INSERT INTO public.ban VALUES ('pictures', 'rsatterfitt3', 'kharrow0', 'pictures', '2021-01-02', '2021-01-12', 'Commenti inappropriati.');
INSERT INTO public.ban VALUES ('italy', 'rsatterfitt3', 'gbleything7', 'italy', '2021-01-02', NULL, 'Commenti inappropriati.');


--
-- TOC entry 3126 (class 0 OID 16745)
-- Dependencies: 210
-- Data for Name: commento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commento VALUES (3, '2021-01-01', 'Contenuto del commento', NULL, 'oscrannagej', 0, B'0', 3);
INSERT INTO public.commento VALUES (0, '2021-01-01', 'Contenuto del commento', NULL, 'oscrannagej', 3, B'0', 3);
INSERT INTO public.commento VALUES (2, '2021-01-01', 'Contenuto del commento', 2, 'oscrannagej', 3, B'0', 3);
INSERT INTO public.commento VALUES (1, '2021-01-01', 'Contenuto del commento', 1, 'plidsterd', 3, B'0', -1);


--
-- TOC entry 3132 (class 0 OID 16824)
-- Dependencies: 216
-- Data for Name: feed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.feed VALUES ('asawerse', 'videogames');
INSERT INTO public.feed VALUES ('kharrow0', 'subs');


--
-- TOC entry 3133 (class 0 OID 16834)
-- Dependencies: 217
-- Data for Name: include; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.include VALUES ('videogames', 'asawerse', 'gaming');
INSERT INTO public.include VALUES ('videogames', 'asawerse', 'PlayStation');
INSERT INTO public.include VALUES ('subs', 'kharrow0', 'italy');
INSERT INTO public.include VALUES ('subs', 'kharrow0', 'gaming');
INSERT INTO public.include VALUES ('subs', 'kharrow0', 'pictures');
INSERT INTO public.include VALUES ('subs', 'kharrow0', 'PlayStation');


--
-- TOC entry 3121 (class 0 OID 16692)
-- Dependencies: 205
-- Data for Name: iscrizione; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iscrizione VALUES ('kharrow0', 'gold');
INSERT INTO public.iscrizione VALUES ('kharrow0', 'italy');
INSERT INTO public.iscrizione VALUES ('kharrow0', 'gaming');
INSERT INTO public.iscrizione VALUES ('gbleything7', 'italy');
INSERT INTO public.iscrizione VALUES ('gbleything7', 'gaming');
INSERT INTO public.iscrizione VALUES ('vferrierif', 'italy');
INSERT INTO public.iscrizione VALUES ('vferrierif', 'gaming');
INSERT INTO public.iscrizione VALUES ('vferrierif', 'pictures');
INSERT INTO public.iscrizione VALUES ('oscrannagej', 'italy');
INSERT INTO public.iscrizione VALUES ('oscrannagej', 'pictures');
INSERT INTO public.iscrizione VALUES ('ptolotti1', 'gaming');
INSERT INTO public.iscrizione VALUES ('ptolotti1', 'pictures');
INSERT INTO public.iscrizione VALUES ('squinet9', 'gaming');


--
-- TOC entry 3129 (class 0 OID 16787)
-- Dependencies: 213
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.media VALUES (1, 'Funny dog', NULL, 'dog.jpg', 'foto', 'dogs pic funny');


--
-- TOC entry 3119 (class 0 OID 16666)
-- Dependencies: 203
-- Data for Name: messaggio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messaggio VALUES (0, '2020-01-01', '"Davvero?"', 'kharrow0', 'gbleything7');
INSERT INTO public.messaggio VALUES (1, '2019-10-11', '"https://www.youtube.com/watch?v=dQw4w9WgXcQ"', 'kharrow0', 'asawerse');
INSERT INTO public.messaggio VALUES (2, '2021-01-01', '"Buon anno!"', 'gbleything7', 'dcrunkhorng');
INSERT INTO public.messaggio VALUES (3, '2020-12-25', '":)"', 'gbleything7', 'asawerse');


--
-- TOC entry 3134 (class 0 OID 16849)
-- Dependencies: 218
-- Data for Name: moderatore; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.moderatore VALUES ('kharrow0', 'gold', '2020-01-01');
INSERT INTO public.moderatore VALUES ('kharrow0', 'gaming', '2021-01-01');
INSERT INTO public.moderatore VALUES ('kharrow0', 'pictures', '2010-01-01');
INSERT INTO public.moderatore VALUES ('asawerse', 'PlayStation', '2020-01-02');
INSERT INTO public.moderatore VALUES ('gbleything7', 'italy', '2020-12-20');
INSERT INTO public.moderatore VALUES ('smedgwick6', 'gaming', '2021-01-02');
INSERT INTO public.moderatore VALUES ('oscrannagej', 'gaming', '2021-01-02');
INSERT INTO public.moderatore VALUES ('asawerse', 'italy', '2021-01-02');


--
-- TOC entry 3123 (class 0 OID 16709)
-- Dependencies: 207
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.post VALUES (2, 'upgrade suggestions', '2021-01-01', 'Contenuto del post', B'0', 'vferrierif', 'gaming', 0);
INSERT INTO public.post VALUES (0, 'Primo post', '2020-12-31', 'Contenuto del post', B'0', 'kharrow0', 'italy', 3);
INSERT INTO public.post VALUES (1, 'Funny dog pic', '2021-01-01', 'Contenuto del post', B'0', 'ptolotti1', 'pictures', 5);
INSERT INTO public.post VALUES (3, 'PS5 vs XBSX', '2021-01-01', 'Contenuto del post', B'0', 'ptolotti1', 'gaming', -3);


--
-- TOC entry 3130 (class 0 OID 16799)
-- Dependencies: 214
-- Data for Name: prezzo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.prezzo VALUES ('a', 5.0);
INSERT INTO public.prezzo VALUES ('o', 7.5);
INSERT INTO public.prezzo VALUES ('p', 10.5);


--
-- TOC entry 3120 (class 0 OID 16682)
-- Dependencies: 204
-- Data for Name: sub; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sub VALUES ('gold', '2020-01-01', 'Leddit premium community:)', B'1', B'0', 'kharrow0');
INSERT INTO public.sub VALUES ('italy', '2020-12-20', 'Welcome everyone! This is a place to post and discuss anything related to Italy. We also speak English!', B'0', B'0', 'gbleything7');
INSERT INTO public.sub VALUES ('gaming', '2021-01-01', 'A subleddit for (almost) anything related to games - video games, board games, card games, etc. (but not sports).', B'0', B'0', 'kharrow0');
INSERT INTO public.sub VALUES ('pictures', '2010-01-01', 'A place for pictures and photographs.', B'0', B'1', 'kharrow0');
INSERT INTO public.sub VALUES ('PlayStation', '2020-01-02', 'Everything PS', B'0', B'0', 'asawerse');


--
-- TOC entry 3116 (class 0 OID 16642)
-- Dependencies: 200
-- Data for Name: utente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utente VALUES ('kharrow0', 'ebT5ZKGCfwm5', 'tzanneli0@php.net', '2020-11-16', B'0', B'0');
INSERT INTO public.utente VALUES ('ptolotti1', 'OcGoGRM', 'awapple1@delicious.com', '2020-10-06', B'0', B'0');
INSERT INTO public.utente VALUES ('ekondratovich2', 'ZUTpcwFAaHB', 'ostronach2@vistaprint.com', '2020-09-07', B'0', B'0');
INSERT INTO public.utente VALUES ('rsatterfitt3', 'XBUj7HHCvRh', 'crobjents3@si.edu', '2020-03-07', B'0', B'0');
INSERT INTO public.utente VALUES ('fbagnal4', '3uVejDhtK', 'wgreet4@ycombinator.com', '2020-10-31', B'0', B'0');
INSERT INTO public.utente VALUES ('gvasyutin5', 'RyjYswLSVu', 'jfairlie5@slideshare.net', '2020-05-13', B'0', B'0');
INSERT INTO public.utente VALUES ('smedgwick6', 'BIDNj9PpnDV', 'plinton6@rediff.com', '2020-12-24', B'0', B'0');
INSERT INTO public.utente VALUES ('gbleything7', 'db7WkgW04nyx', 'ttheis7@google.ru', '2020-07-20', B'0', B'0');
INSERT INTO public.utente VALUES ('spetrashov8', 'hTIPCYJUwd', 'lhellen8@admin.ch', '2020-04-01', B'0', B'0');
INSERT INTO public.utente VALUES ('squinet9', 'IZIPCH3qBW83', 'scrighton9@webmd.com', '2020-02-09', B'0', B'0');
INSERT INTO public.utente VALUES ('mkornesa', 'pxCPtHkXAi', 'cdirobertoa@ustream.tv', '2020-10-28', B'0', B'0');
INSERT INTO public.utente VALUES ('vpinchingb', 'Aakvd8MYRy', 'rkelkb@taobao.com', '2020-04-22', B'0', B'0');
INSERT INTO public.utente VALUES ('mslineyc', '7wotXujaoliy', 'ojakovc@auda.org.au', '2020-01-31', B'0', B'0');
INSERT INTO public.utente VALUES ('plidsterd', 'wH4IUAxrOI', 'bkoubekd@phoca.cz', '2020-08-23', B'0', B'0');
INSERT INTO public.utente VALUES ('asawerse', 'MRd57FrdkKf', 'eleidle@usgs.gov', '2020-06-15', B'0', B'0');
INSERT INTO public.utente VALUES ('vferrierif', 'J37u0ecD', 'mbastidef@shutterfly.com', '2020-11-11', B'0', B'0');
INSERT INTO public.utente VALUES ('dcrunkhorng', 'ylan4PwpW2', 'acastagnerig@usatoday.com', '2020-08-16', B'0', B'0');
INSERT INTO public.utente VALUES ('rblackhallh', 'p0tH2851tp', 'fwilcockesh@technorati.com', '2020-03-02', B'0', B'0');
INSERT INTO public.utente VALUES ('mfitchetti', '1BuL57FMFHs', 'jruddochi@marriott.com', '2020-11-29', B'0', B'0');
INSERT INTO public.utente VALUES ('oscrannagej', 'As2dAxD', 'wgallantj@joomla.org', '2020-01-22', B'0', B'0');


--
-- TOC entry 3127 (class 0 OID 16770)
-- Dependencies: 211
-- Data for Name: votocommento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.votocommento VALUES ('oscrannagej', 0, 1);
INSERT INTO public.votocommento VALUES ('oscrannagej', 1, 1);
INSERT INTO public.votocommento VALUES ('oscrannagej', 2, 1);
INSERT INTO public.votocommento VALUES ('oscrannagej', 3, 1);
INSERT INTO public.votocommento VALUES ('vferrierif', 1, -1);
INSERT INTO public.votocommento VALUES ('vferrierif', 3, 1);
INSERT INTO public.votocommento VALUES ('vferrierif', 0, 1);
INSERT INTO public.votocommento VALUES ('rblackhallh', 2, 1);
INSERT INTO public.votocommento VALUES ('rblackhallh', 0, 1);
INSERT INTO public.votocommento VALUES ('smedgwick6', 2, 1);
INSERT INTO public.votocommento VALUES ('smedgwick6', 3, 1);
INSERT INTO public.votocommento VALUES ('asawerse', 1, -1);


--
-- TOC entry 3124 (class 0 OID 16728)
-- Dependencies: 208
-- Data for Name: votopost; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.votopost VALUES ('kharrow0', 0, 1);
INSERT INTO public.votopost VALUES ('vferrierif', 0, 1);
INSERT INTO public.votopost VALUES ('ptolotti1', 0, 1);
INSERT INTO public.votopost VALUES ('kharrow0', 1, 1);
INSERT INTO public.votopost VALUES ('vferrierif', 1, 1);
INSERT INTO public.votopost VALUES ('ptolotti1', 1, 1);
INSERT INTO public.votopost VALUES ('mkornesa', 1, 1);
INSERT INTO public.votopost VALUES ('rsatterfitt3', 1, 1);
INSERT INTO public.votopost VALUES ('kharrow0', 3, -1);
INSERT INTO public.votopost VALUES ('mkornesa', 3, -1);
INSERT INTO public.votopost VALUES ('mslineyc', 3, -1);


--
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 209
-- Name: commento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commento_id_seq', 1, false);


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 212
-- Name: media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.media_id_seq', 1, false);


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 202
-- Name: messaggio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messaggio_id_seq', 1, false);


--
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 206
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 1, false);


--
-- TOC entry 2931 (class 2606 OID 16653)
-- Name: amicizia amicizia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amicizia
    ADD CONSTRAINT amicizia_pkey PRIMARY KEY (utente1, utente2);


--
-- TOC entry 2951 (class 2606 OID 16808)
-- Name: award award_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_pkey PRIMARY KEY (utente, commento);


--
-- TOC entry 2943 (class 2606 OID 16754)
-- Name: commento commento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commento
    ADD CONSTRAINT commento_pkey PRIMARY KEY (id);


--
-- TOC entry 2953 (class 2606 OID 16828)
-- Name: feed feed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feed
    ADD CONSTRAINT feed_pkey PRIMARY KEY (utente, nome);


--
-- TOC entry 2955 (class 2606 OID 16838)
-- Name: include include_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.include
    ADD CONSTRAINT include_pkey PRIMARY KEY (feed, utente, sub);


--
-- TOC entry 2937 (class 2606 OID 16696)
-- Name: iscrizione iscrizione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscrizione
    ADD CONSTRAINT iscrizione_pkey PRIMARY KEY (utente, sub);


--
-- TOC entry 2947 (class 2606 OID 16793)
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- TOC entry 2933 (class 2606 OID 16671)
-- Name: messaggio messaggio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messaggio
    ADD CONSTRAINT messaggio_pkey PRIMARY KEY (id);


--
-- TOC entry 2957 (class 2606 OID 16853)
-- Name: moderatore moderatore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderatore
    ADD CONSTRAINT moderatore_pkey PRIMARY KEY (utente, sub);


--
-- TOC entry 2939 (class 2606 OID 16717)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 2949 (class 2606 OID 16803)
-- Name: prezzo prezzo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prezzo
    ADD CONSTRAINT prezzo_pkey PRIMARY KEY (tipo);


--
-- TOC entry 2935 (class 2606 OID 16686)
-- Name: sub sub_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub
    ADD CONSTRAINT sub_pkey PRIMARY KEY (nome);


--
-- TOC entry 2929 (class 2606 OID 16648)
-- Name: utente utente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (username);


--
-- TOC entry 2945 (class 2606 OID 16774)
-- Name: votocommento votocommento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votocommento
    ADD CONSTRAINT votocommento_pkey PRIMARY KEY (utente, commento);


--
-- TOC entry 2941 (class 2606 OID 16732)
-- Name: votopost votopost_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votopost
    ADD CONSTRAINT votopost_pkey PRIMARY KEY (utente, post);


--
-- TOC entry 2958 (class 2606 OID 16654)
-- Name: amicizia amicizia_utente1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amicizia
    ADD CONSTRAINT amicizia_utente1_fkey FOREIGN KEY (utente1) REFERENCES public.utente(username);


--
-- TOC entry 2959 (class 2606 OID 16659)
-- Name: amicizia amicizia_utente2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amicizia
    ADD CONSTRAINT amicizia_utente2_fkey FOREIGN KEY (utente2) REFERENCES public.utente(username);


--
-- TOC entry 2976 (class 2606 OID 16814)
-- Name: award award_commento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_commento_fkey FOREIGN KEY (commento) REFERENCES public.commento(id);


--
-- TOC entry 2977 (class 2606 OID 16819)
-- Name: award award_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_tipo_fkey FOREIGN KEY (tipo) REFERENCES public.prezzo(tipo);


--
-- TOC entry 2975 (class 2606 OID 16809)
-- Name: award award_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.award
    ADD CONSTRAINT award_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2985 (class 2606 OID 16877)
-- Name: ban ban_moderatore_modsub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban
    ADD CONSTRAINT ban_moderatore_modsub_fkey FOREIGN KEY (moderatore, modsub) REFERENCES public.moderatore(utente, sub);


--
-- TOC entry 2983 (class 2606 OID 16867)
-- Name: ban ban_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban
    ADD CONSTRAINT ban_sub_fkey FOREIGN KEY (sub) REFERENCES public.sub(nome);


--
-- TOC entry 2984 (class 2606 OID 16872)
-- Name: ban ban_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban
    ADD CONSTRAINT ban_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2971 (class 2606 OID 16765)
-- Name: commento commento_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commento
    ADD CONSTRAINT commento_post_fkey FOREIGN KEY (post) REFERENCES public.post(id);


--
-- TOC entry 2969 (class 2606 OID 16755)
-- Name: commento commento_risposta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commento
    ADD CONSTRAINT commento_risposta_fkey FOREIGN KEY (isrisposta) REFERENCES public.commento(id);


--
-- TOC entry 2970 (class 2606 OID 16760)
-- Name: commento commento_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commento
    ADD CONSTRAINT commento_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2978 (class 2606 OID 16829)
-- Name: feed feed_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feed
    ADD CONSTRAINT feed_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2980 (class 2606 OID 16844)
-- Name: include include_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.include
    ADD CONSTRAINT include_sub_fkey FOREIGN KEY (sub) REFERENCES public.sub(nome);


--
-- TOC entry 2979 (class 2606 OID 16839)
-- Name: include include_utente_feed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.include
    ADD CONSTRAINT include_utente_feed_fkey FOREIGN KEY (utente, feed) REFERENCES public.feed(utente, nome);


--
-- TOC entry 2964 (class 2606 OID 16702)
-- Name: iscrizione iscrizione_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscrizione
    ADD CONSTRAINT iscrizione_sub_fkey FOREIGN KEY (sub) REFERENCES public.sub(nome);


--
-- TOC entry 2963 (class 2606 OID 16697)
-- Name: iscrizione iscrizione_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iscrizione
    ADD CONSTRAINT iscrizione_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2974 (class 2606 OID 16794)
-- Name: media media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_id_fkey FOREIGN KEY (id) REFERENCES public.post(id);


--
-- TOC entry 2961 (class 2606 OID 16677)
-- Name: messaggio messaggio_destinatario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messaggio
    ADD CONSTRAINT messaggio_destinatario_fkey FOREIGN KEY (destinatario) REFERENCES public.utente(username);


--
-- TOC entry 2960 (class 2606 OID 16672)
-- Name: messaggio messaggio_mittente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messaggio
    ADD CONSTRAINT messaggio_mittente_fkey FOREIGN KEY (mittente) REFERENCES public.utente(username);


--
-- TOC entry 2982 (class 2606 OID 16859)
-- Name: moderatore moderatore_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderatore
    ADD CONSTRAINT moderatore_sub_fkey FOREIGN KEY (sub) REFERENCES public.sub(nome);


--
-- TOC entry 2981 (class 2606 OID 16854)
-- Name: moderatore moderatore_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moderatore
    ADD CONSTRAINT moderatore_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2965 (class 2606 OID 16718)
-- Name: post post_creatore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_creatore_fkey FOREIGN KEY (creatore) REFERENCES public.utente(username);


--
-- TOC entry 2966 (class 2606 OID 16723)
-- Name: post post_sub_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_sub_fkey FOREIGN KEY (sub) REFERENCES public.sub(nome);


--
-- TOC entry 2962 (class 2606 OID 16687)
-- Name: sub sub_creatore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub
    ADD CONSTRAINT sub_creatore_fkey FOREIGN KEY (creatore) REFERENCES public.utente(username);


--
-- TOC entry 2973 (class 2606 OID 16780)
-- Name: votocommento votocommento_commento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votocommento
    ADD CONSTRAINT votocommento_commento_fkey FOREIGN KEY (commento) REFERENCES public.commento(id);


--
-- TOC entry 2972 (class 2606 OID 16775)
-- Name: votocommento votocommento_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votocommento
    ADD CONSTRAINT votocommento_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


--
-- TOC entry 2968 (class 2606 OID 16738)
-- Name: votopost votopost_post_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votopost
    ADD CONSTRAINT votopost_post_fkey FOREIGN KEY (post) REFERENCES public.post(id);


--
-- TOC entry 2967 (class 2606 OID 16733)
-- Name: votopost votopost_utente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votopost
    ADD CONSTRAINT votopost_utente_fkey FOREIGN KEY (utente) REFERENCES public.utente(username);


-- Completed on 2021-01-02 14:37:52

--
-- PostgreSQL database dump complete
--

