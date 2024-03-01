// domain/range.go

package domain

// Range represents a geographical range
type Range struct {
	Lat    float64 `json:"lat"`
	Lng    float64 `json:"lng"`
	Radius float64 `json:"radius"`
}
