

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.routes DISABLE TRIGGER ALL;

INSERT INTO public.routes (id, url, path) VALUES ('6eb2b3da-628a-4545-9644-609b764e808e', 'http://google.com', 'test');
INSERT INTO public.routes (id, url, path) VALUES ('e026c13f-b4ac-4387-b8bc-df168e08981e', 'http://lol.com', 'f');
INSERT INTO public.routes (id, url, path) VALUES ('53f552fb-8f81-4810-8a88-375d14aa8f36', 'https://www.youtube.com/watch?v=o-YBDTqX_ZU', 'panda');


ALTER TABLE public.routes ENABLE TRIGGER ALL;


