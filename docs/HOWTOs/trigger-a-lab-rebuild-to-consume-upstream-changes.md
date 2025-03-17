# HOW TO Trigger a lab build to consume upstream changes

This guide explains how to trigger a rebuild of an existing lab environment to incorporate upstream changes without modifying the lab content.

## When to Use This Guide

Use this guide when you need to:

- Incorporate platform-level fixes, enhancements, or new features from the lab-building-service to an existing lab

## Prerequisites

Before you begin, ensure you:

- Have access to the `lftraining` GitHub Organization
- Are a member of the `lab-authors` team

## Triggering a Lab Rebuild Using the Workflow

1. Open the lab repository in your browser
2. Navigate to the **Actions** tab in the repository
3. Locate and select the `trigger lab build` workflow
4. Click **Run workflow**
5. In the dropdown menu for `Use workflow from`, select the branch containing your lab environment
    - This is typically the branch where your lab content is defined (like `feature/implement-LFS2580004`)
    - If rebuilding from main, select `main`
6. Fill in the workflow parameters


### Workflow Parameters

- **Compute Environment Names** (required)
    - Enter a comma-separated list of compute environment names you want to rebuild
    - Example: `LFS2580004,LFS2580005`

!!!important "Branch Selection"
    The branch selection is part of GitHub's interface, not a workflow parameter, but still shows up in the same interface. Make sure to select the correct branch while entering the workflow parameters.

## What Happens Next

After triggering the workflow:

1. The system identifies the specified compute environments
2. Each environment is sent to the lab-building-service for rebuilding
3. The labs are rebuilt with the latest platform updates
4. No changes are made to your lab content or configuration
5. A comment on the PR is added with the new lab version and a link to staging.

!!!note "Build Time"
    Rebuilding a lab can take 20-30 minutes depending on the complexity of the environment.
    You can monitor progress in the Actions tab of the repository.
