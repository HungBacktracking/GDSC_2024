// configs/config.go
package configs

import (
	"encoding/json"
	"log"
	"os"
	"path/filepath"
)

// ServiceAccount represents the structure of the service account JSON
type ServiceAccount struct {
	ProjectID string `json:"project_id"`
	// Add other fields as needed
}

// LoadServiceAccount reads the service account JSON file and returns a ServiceAccount struct
func LoadServiceAccount(jsonPath string) (*ServiceAccount, error) {
	// Resolve the absolute path to the JSON file
	absPath, err := filepath.Abs(jsonPath)
	if err != nil {
		log.Printf("Error resolving absolute path: %v", err)
		return nil, err
	}

	// Read the service account JSON file
	serviceAccountJSON, err := os.ReadFile(absPath)
	if err != nil {
		log.Printf("Error reading service account JSON: %v", err)
		return nil, err
	}

	// Parse the JSON into a ServiceAccount struct
	var serviceAccount ServiceAccount
	err = json.Unmarshal(serviceAccountJSON, &serviceAccount)
	if err != nil {
		log.Printf("Error parsing service account JSON: %v", err)
		return nil, err
	}

	return &serviceAccount, nil
}
