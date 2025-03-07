# This repository is designed for S3 bucket management

- `agalias-templates` bucket is used by backend for storing user templates. `versioning` is disabled for this bucket.
- `agalias-terraform-state-files` this bucket is designed to store environment tfstate files and have `versioning` enabled.

**Note:** this terraform should not be changed ideally. Bucket should always be there
