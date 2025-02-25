# HOW TO Add Instructions to a Lab

This guide explains how to add instructions to your lab after creating the compute environment.

## Prerequisites

Before you begin, ensure you:

- Have access to the `lftraining` GitHub Organization
- Are a member of the `lab-authors` team
- Have created a compute environment using [this HOW TO ](create-a-compute-environment-using-templates.md)


## Adding Instructions Using GitHub Web Interface

  ![Writing Instructions](../img/writing-instructions.gif)

1. Navigate to your Pull Request created by the workflow
2. Click the feature branch `feature/implement-<your-compute-environment>`
2. Locate the `compute-environments/available/<your-compute-environment>` directory
3. Find `instructions.en.md` in this directory
4. Click the edit button (pencil icon) to modify the file

### Writing Instructions

The file uses standard Markdown syntax. When rendered in the lab UI:

- Code blocks get syntax highlighting
- A copy button appears next to code blocks for easy copying

### Saving Your Changes

After editing the instructions:

1. Click the `Commit changes...` button
2. Add a meaningful commit message (e.g., "feat: add lab instructions")
3. Click "Sign off and commit changes"


!!!note "Working Locally"
    If you prefer to work locally, you can clone the repository and edit the files in your preferred editor.

### Automated Environment Creation

After committing your changes:

1. Return to your Pull Request in GitHub
2. Look for a new comment containing the staging environment URL
3. Use this URL to preview and test your lab instructions in the actual lab as a student would

  ![Automated Environment Creation](../img/automated-environment-creation.gif)

!!!tip "Testing Your Lab"
    The staging environment is a complete copy of your lab, allowing you to verify that:

    - Instructions render correctly
    - Code blocks work as expected
    - The environment matches your requirements


!!!tip "Skipping Environment Creation"
    Add `[skip ci]` to your commit message body to skip environment creation. This is useful when:

    - Making minor text corrections
    - Fixing typos
    - Making multiple small changes before testing
