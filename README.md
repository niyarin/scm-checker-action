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


## Example output

<img width="1507" height="641" alt="Screenshot from 2025-07-30 09-54-19" src="https://github.com/user-attachments/assets/665eac24-7bd3-476a-a6b9-b6be365e1297" />
