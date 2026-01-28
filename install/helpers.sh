# Get last release version from github repo
# repo format: owner_name/repo_name
get_latest_github_release() {
    local repo=$1
    # 1. Fetch JSON from API
    # 2. Look for "tag_name"
    # 3. Strip everything except numbers and dots (handles 'v1.2' -> '1.2')
    wget -qO- "https://api.github.com/repos/${repo}/releases/latest" | \
    grep -Po '"tag_name":\s*"\K[^"]*' | \
    sed 's/^v//'
}
