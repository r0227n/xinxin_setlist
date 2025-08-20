#!/bin/bash

set -e

# Firebase configuration setup script for multiple flavors
# Usage: ./scripts/setup-firebase-flavors.sh [flavor]
# If no flavor is specified, all flavors will be configured

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default flavors
FLAVORS=("development" "staging" "production")

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if flutterfire CLI is installed
check_flutterfire_cli() {
    if ! command -v flutterfire &> /dev/null; then
        print_error "flutterfire CLI is not installed. Please install it first:"
        echo "dart pub global activate flutterfire_cli"
        exit 1
    fi
}

# Function to ensure we're in the app directory
ensure_app_directory() {
    # Get the script's directory
    local script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    local project_root="$(dirname "$script_dir")"
    local app_dir="$project_root/app"
    
    if [ ! -d "$app_dir" ]; then
        print_error "App directory not found: $app_dir"
        print_error "Please run this script from the project root or ensure the app directory exists"
        exit 1
    fi
    
    print_status "Changing to app directory: $app_dir"
    cd "$app_dir"
}

# Function to create directory structure
create_directory_structure() {
    local target_dir="lib/config/environment/src"
    
    if [ ! -d "$target_dir" ]; then
        print_status "Creating directory structure: $target_dir"
        mkdir -p "$target_dir"
        print_success "Directory structure created"
    else
        print_status "Directory structure already exists: $target_dir"
    fi
}

# Function to read Firebase project from .dart_define JSON file
get_firebase_project() {
    local flavor=$1
    local dart_define_file=".dart_define/${flavor}.json"
    
    if [ ! -f "$dart_define_file" ]; then
        print_error "Configuration file not found: $dart_define_file"
        return 1
    fi
    
    # Extract FIREBASE_PROJECT_ID from JSON file using jq or fallback to grep/sed
    if command -v jq &> /dev/null; then
        local project_id=$(jq -r '.FIREBASE_PROJECT_ID // empty' "$dart_define_file")
    else
        # Fallback method without jq
        local project_id=$(grep -o '"FIREBASE_PROJECT_ID"[[:space:]]*:[[:space:]]*"[^"]*"' "$dart_define_file" | sed 's/.*"FIREBASE_PROJECT_ID"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
    fi
    
    if [ -z "$project_id" ] || [ "$project_id" = "null" ]; then
        print_error "FIREBASE_PROJECT_ID not found in $dart_define_file"
        return 1
    fi
    
    echo "$project_id"
}

# Function to configure Firebase for a specific flavor
configure_firebase_flavor() {
    local flavor=$1
    local target_dir="lib/config/environment/src"
    local output_file="${target_dir}/${flavor}_firebase_options.dart"
    
    print_status "Configuring Firebase for flavor: $flavor"
    
    # Get Firebase project ID from .dart_define JSON file
    local firebase_project
    firebase_project=$(get_firebase_project "$flavor")
    if [ $? -ne 0 ]; then
        return 1
    fi
    
    print_status "Using Firebase project: $firebase_project"
    
    # Run flutterfire configure command with project from JSON
    flutterfire configure \
        --project="$firebase_project" \
        --out="$output_file" \
        --platforms="web" \
        --yes
    
    if [ $? -eq 0 ]; then
        print_success "Firebase configuration completed for $flavor"
        print_status "Generated file: $output_file"
    else
        print_error "Failed to configure Firebase for $flavor"
        return 1
    fi
}

# Function to configure all flavors
configure_all_flavors() {
    print_status "Configuring Firebase for all flavors..."
    
    for flavor in "${FLAVORS[@]}"; do
        echo ""
        configure_firebase_flavor "$flavor"
    done
}

# Main execution
main() {
    print_status "Starting Firebase flavor configuration..."
    
    # Check prerequisites
    check_flutterfire_cli
    
    # Ensure we're in the app directory
    ensure_app_directory
    
    # Create directory structure
    create_directory_structure
    
    # Check if specific flavor is provided
    if [ $# -eq 1 ]; then
        local requested_flavor=$1
        
        # Validate if requested flavor is in the list
        if [[ " ${FLAVORS[*]} " =~ " ${requested_flavor} " ]]; then
            configure_firebase_flavor "$requested_flavor"
        else
            print_error "Invalid flavor: $requested_flavor"
            print_status "Available flavors: ${FLAVORS[*]}"
            exit 1
        fi
    elif [ $# -eq 0 ]; then
        # No arguments provided, configure all flavors
        configure_all_flavors
    else
        print_error "Too many arguments provided"
        print_status "Usage: $0 [flavor]"
        print_status "Available flavors: ${FLAVORS[*]}"
        exit 1
    fi
    
    echo ""
    print_success "Firebase flavor configuration completed!"
    print_status "Generated files are located in: lib/config/environment/src/"
}

# Run main function with all arguments
main "$@"