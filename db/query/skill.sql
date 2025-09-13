-- name: GetSkills :many
SELECT * FROM skills 
WHERE portfolio_id = $1
ORDER BY id;


-- name: CreateSkill :one
INSERT INTO skills (
    portfolio_id,
    title,
    progress
) VALUES (
    $1, $2, $3
) RETURNING *;  

-- name: UpdateSkill :one
UPDATE skills   
SET title = $2,
    progress = $3
WHERE id = $1   
RETURNING *;

-- name: DeleteSkill :exec
DELETE FROM skills
WHERE id = $1;
