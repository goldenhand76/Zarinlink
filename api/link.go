package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/goldenhand76/zarinlink/db/sqlc"
)

type createLinkRequest struct {
	PortfolioID int64  `json:"portfolio_id" binding:"required"`
	Title       string `json:"title" binding:"required,oneof=Instagram LinkedIn GitHub Website Twitter Facebook Other"`
	Url         string `json:"original_url" binding:"required,url"`
}

func (server *Server) createLink(ctx *gin.Context) {
	var req createLinkRequest
	if err := ctx.ShouldBindJSON(&req); err != nil {
		ctx.JSON(400, gin.H{"error": err.Error()})
		return
	}

	arg := db.CreateLinkParams{
		PortfolioID: sql.NullInt64{Int64: req.PortfolioID, Valid: true},
		Title:       req.Title,
		Url:         req.Url,
	}

	link, err := server.store.CreateLink(ctx, arg)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	ctx.JSON(http.StatusOK, link)

}
