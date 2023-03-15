# ActionMan
Fun to Funky

## Why?

0) Why not?
1) It's free
2) Testing good
3) Proof of work
4) You enjoy working on other peoples computers

## Goals

After reading through this repository/demo you will be able to:

- Set up actions for a git repository hosted on github.com
- Use Make to simplify actions
- Do work with actions on other code/repositories

## Setting up Actions

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

