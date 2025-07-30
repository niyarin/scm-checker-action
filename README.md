# Scm-checker action

This action uses scm-checker to check the syntax of Scheme code.


## Example Usage
```yaml

name: lint

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name : main base sha
      id : main_base_sha
      if : github.ref  == 'refs/heads/main'
      run: echo "base_sha=${{ github.event.before }}" >> $GITHUB_OUTPUT
    - uses: niyarin/scm-checker-action@main
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        base_sha: ${{ github.event.pull_request.base.sha||steps.main_base_sha.outputs.base_sha }}
```
