-- name: CreatePortfolio :one
INSERT INTO portfolio (
    photo,
    aboutme
) VALUES (
    $1, $2
) RETURNING *;

-- name: GetPortfolio :one
SELECT * FROM portfolio
WHERE id = $1 LIMIT 1;  

-- name: GetPortfolioForUpdate :one
SELECT * FROM portfolio
WHERE id = $1 LIMIT 1 FOR NO KEY UPDATE;

-- name: ListPortfolios :many
SELECT * FROM portfolio ORDER BY id LIMIT $1 OFFSET $2;

-- name: UpdatePortfolio :one
UPDATE portfolio 
SET photo = $2,
    aboutme = $3
WHERE id = $1
RETURNING *;

-- name: DeletePortfolio :exec
DELETE FROM portfolio WHERE id = $1;
DELETE FROM projects WHERE portfolio_id = $1;
DELETE FROM skills WHERE portfolio_id = $1;
DELETE FROM links WHERE portfolio_id = $1;