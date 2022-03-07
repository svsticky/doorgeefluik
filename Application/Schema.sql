-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE routes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    url TEXT NOT NULL,
    path TEXT NOT NULL UNIQUE
);
