# Scaffold template repository
Purpose: scaffold the unnecessary stuff (junk) from template are deleted from the cloned repo.


* In the root of your repo, create {{cookiecutter.name}}/README.md with the following content:
> Note, content of this file will become the body of your new repo READMME.
```
# {{cookiecutter.name}}
Your project repository is ready. Dream big and automate!
```


* Add cookiecutter.json with the below contents into your repository root.
> Note, content of this file will become the subject/title line of your new repo README.
```
{
    "name": "Your Project Name Here"
}
```


* Create .github/workflows/scaffold-repo.yml with the following content
> Note, there are great comments in this script to give you insight on what's actually happening.
```
name: Scaffold repository
on:
  push:
    paths:
      - cookiecutter.json

jobs:
  setup:
    name: Reinitialize repository
    runs-on: ubuntu-latest
    env:
      REPO_SETUP_TOKEN: ${{ secrets.REPO_SETUP_TOKEN }}
    permissions: #use permissions to modify the default permissions granted to the GITHUB_TOKEN
      contents: write  # To push a branch
      pull-requests: write  # To create a PR from that branch
      actions: write

    steps:
      - name: Do not run scaffolding on template repository
        shell: bash
        # This workflow runs when the `cookiecutter.json` file is modified.
        # This is the trick to re-init a repository, but we don't want to
        # run this action if this file is modified in the origin template repository.
        #
        # Using the GitHub rest API allows us to identify if the current repository
        # is a template repository or not.
        run: |
          curl --silent -X GET \
            -H "Authorization: token ${{ secrets.GITHUB_TOKEN }}" \
            -H "Accept: application/vnd.github.baptiste-preview+json" \
            https://api.github.com/repos/$GITHUB_REPOSITORY \
            | jq --exit-status '.is_template == false';

      - uses: actions/checkout@v2
        with:
          # Comminting workflow files using the regular GITHUB_TOKEN will fail with
          # `Git Error: Refusing to allow a GitHub App to create or update workflow without workflows permission`.
          # This is by design to prevent third-parties from adding malicious workflow files.
          #
          # Generate a new personal access token with the workflow `scope` does the trick.
          token: ${{ env.REPO_SETUP_TOKEN || secrets.GITHUB_TOKEN }}

      - uses: actions/setup-python@v2
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: pip install cookiecutter

      - name: Scaffolding repository
        # cookiecutter is command-line utility to create projects from templates
        #
        # --no-input      Do not prompt for parameters and only use
        #                 cookiecutter.json file content
        #
        # --output-dir    Where to output the generated project dir into
        run: cookiecutter . --no-input --output-dir ./cookiecutter-temp

      - name: Prepare root directory
        shell: bash
        # Remove config.yml because the documentation is hardcoded for each repo
        # Remove all files and folder except .github/ and cookiecutter-temp (we'll delete this one later)
        run: |
          rm .github/ISSUE_TEMPLATE/config.yml
          find ./ -maxdepth 1 \
          ! -name '.github' \
          ! -name '.git' \
          ! -name 'cookiecutter-temp' \
          ! -name '.' \
          ! -exec rm -rf {} +

      - name: Move files to root
        shell: bash
        # The cookiecutter-temp/ folder contains a single folder which is the
        # generated project by cookiecutter. We want to move all the project
        # files into the root directory so we can reinitialize git in the next step
        run: |
          rsync -r ./cookiecutter-temp/*/ . && \
          rm -rf ./cookiecutter-temp/

      - name: Reinitialize git repository
        shell: bash
        # Reinitialize git after scaffolding this repository.
        # We use `git checkout --orphan` to create a branch in a git init-like state.
        # By force pushing this as `main` we end up with a new clean git history.
        run: |
          git config --global user.email "github-actions[bot]@users.noreply.github.com" && \
          git config --global user.name "github-actions[bot]" && \
          git checkout --orphan temp-branch && \
          git add . && \
          git commit -m 'Initial commit' && \
          git push origin temp-branch:main -f

      - name: Remove secret REPO_SETUP_TOKEN
        # After re-initializing the repository, we can remove the `REPO_SETUP_TOKEN` secret.
        shell: bash
        if: ${{ env.REPO_SETUP_TOKEN }}
        run: |
          curl \
            -X DELETE --fail \
            -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token ${{ env.REPO_SETUP_TOKEN }}" \
            https://api.github.com/repos/$GITHUB_REPOSITORY/actions/secrets/REPO_SETUP_TOKEN
```

* You can now test the this scaffolding by creating a new repo from the template, go to the 'Actions' tab and you'll see the 'Scaffold repository' workflow in action. It takes about 10 seconds to complete. You'll notice that the newly cloned repo has been cleaned of all the junk that came with the template
