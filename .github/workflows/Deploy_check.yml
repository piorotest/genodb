name: Deploy_check

on:
  pull_request:  # This ensures the action runs whenever a pull request is created or updated.

jobs:
  Deploy_check:
    runs-on: self-hosted  # Use the latest Ubuntu environment.
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
           fetch-depth: 0

      - name: configure runner
        uses: ./.github/actions/dbgit/
        with:
          action: "config"
          sysdba: "true"
          database_host: docker
          database_port: 1521
          database_service: target
          genusername: sys

      - name: Check code against checkdb
        uses: ./.github/actions/dbgit/
        with:
          deploy_schema: ${{ vars.SCHEMA_OWNER1 }}
          deploy_schema_password: ${{ vars.SCHEMA_OWNER1 }}
          action: "generateall"
          genpass: ${{ secrets.GENPASS }}
          github_token: ${{ secrets.GITHUB_TOKEN }}
          pr_number: ${{ github.event.pull_request.number }}
          repo_name: ${{ github.repository }}
