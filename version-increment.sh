#!/bin/bash

# Increment version and push new tag with updated library.properties file

echo "Incrementing version..."

# Fetch all tags
git fetch --tags

# Check if there are any tags; if not, start with v1.0.1
latest_tag=$(git tag --sort=-version:refname | head -n 1)
if [ -z "$latest_tag" ]; then
    echo "No tags found, starting with v1.0.1"
    new_version="1.0.1"
else
    echo "Latest tag found: $latest_tag"

    # Extract the base version from the latest tag
    base_version=${latest_tag#v}

    # Determine the bump type (major/minor/patch) based on commit messages
    version_bump="patch"  # Default bump type

    # Analyze commit messages for version bump keywords
    for commit in $(git log "$latest_tag"..HEAD --pretty=format:%s); do
        if [[ $commit == *"BREAKING CHANGE"* ]]; then
            version_bump="major"
            break
        elif [[ $commit == *"feat"* ]]; then
            version_bump="minor"
        fi
    done

    # Function to increment version numbers
    increment_version() {
        local version=$1
        local bump_type=$2
        local IFS='.'
        read -a parts <<< "$version"

        case $bump_type in
            major)
                parts[0]=$((parts[0] + 1))
                parts[1]=0
                parts[2]=0
                ;;
            minor)
                parts[1]=$((parts[1] + 1))
                parts[2]=0
                ;;
            patch)
                parts[2]=$((parts[2] + 1))
                ;;
        esac

        echo "${parts[0]}.${parts[1]}.${parts[2]}"
    }

    # Increment version based on the bump type
    new_version=$(increment_version "$base_version" "$version_bump")
fi

# Output the new version
echo "New version: $new_version"

# Update version in library.properties
sed -i "s/^version=.*/version=$new_version/" library.properties

echo "Updated library.properties to version $new_version"

# Commit changes
git add library.properties

git commit -m "Update library.properties to version $new_version"

# Create and push the new tag
git tag "v${new_version}"
git push origin main
git push origin "v${new_version}"

echo $new_version > VERSION
