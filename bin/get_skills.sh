#!/usr/bin/env bash
set -euo pipefail

OPENCODE_CONFIG="${HOME}/.config/opencode"

ensure_skills_path_in_config() {
    local skills_path="$1"
    local config_file="${OPENCODE_CONFIG}/opencode.json"

    if ! command -v jq &>/dev/null; then
        echo "Warning: jq not found. Skipping opencode.json update." >&2
        echo "Manually add \"${skills_path}\" to skills.paths in ${config_file}" >&2
        return
    fi

    if [ ! -f "${config_file}" ]; then
        echo "Creating ${config_file}..."
        jq -n \
            --arg p "${skills_path}" \
            '{"$schema": "https://opencode.ai/config.json", "skills": {"paths": [$p]}}' \
            > "${config_file}"
        echo "Created ${config_file} with skills path: ${skills_path}"
        return
    fi

    if jq -e --arg p "${skills_path}" '(.skills.paths // []) | contains([$p])' "${config_file}" > /dev/null; then
        echo "Skills path already registered: ${skills_path}"
        return
    fi

    local tmp
    tmp="$(mktemp)"
    jq --arg p "${skills_path}" \
        '.skills.paths = ((.skills.paths // []) + [$p])' \
        "${config_file}" > "${tmp}"
    mv "${tmp}" "${config_file}"
    echo "Registered skills path: ${skills_path}"
}

clone_skills() {
    local repo_url="$1"
    local org_name
    org_name="$(echo "${repo_url}" | sed 's|.*[:/]\(.*\)/.*|\1|')"
    local dest="${OPENCODE_CONFIG}/${org_name}"

    if [ -d "${dest}/.git" ]; then
        echo "Updating ${org_name}..."
        git -C "${dest}" pull
    else
        echo "Cloning skills from ${repo_url} into ${dest}..."
        git clone --no-checkout --filter=blob:none --depth 1 "${repo_url}" "${dest}"
        git -C "${dest}" sparse-checkout init --cone
        git -C "${dest}" sparse-checkout set skills
        git -C "${dest}" checkout
    fi

    ensure_skills_path_in_config "~/.config/opencode/${org_name}/skills"
}

mkdir -p "${OPENCODE_CONFIG}"
clone_skills git@github.com:tavily-ai/skills.git
clone_skills git@github.com:anthropics/skills.git
