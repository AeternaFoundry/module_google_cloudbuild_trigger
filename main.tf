resource "google_cloudbuild_trigger" "cloudbuild_triggers" {
  for_each = var.cloudbuild_triggers

  deletion_policy    = each.value.deletion_policy
  description        = each.value.description
  disabled           = each.value.disabled
  filename           = each.value.filename
  filter             = each.value.filter
  ignored_files      = each.value.ignored_files
  include_build_logs = each.value.include_build_logs
  included_files     = each.value.included_files
  location           = each.value.location
  name               = each.value.name
  project            = each.value.project
  service_account    = each.value.service_account
  substitutions      = each.value.substitutions
  tags               = each.value.tags

  dynamic "approval_config" {
    for_each = each.value.approval_config != null ? [each.value.approval_config] : []
    content {
      approval_required = approval_config.value.approval_required
    }
  }

  dynamic "bitbucket_server_trigger_config" {
    for_each = each.value.bitbucket_server_trigger_config != null ? [each.value.bitbucket_server_trigger_config] : []
    content {
      bitbucket_server_config_resource = bitbucket_server_trigger_config.value.bitbucket_server_config_resource
      project_key                      = bitbucket_server_trigger_config.value.project_key
      dynamic "pull_request" {
        for_each = bitbucket_server_trigger_config.value.pull_request != null ? [bitbucket_server_trigger_config.value.pull_request] : []
        content {
          branch          = pull_request.value.branch
          comment_control = pull_request.value.comment_control
          invert_regex    = pull_request.value.invert_regex
        }
      }
      dynamic "push" {
        for_each = bitbucket_server_trigger_config.value.push != null ? [bitbucket_server_trigger_config.value.push] : []
        content {
          branch       = push.value.branch
          invert_regex = push.value.invert_regex
          tag          = push.value.tag
        }
      }
      repo_slug = bitbucket_server_trigger_config.value.repo_slug
    }
  }

  dynamic "build" {
    for_each = each.value.build != null ? [each.value.build] : []
    content {
      dynamic "artifacts" {
        for_each = build.value.artifacts != null ? [build.value.artifacts] : []
        content {
          images = artifacts.value.images
          dynamic "maven_artifacts" {
            for_each = artifacts.value.maven_artifacts != null ? artifacts.value.maven_artifacts : []
            content {
              artifact_id = maven_artifacts.value.artifact_id
              group_id    = maven_artifacts.value.group_id
              path        = maven_artifacts.value.path
              repository  = maven_artifacts.value.repository
              version     = maven_artifacts.value.version
            }
          }
          dynamic "npm_packages" {
            for_each = artifacts.value.npm_packages != null ? artifacts.value.npm_packages : []
            content {
              package_path = npm_packages.value.package_path
              repository   = npm_packages.value.repository
            }
          }
          dynamic "objects" {
            for_each = artifacts.value.objects != null ? [artifacts.value.objects] : []
            content {
              location = objects.value.location
              paths    = objects.value.paths
            }
          }
          dynamic "python_packages" {
            for_each = artifacts.value.python_packages != null ? artifacts.value.python_packages : []
            content {
              paths      = python_packages.value.paths
              repository = python_packages.value.repository
            }
          }
        }
      }
      dynamic "available_secrets" {
        for_each = build.value.available_secrets != null ? [build.value.available_secrets] : []
        content {
          dynamic "secret_manager" {
            for_each = available_secrets.value.secret_manager
            content {
              env          = secret_manager.value.env
              version_name = secret_manager.value.version_name
            }
          }
        }
      }
      images      = build.value.images
      logs_bucket = build.value.logs_bucket
      dynamic "options" {
        for_each = build.value.options != null ? [build.value.options] : []
        content {
          disk_size_gb            = options.value.disk_size_gb
          dynamic_substitutions   = options.value.dynamic_substitutions
          env                     = options.value.env
          log_streaming_option    = options.value.log_streaming_option
          logging                 = options.value.logging
          machine_type            = options.value.machine_type
          requested_verify_option = options.value.requested_verify_option
          secret_env              = options.value.secret_env
          source_provenance_hash  = options.value.source_provenance_hash
          substitution_option     = options.value.substitution_option
          dynamic "volumes" {
            for_each = options.value.volumes != null ? options.value.volumes : []
            content {
              name = volumes.value.name
              path = volumes.value.path
            }
          }
          worker_pool = options.value.worker_pool
        }
      }
      queue_ttl = build.value.queue_ttl
      dynamic "secret" {
        for_each = build.value.secret != null ? build.value.secret : []
        content {
          kms_key_name = secret.value.kms_key_name
          secret_env   = secret.value.secret_env
        }
      }
      dynamic "source" {
        for_each = build.value.source != null ? [build.value.source] : []
        content {
          dynamic "repo_source" {
            for_each = source.value.repo_source != null ? [source.value.repo_source] : []
            content {
              branch_name   = repo_source.value.branch_name
              commit_sha    = repo_source.value.commit_sha
              dir           = repo_source.value.dir
              invert_regex  = repo_source.value.invert_regex
              project_id    = repo_source.value.project_id
              repo_name     = repo_source.value.repo_name
              substitutions = repo_source.value.substitutions
              tag_name      = repo_source.value.tag_name
            }
          }
          dynamic "storage_source" {
            for_each = source.value.storage_source != null ? [source.value.storage_source] : []
            content {
              bucket     = storage_source.value.bucket
              generation = storage_source.value.generation
              object     = storage_source.value.object
            }
          }
        }
      }
      dynamic "step" {
        for_each = build.value.step
        content {
          allow_exit_codes = step.value.allow_exit_codes
          allow_failure    = step.value.allow_failure
          args             = step.value.args
          dir              = step.value.dir
          entrypoint       = step.value.entrypoint
          env              = step.value.env
          id               = step.value.id
          name             = step.value.name
          script           = step.value.script
          secret_env       = step.value.secret_env
          timeout          = step.value.timeout
          timing           = step.value.timing
          dynamic "volumes" {
            for_each = step.value.volumes != null ? step.value.volumes : []
            content {
              name = volumes.value.name
              path = volumes.value.path
            }
          }
          wait_for = step.value.wait_for
        }
      }
      substitutions = build.value.substitutions
      tags          = build.value.tags
      timeout       = build.value.timeout
    }
  }

  dynamic "developer_connect_event_config" {
    for_each = each.value.developer_connect_event_config != null ? [each.value.developer_connect_event_config] : []
    content {
      git_repository_link = developer_connect_event_config.value.git_repository_link
      dynamic "pull_request" {
        for_each = developer_connect_event_config.value.pull_request != null ? [developer_connect_event_config.value.pull_request] : []
        content {
          branch          = pull_request.value.branch
          comment_control = pull_request.value.comment_control
          invert_regex    = pull_request.value.invert_regex
        }
      }
      dynamic "push" {
        for_each = developer_connect_event_config.value.push != null ? [developer_connect_event_config.value.push] : []
        content {
          branch       = push.value.branch
          invert_regex = push.value.invert_regex
          tag          = push.value.tag
        }
      }
    }
  }

  dynamic "git_file_source" {
    for_each = each.value.git_file_source != null ? [each.value.git_file_source] : []
    content {
      bitbucket_server_config  = git_file_source.value.bitbucket_server_config
      github_enterprise_config = git_file_source.value.github_enterprise_config
      path                     = git_file_source.value.path
      repo_type                = git_file_source.value.repo_type
      repository               = git_file_source.value.repository
      revision                 = git_file_source.value.revision
      uri                      = git_file_source.value.uri
    }
  }

  dynamic "github" {
    for_each = each.value.github != null ? [each.value.github] : []
    content {
      enterprise_config_resource_name = github.value.enterprise_config_resource_name
      name                            = github.value.name
      owner                           = github.value.owner
      dynamic "pull_request" {
        for_each = github.value.pull_request != null ? [github.value.pull_request] : []
        content {
          branch          = pull_request.value.branch
          comment_control = pull_request.value.comment_control
          invert_regex    = pull_request.value.invert_regex
        }
      }
      dynamic "push" {
        for_each = github.value.push != null ? [github.value.push] : []
        content {
          branch       = push.value.branch
          invert_regex = push.value.invert_regex
          tag          = push.value.tag
        }
      }
    }
  }

  dynamic "pubsub_config" {
    for_each = each.value.pubsub_config != null ? [each.value.pubsub_config] : []
    content {
      service_account_email = pubsub_config.value.service_account_email
      topic                 = pubsub_config.value.topic
    }
  }

  dynamic "repository_event_config" {
    for_each = each.value.repository_event_config != null ? [each.value.repository_event_config] : []
    content {
      dynamic "pull_request" {
        for_each = repository_event_config.value.pull_request != null ? [repository_event_config.value.pull_request] : []
        content {
          branch          = pull_request.value.branch
          comment_control = pull_request.value.comment_control
          invert_regex    = pull_request.value.invert_regex
        }
      }
      dynamic "push" {
        for_each = repository_event_config.value.push != null ? [repository_event_config.value.push] : []
        content {
          branch       = push.value.branch
          invert_regex = push.value.invert_regex
          tag          = push.value.tag
        }
      }
      repository = repository_event_config.value.repository
    }
  }

  dynamic "source_to_build" {
    for_each = each.value.source_to_build != null ? [each.value.source_to_build] : []
    content {
      bitbucket_server_config  = source_to_build.value.bitbucket_server_config
      github_enterprise_config = source_to_build.value.github_enterprise_config
      ref                      = source_to_build.value.ref
      repo_type                = source_to_build.value.repo_type
      repository               = source_to_build.value.repository
      uri                      = source_to_build.value.uri
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "trigger_template" {
    for_each = each.value.trigger_template != null ? [each.value.trigger_template] : []
    content {
      branch_name  = trigger_template.value.branch_name
      commit_sha   = trigger_template.value.commit_sha
      dir          = trigger_template.value.dir
      invert_regex = trigger_template.value.invert_regex
      project_id   = trigger_template.value.project_id
      repo_name    = trigger_template.value.repo_name
      tag_name     = trigger_template.value.tag_name
    }
  }

  dynamic "webhook_config" {
    for_each = each.value.webhook_config != null ? [each.value.webhook_config] : []
    content {
      secret = webhook_config.value.secret
    }
  }
}

