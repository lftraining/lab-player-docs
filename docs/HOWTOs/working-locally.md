# HOW TO Work Locally with Lab Environments

As a lab author, you're responsible for creating effective learning experiences through well-crafted lab environments. The platform provides the infrastructure and tooling to run these environments, while you focus on the content and functionality.

This guide explains the boundaries between platform code and lab author code, and shows you how to work effectively within these boundaries.

## Overview

The lab platform separates infrastructure code (maintained by the platform team) from lab content (owned by lab authors). This separation ensures a consistent environment while giving authors flexibility to create effective labs.

## Lab Author Responsibility Boundaries

### What You Own

As a lab author, you have ownership over these specific directories and files:

```
<lab-environment>
├── controlplane/
│   ├── assets/          # Your custom assets
│   └── scripts/
│       ├── answer.sh    # Your solution implementation
│       ├── build.sh     # Your build-time setup
│       └── setup.sh     # Your runtime setup
├── instructions.en.md   # Your lab instructions
└── worker/
    ├── assets/          # Your custom assets
    └── scripts/
        ├── answer.sh    # Your solution implementation
        ├── build.sh     # Your build-time setup
        └── setup.sh     # Your runtime setup
```

### Off-Limits Areas

Do not modify these platform components:
- Any `Makefile` files
- `.make/` directories and their contents
- `Dockerfile` files
- `.copier-answers.yml` files
- `k8s` directory
- `cli.sh` file
- Any other infrastructure files

## Authorized Make Targets

As a lab author, you're authorized to use only these Make targets:

### `make shell`

**Purpose**: Starts the lab environment with all VMs for testing.
```bash
# From the lab directory
make shell
```

**What it does**:
- Builds VM images (if needed)
- Starts all VMs in the environment
- Creates a tmux session with a pane for each VM
- Mounts your repository directory as `/item` in each VM

**Why it exists**: This target creates a functioning test environment that matches what learners will experience, allowing you to verify your lab content works correctly.

### `make clean`

**Purpose**: Cleans up all resources after testing.
```bash
# From the lab directory
make clean
```

**What it does**:
- Stops all running VMs
- Removes temporary files
- Frees system resources

**Why it exists**: This prevents resource conflicts and system slowdowns by properly cleaning up after testing.

## Understanding the VM Environment

When a VM is running through `make shell`:

1. **Repository Mount**: Your repository directory is mounted at `/item` inside each VM.
   - Changes made to files in `/item` from inside the VM are reflected in your local repository
   - This allows you to test script changes without restarting the environment

2. **Navigation Between VMs**: In the tmux session:
   - Use `Ctrl+B arrow-key` to switch between VM panes
   - Each pane represents a separate VM
   - Exit a VM with the `exit` command

3. **Accessing Your Scripts**: Inside each VM:
   - Your scripts are accessible at `/item/controlplane/scripts/` or `/item/worker/scripts/`
   - You can run them directly with `/item/controlplane/scripts/setup.sh`
   - Changes take effect immediately without needing to restart the VM

## Conclusion

By respecting the boundary between platform infrastructure and lab content, you can focus on creating high-quality educational experiences while the platform team maintains the underlying system.

Remember:
- Only modify files within your ownership areas
- Only use the authorized Make targets (`shell` and `clean`)
- When in doubt, contact the platform team or EI team rather than modifying platform code

This separation of concerns ensures a stable, consistent experience for both lab authors and learners.

