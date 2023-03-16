# ActionMan
Fun to Funky

## Why?

0) Why not?
1) It's free
2) Testing good
3) Proof of work
4) You enjoy working on other peoples computers

## Setting up Actions

Read below to get started with setting up a repository to use actions. Some simple boiler plate 
has been included below to help you get started. Feel free to improvise and not use it though, I'm a 
README not a cop.

<details>
Create a git repository, then make a folder with a file in it.

```bash
mkdir -p .github/workflows
touch .github/workflows/github-actions-demo.yaml
```

Paste this into the file you just made:

```yaml
name: GitHub Actions Demo
run-name: ${{ github.actor }} is testing out GitHub Actions 🚀
on: [push]
jobs:
  Explore-GitHub-Actions:
    runs-on: ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."
      - name: Check out repository code
        uses: actions/checkout@v3
      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."
      - name: List files in the repository
        run: |
          ls ${{ github.workspace }}
      - run: echo "🍏 This job's status is ${{ job.status }}."
```

Save those changes to `github-actions-demo.yaml` and then commit and push changes:

```bash
# this is best practice, don't let others tell you otherwise
git add --all
git commit -m "setup actions"
git push origin main
```

Now navigate to you repository on github and click on the `actions` tab.

![repo_page_github](media/repo_page_github.png)

![repo_actions_page](media/repo_actions_page.png)

Congrats, you have actions.

**Alternatively**, [fork this repository](https://github.com/bendhouseart/ActionMan/fork) or visit the well put together documentation on [github](https://docs.github.com/en/actions/quickstart).

</details>

## Oh please, mon dieu! Yaml? Github syntax?

I don't carry a torch for Github nor it's Actions syntax, you don't have to either. It's often desirable to 
wrap or define "Action" steps independently from the workflow files in `.github/workflows`.

There are infinitely many ways of doing this, but for this short demo we will focus on writing small scripts and
using make to perform "complicated" steps that we might want to use in CI.

<details>

While it's more than acceptable to run a command like this in actions:

```yaml
- name: Check for Updates
      id: updatesmade
      working-directory: dest
      run: |
        git add --all
        git status --porcelain
        if [[ $(git status --porcelain | wc -l) -gt 0 ]]; then
          echo "changesmade=true" >> $GITHUB_OUTPUT
        else
          echo "No changes made."
          echo "You must be up to no good."
          echo "changesmade=false" >> $GITHUB_OUTPUT
        fi
```

It might be more palatable to instead create a small script containing your logic:

```bash changesmade
#!/usr/bin/env bash
git add --all
git status --porcelain
if [[ $(git status --porcelain | wc -l) -gt 0 ]]; then
    echo "changesmade=true" >> $GITHUB_OUTPUT
else
    echo "No changes made."
    echo "You must be up to no good."
    echo "changesmade=false" >> $GITHUB_OUTPUT
fi
```

Which simplifies your actions:

```yaml
- name: Check for Updates
      id: updatesmade
      working-directory: dest
      run: ./changesmade
```

</details>

## Debugging

How do you trouble shoot actions at a distance? 

- ensure steps in actions run locally via scripts/make
- check status badges
- review action logs
- keep pushing till things work

Lastly, one can [ssh into actions runner and poke around using tmate](https://github.com/marketplace/actions/debugging-with-tmate).

<details>

```yaml
# Include a manual trigger in your workflow and enable debugging
workflow_dispatch:
    inputs:
      debug_enabled:
        type: boolean
        description: 'Run the build with tmate debugging enabled (https://github.com/marketplace/actions/debugging-with-tmate)'
        required: false
        default: false

# then place this step into your workflow file
name: CI
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Setup tmate session
      uses: mxschmitt/action-tmate@v3
```
</details>


## Technical Challenge

Ingredients:

- github user account
- two github repositories
- [Fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#fine-grained-personal-access-tokens)
- github actions workflow file

Instructions:

- Configure and apply Fine-grained personal access token on working repo
- Checkout second repo from first repository
- Make and push a change to the second repo from the first using actions
