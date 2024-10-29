CREATE OR REPLACE FUNCTION slugify(value TEXT)
RETURNS TEXT AS $$
  DECLARE
    slugified TEXT := value;  -- Start by converting to lowercase
  BEGIN
    -- Perform straightforward string replacements
    slugified := replace(slugified, ',', '.');
    slugified := replace(slugified, '/', '.');
    slugified := replace(slugified, '&', 'and');
    slugified := replace(slugified, 'ApS', '');
    slugified := replace(slugified, 'AB ', '');
    slugified := replace(slugified, ' BV', '');
    slugified := replace(slugified, ' OHG', '');
    slugified := replace(slugified, ' DAC', '');
    slugified := replace(slugified, ' NV', '');
    slugified := replace(slugified, ' SA', '');
    slugified := replace(slugified, ' SL', '');
    slugified := replace(slugified, ' SRL', '');
    slugified := replace(slugified, ' SB', '');
    slugified := replace(slugified, ' SPA', '');
    slugified := replace(slugified, 'SpA', '');
    slugified := replace(slugified, '(publ)', '');
    slugified := replace(slugified, 'The ', '');
    slugified := replace(slugified, ' Pte', '');
    slugified := replace(slugified, 'PVT', '');
    slugified := replace(slugified, ' Oyj', '');
    slugified := replace(slugified, ' Oy', '');
    slugified := replace(slugified, ' AB', '');
    slugified := replace(slugified, ' ASA', '');
    slugified := replace(slugified, ' AS', '');
    slugified := replace(slugified, ' AG', '');

    slugified := lower(slugified);
    
    -- Replace accented characters
    slugified := replace(slugified, 'ã', 'a');
    slugified := replace(slugified, 'å', 'a');
    slugified := replace(slugified, 'ä', 'a');
    slugified := replace(slugified, 'æ', 'ae');
    slugified := replace(slugified, 'ç', 'c');
    slugified := replace(slugified, 'ð', 'd');
    slugified := replace(slugified, 'é', 'e');
    slugified := replace(slugified, 'è', 'e');
    slugified := replace(slugified, 'ê', 'e');
    slugified := replace(slugified, 'ë', 'e');
    slugified := replace(slugified, 'ė', 'e');
    slugified := replace(slugified, 'ğ', 'g');
    slugified := replace(slugified, 'í', 'i');
    slugified := replace(slugified, 'ï', 'i');
    slugified := replace(slugified, 'i̇', 'i');
    slugified := replace(slugified, 'ı', 'i');
    slugified := replace(slugified, 'ñ', 'n');
    slugified := replace(slugified, 'ó', 'o');
    slugified := replace(slugified, 'ô', 'o');
    slugified := replace(slugified, 'ö', 'o');
    slugified := replace(slugified, 'õ', 'o');
    slugified := replace(slugified, 'ø', 'o');
    slugified := replace(slugified, 'ś', 's');
    slugified := replace(slugified, 'š', 's');
    slugified := replace(slugified, 'ş', 's');
    slugified := replace(slugified, 'ß', 'b');
    slugified := replace(slugified, 'ú', 'u');
    slugified := replace(slugified, 'ü', 'u');
    slugified := replace(slugified, 'ų', 'u');
    slugified := replace(slugified, 'ū', 'u');
    slugified := replace(slugified, 'ż', 'z');

    -- Replace additional company suffixes and terms
    slugified := replace(slugified, ' abp', '');
    slugified := replace(slugified, 'gmbh', '');
    slugified := replace(slugified, ' oü', '');
    slugified := replace(slugified, 'a.s', '');
    slugified := replace(slugified, 'b.v', '');
    slugified := replace(slugified, 'd.d', '');
    slugified := replace(slugified, ' corp.', '');
    slugified := replace(slugified, ' co.', '');
    slugified := replace(slugified, 'n.v', '');
    slugified := replace(slugified, 'i̇.s.', '');
    slugified := replace(slugified, 'de c.v', '');
    slugified := replace(slugified, 's.m.e', '');
    slugified := replace(slugified, 's.a.p.i.', '');
    slugified := replace(slugified, 's.a.s.u', '');
    slugified := replace(slugified, 's.a.s', '');
    slugified := replace(slugified, 's.a.c', '');
    slugified := replace(slugified, 's.a.b', '');
    slugified := replace(slugified, 's.a', '');
    slugified := replace(slugified, 's.p.a', '');
    slugified := replace(slugified, 'sp. z o. o.', '');
    slugified := replace(slugified, 'sp.z.o.o', '');
    slugified := replace(slugified, 'sp. z o.o.', '');
    slugified := replace(slugified, 'ltda', '');
    slugified := replace(slugified, 'ltd', '');
    slugified := replace(slugified, ' limited', '');
    slugified := replace(slugified, ' llc', '');
    slugified := replace(slugified, ' llp', '');
    slugified := replace(slugified, ' incorporated', '');
    slugified := replace(slugified, ' international', '');
    slugified := replace(slugified, ' corporation', '');
    slugified := replace(slugified, ' company', '');
    slugified := replace(slugified, ' inc', '');
    slugified := replace(slugified, ' group', '');
    slugified := replace(slugified, ' ehf', '');
    slugified := replace(slugified, ' plc', '');
    slugified := replace(slugified, ' pty', '');
    slugified := replace(slugified, ' pvt', '');
    slugified := replace(slugified, ' sgps', '');
    
    -- Normalize spaces and hyphens
    slugified := regexp_replace(slugified, '[^a-z0-9 -]', '', 'gi');  -- Remove disallowed characters
    slugified := regexp_replace(slugified, '\s+', '-', 'gi');  -- Replace spaces with hyphens
    slugified := regexp_replace(slugified, '-{2,}', '-', 'g');  -- Replace multiple hyphens with a single hyphen
    slugified := regexp_replace(slugified, '[^a-z0-9-]', '', 'gi');  -- Remove any remaining invalid characters
    slugified := regexp_replace(slugified, '^-|-$', '', 'g');  -- Trim leading and trailing hyphens

    RETURN slugified;
  END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;

CREATE OR REPLACE FUNCTION public.set_unique_slug_from_name() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    base_slug TEXT;
    new_slug TEXT;
    counter INTEGER := 1;
BEGIN
-- Generate the base slug
    base_slug := slugify(NEW.name);
    new_slug := base_slug;

-- Check if the slug already exists
    WHILE EXISTS (SELECT 1 FROM company WHERE slug = new_slug) LOOP
-- If it exists, append a number and increment
        new_slug := base_slug || '-' || counter;
        counter := counter + 1;
    END LOOP;

    NEW.slug := new_slug;
    RETURN NEW;
END
$$;

CREATE OR REPLACE TRIGGER "t_company_insert" BEFORE INSERT ON "company" FOR EACH ROW WHEN (NEW.name IS NOT NULL AND NEW.slug IS NULL)
EXECUTE PROCEDURE set_unique_slug_from_name();

