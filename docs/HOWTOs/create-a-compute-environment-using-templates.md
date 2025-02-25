# HOW TO Create a new Lab Compute Environment

This guide explains how to create a new compute environment using our automated GitHub workflow.

## Prerequisites

Before you begin, ensure you:

- Have access to the `lftraining` GitHub Organization
- You are a member of the `lab-authors` team

## Creating a New Compute Environment
1. Open the lab repository in your browser
2. Navigate to the Actions tab in the repository
3. Locate and select the `New Compute Environment` workflow
4. Click `Run workflow` and fill in the following parameters:

  ![Repository Actions](../img/create-lab-compute-environment.gif)


### Workflow Parameters

- **Environment Template** (required)
  Choose one of the following templates:

  - `k8s-single-node`: Single node Kubernetes environment
  - `k8s-multi-node`: Multi-node Kubernetes environment
  - `linux-single`: Single Linux host environment
  - `linux-dual`: Dual Linux host environment

- **Compute Environment** (required)
  - Enter the prefix for your compute environment (e.g., "LFS25800")

- **Use Workstation** (required)
  - Choose whether to include a workstation VM for the student
  - Defaults to `true`

### Template Configurations

Each template creates different VM configurations:

#### k8s-single-node
- 1 control plane node
- Optional workstation

#### k8s-multi-node
- 1 control plane node
- 1 worker node
- Optional workstation

#### linux-single
- 1 Linux host
- Optional workstation

#### linux-dual
- 2 Linux hosts
- Optional workstation

## What Happens Next

After triggering the workflow:

1. A new feature branch is created (`feature/implement-<compute-environment>`)
2. The necessary template files are generated based on your selection
3. A draft pull request is automatically created
4. You can then customize the environment further by working on the created branch

!!!note "Next Steps"
    After the workflow completes, review the generated pull request and make any necessary customizations to the environment configuration.

### Finding Your Pull Request

1. Navigate to the Pull Requests tab in the repository
2. Look for a PR titled `Implement <your-compute-environment>`
3. Open the PR to review the generated files

  ![Finding your PR](../img/finding-your-pr.gif)

### Working on the Environment Locally

1. Navigate to your local repository
2. In the PR, click the `Code` dropdown button
3. Copy the command under "Checkout with GitHub CLI"
4. Paste and run the command in your terminal:
   ```bash
   gh pr checkout <PR-NUMBER>
   ```

  ![Working locally](../img/working-locally.gif)
