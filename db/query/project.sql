-- name: GetProjects :many
SELECT * FROM projects
WHERE portfolio_id = $1
ORDER BY start_date DESC;

-- name: CreateProject :one
INSERT INTO projects (
    portfolio_id,
    title,
    start_date,
    end_date
) VALUES (
    $1, $2, $3, $4
) RETURNING *;  

-- name: UpdateProject :one
UPDATE projects
SET title = $2,
    start_date = $3,
    end_date = $4
WHERE id = $1
RETURNING *;

-- name: DeleteProject :exec
DELETE FROM projects
WHERE id = $1;
