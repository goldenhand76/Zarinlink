-- name: GetLinks :many
SELECT * FROM links 
WHERE portfolio_id = $1 
ORDER BY id;


-- name: CreateLink :one
INSERT INTO links (
    portfolio_id,
    title,
    url
) VALUES (
    $1, $2, $3
) RETURNING *;

-- name: UpdateLink :one
UPDATE links
SET title = $2,
    url = $3
WHERE id = $1   
RETURNING *;

-- name: DeleteLink :exec
DELETE FROM links
WHERE id = $1;
