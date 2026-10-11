variable "cloudbuild_triggers" {
  description = <<EOT
Map of cloudbuild_triggers, attributes below
Optional:
    - deletion_policy
    - description
    - disabled
    - filename
    - filter
    - ignored_files
    - include_build_logs
    - included_files
    - location
    - name
    - project
    - service_account
    - substitutions
    - tags
    - approval_config (block):
        - approval_required (optional)
    - bitbucket_server_trigger_config (block):
        - bitbucket_server_config_resource (required)
        - project_key (required)
        - pull_request (optional, block):
            - branch (required)
            - comment_control (optional)
            - invert_regex (optional)
        - push (optional, block):
            - branch (optional)
            - invert_regex (optional)
            - tag (optional)
        - repo_slug (required)
    - build (block):
        - artifacts (optional, block):
            - images (optional)
            - maven_artifacts (optional, block):
                - artifact_id (optional)
                - group_id (optional)
                - path (optional)
                - repository (optional)
                - version (optional)
            - npm_packages (optional, block):
                - package_path (optional)
                - repository (optional)
            - objects (optional, block):
                - location (optional)
                - paths (optional)
            - python_packages (optional, block):
                - paths (optional)
                - repository (optional)
        - available_secrets (optional, block):
            - secret_manager (required, block):
                - env (required)
                - version_name (required)
        - images (optional)
        - logs_bucket (optional)
        - options (optional, block):
            - disk_size_gb (optional)
            - dynamic_substitutions (optional)
            - env (optional)
            - log_streaming_option (optional)
            - logging (optional)
            - machine_type (optional)
            - requested_verify_option (optional)
            - secret_env (optional)
            - source_provenance_hash (optional)
            - substitution_option (optional)
            - volumes (optional, block):
                - name (optional)
                - path (optional)
            - worker_pool (optional)
        - queue_ttl (optional)
        - secret (optional, block):
            - kms_key_name (required)
            - secret_env (optional)
        - source (optional, block):
            - repo_source (optional, block):
                - branch_name (optional)
                - commit_sha (optional)
                - dir (optional)
                - invert_regex (optional)
                - project_id (optional)
                - repo_name (required)
                - substitutions (optional)
                - tag_name (optional)
            - storage_source (optional, block):
                - bucket (required)
                - generation (optional)
                - object (required)
        - step (required, block):
            - allow_exit_codes (optional)
            - allow_failure (optional)
            - args (optional)
            - dir (optional)
            - entrypoint (optional)
            - env (optional)
            - id (optional)
            - name (required)
            - script (optional)
            - secret_env (optional)
            - timeout (optional)
            - timing (optional)
            - volumes (optional, block):
                - name (required)
                - path (required)
            - wait_for (optional)
        - substitutions (optional)
        - tags (optional)
        - timeout (optional)
    - developer_connect_event_config (block):
        - git_repository_link (required)
        - pull_request (optional, block):
            - branch (optional)
            - comment_control (optional)
            - invert_regex (optional)
        - push (optional, block):
            - branch (optional)
            - invert_regex (optional)
            - tag (optional)
    - git_file_source (block):
        - bitbucket_server_config (optional)
        - github_enterprise_config (optional)
        - path (required)
        - repo_type (required)
        - repository (optional)
        - revision (optional)
        - uri (optional)
    - github (block):
        - enterprise_config_resource_name (optional)
        - name (optional)
        - owner (optional)
        - pull_request (optional, block):
            - branch (required)
            - comment_control (optional)
            - invert_regex (optional)
        - push (optional, block):
            - branch (optional)
            - invert_regex (optional)
            - tag (optional)
    - pubsub_config (block):
        - service_account_email (optional)
        - topic (required)
    - repository_event_config (block):
        - pull_request (optional, block):
            - branch (optional)
            - comment_control (optional)
            - invert_regex (optional)
        - push (optional, block):
            - branch (optional)
            - invert_regex (optional)
            - tag (optional)
        - repository (optional)
    - source_to_build (block):
        - bitbucket_server_config (optional)
        - github_enterprise_config (optional)
        - ref (required)
        - repo_type (required)
        - repository (optional)
        - uri (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - trigger_template (block):
        - branch_name (optional)
        - commit_sha (optional)
        - dir (optional)
        - invert_regex (optional)
        - project_id (optional)
        - repo_name (optional)
        - tag_name (optional)
    - webhook_config (block):
        - secret (required)
EOT

  type = map(object({
    deletion_policy    = optional(string)
    description        = optional(string)
    disabled           = optional(bool)
    filename           = optional(string)
    filter             = optional(string)
    ignored_files      = optional(list(string))
    include_build_logs = optional(string)
    included_files     = optional(list(string))
    location           = optional(string)
    name               = optional(string)
    project            = optional(string)
    service_account    = optional(string)
    substitutions      = optional(map(string))
    tags               = optional(list(string))
    approval_config = optional(object({
      approval_required = optional(bool)
    }))
    bitbucket_server_trigger_config = optional(object({
      bitbucket_server_config_resource = string
      project_key                      = string
      pull_request = optional(object({
        branch          = string
        comment_control = optional(string)
        invert_regex    = optional(bool)
      }))
      push = optional(object({
        branch       = optional(string)
        invert_regex = optional(bool)
        tag          = optional(string)
      }))
      repo_slug = string
    }))
    build = optional(object({
      artifacts = optional(object({
        images = optional(list(string))
        maven_artifacts = optional(list(object({
          artifact_id = optional(string)
          group_id    = optional(string)
          path        = optional(string)
          repository  = optional(string)
          version     = optional(string)
        })))
        npm_packages = optional(list(object({
          package_path = optional(string)
          repository   = optional(string)
        })))
        objects = optional(object({
          location = optional(string)
          paths    = optional(list(string))
        }))
        python_packages = optional(list(object({
          paths      = optional(list(string))
          repository = optional(string)
        })))
      }))
      available_secrets = optional(object({
        secret_manager = list(object({
          env          = string
          version_name = string
        }))
      }))
      images      = optional(list(string))
      logs_bucket = optional(string)
      options = optional(object({
        disk_size_gb            = optional(number)
        dynamic_substitutions   = optional(bool)
        env                     = optional(list(string))
        log_streaming_option    = optional(string)
        logging                 = optional(string)
        machine_type            = optional(string)
        requested_verify_option = optional(string)
        secret_env              = optional(list(string))
        source_provenance_hash  = optional(list(string))
        substitution_option     = optional(string)
        volumes = optional(list(object({
          name = optional(string)
          path = optional(string)
        })))
        worker_pool = optional(string)
      }))
      queue_ttl = optional(string)
      secret = optional(list(object({
        kms_key_name = string
        secret_env   = optional(map(string))
      })))
      source = optional(object({
        repo_source = optional(object({
          branch_name   = optional(string)
          commit_sha    = optional(string)
          dir           = optional(string)
          invert_regex  = optional(bool)
          project_id    = optional(string)
          repo_name     = string
          substitutions = optional(map(string))
          tag_name      = optional(string)
        }))
        storage_source = optional(object({
          bucket     = string
          generation = optional(string)
          object     = string
        }))
      }))
      step = list(object({
        allow_exit_codes = optional(list(number))
        allow_failure    = optional(bool)
        args             = optional(list(string))
        dir              = optional(string)
        entrypoint       = optional(string)
        env              = optional(list(string))
        id               = optional(string)
        name             = string
        script           = optional(string)
        secret_env       = optional(list(string))
        timeout          = optional(string)
        timing           = optional(string)
        volumes = optional(list(object({
          name = string
          path = string
        })))
        wait_for = optional(list(string))
      }))
      substitutions = optional(map(string))
      tags          = optional(list(string))
      timeout       = optional(string)
    }))
    developer_connect_event_config = optional(object({
      git_repository_link = string
      pull_request = optional(object({
        branch          = optional(string)
        comment_control = optional(string)
        invert_regex    = optional(bool)
      }))
      push = optional(object({
        branch       = optional(string)
        invert_regex = optional(bool)
        tag          = optional(string)
      }))
    }))
    git_file_source = optional(object({
      bitbucket_server_config  = optional(string)
      github_enterprise_config = optional(string)
      path                     = string
      repo_type                = string
      repository               = optional(string)
      revision                 = optional(string)
      uri                      = optional(string)
    }))
    github = optional(object({
      enterprise_config_resource_name = optional(string)
      name                            = optional(string)
      owner                           = optional(string)
      pull_request = optional(object({
        branch          = string
        comment_control = optional(string)
        invert_regex    = optional(bool)
      }))
      push = optional(object({
        branch       = optional(string)
        invert_regex = optional(bool)
        tag          = optional(string)
      }))
    }))
    pubsub_config = optional(object({
      service_account_email = optional(string)
      topic                 = string
    }))
    repository_event_config = optional(object({
      pull_request = optional(object({
        branch          = optional(string)
        comment_control = optional(string)
        invert_regex    = optional(bool)
      }))
      push = optional(object({
        branch       = optional(string)
        invert_regex = optional(bool)
        tag          = optional(string)
      }))
      repository = optional(string)
    }))
    source_to_build = optional(object({
      bitbucket_server_config  = optional(string)
      github_enterprise_config = optional(string)
      ref                      = string
      repo_type                = string
      repository               = optional(string)
      uri                      = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    trigger_template = optional(object({
      branch_name  = optional(string)
      commit_sha   = optional(string)
      dir          = optional(string)
      invert_regex = optional(bool)
      project_id   = optional(string)
      repo_name    = optional(string)
      tag_name     = optional(string)
    }))
    webhook_config = optional(object({
      secret = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.cloudbuild_triggers : (
        v.build == null || (v.build.available_secrets == null || (length(v.build.available_secrets.secret_manager) >= 1))
      )
    ])
    error_message = "Each secret_manager list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.cloudbuild_triggers : (
        v.build == null || (length(v.build.step) >= 1)
      )
    ])
    error_message = "Each step list must contain at least 1 items"
  }
  # Note: 12 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

