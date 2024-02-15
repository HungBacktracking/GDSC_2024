package controllers

import (
	"net/http"

	"server/bootstrap"
	"server/domain"

	"github.com/labstack/echo/v4"
)

func GetAllCategory(c echo.Context) error {
	ctx := c.Request().Context()

	// Reference to the "category" collection
	collectionName := "EmergencyCase"
	query := bootstrap.FirestoreClient.Collection(collectionName)

	// Get all documents from the collection
	docs, err := query.Documents(ctx).GetAll()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
	}

	// Parse Firestore documents to an array of UserInfo
	var categories []domain.Category
	for _, doc := range docs {
		var category domain.Category
		if err := doc.DataTo(&category); err != nil {
			return c.JSON(http.StatusInternalServerError, domain.ErrorResponse{Message: "Internal Server Error"})
		}
		categories = append(categories, category)
	}

	return c.JSON(http.StatusOK, categories)
}
