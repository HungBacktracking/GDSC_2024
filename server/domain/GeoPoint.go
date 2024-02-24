package domain

import "fmt"

// GeoPoint represents a geographical point with latitude and longitude
type GeoPoint struct {
	Lat float64 `json:"lat" firestore:"lat"`
	Lng float64 `json:"lng" firestore:"lng"`
}

func (g GeoPoint) String() string {
	return fmt.Sprintf("(%f, %f)", g.Lat, g.Lng)
}
