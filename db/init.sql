-- Se ejecuta automaticamente la primera vez que se crea el volumen de Postgres
-- (docker-entrypoint-initdb.d). Si el volumen ya existe, este script NO se
-- vuelve a correr -- para reiniciar desde cero: docker compose down -v

CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_tasks_completed ON tasks (completed);