# HOW TO Create Incremental Labs

This guide shows you how to create incremental labs that provide a seamless learning experience across multiple lab environments in Kubernetes training courses.

## Overview

Incremental labs create the illusion of continuity for learners while actually switching to new VMs that have been pre-configured to represent the expected end state of the previous lab. This allows learners to continue from where they left off in previous labs without having to recreate the environment themselves.

## Prerequisites

- Basic knowledge of shell scripting
- Understanding of the lab platform structure
- Familiarity with Kubernetes concepts (for Kubernetes-specific labs)

## Creating Incremental Labs

### 1. Understand the Lab Environment Structure

Each lab environment typically includes a structure similar to the following (simplified representation):

```
compute-environments/
└── available/
    └── 1.0/
        ├── controlplane/
        │   ├── assets/
        │   └── scripts/
        │       ├── build.sh
        │       └── setup.sh
        ├── instructions.en.md
        └── worker/
            ├── assets/
            └── scripts/
                ├── build.sh
                └── setup.sh
```

Two key scripts control VM configuration:

- `build.sh`: Runs during VM image creation to establish the base state
- `setup.sh`: Runs when the VM starts up for runtime configuration

### 2. Determine What State to Recreate

To create an incremental lab that follows a previous lab:

1. Identify the end state of the previous lab by reviewing:

   - Lab instructions from the previous section
   - Expected actions performed by the learner
   - Final state of all systems involved

2. Decide which configurations belong in `build.sh` vs. `setup.sh`:

   - Use `build.sh` for persistent changes that can be baked into the VM
   - Use `setup.sh` for configuration that must occur at runtime

The `build.sh` script should include all preparation that can be done at build time. Some common examples include:

- Installing required packages and dependencies
- Creating directories and files
- Copying required assets to the VM
- Pre-pulling container images
- Configuring user accounts

This list is not exhaustive - you can include any operations that can be performed during the image building phase and don't require runtime information.

Example `build.sh` for a Kubernetes control plane node:

```bash
#!/usr/bin/env bash
# shellcheck shell=bash
set -ex

# Copy configuration files
cp assets/kubeadm-config.yaml /root/

# Any other setup that can be done at build time
# ...
```

### 4. Implement the Setup Script

The `setup.sh` script handles runtime configuration:

- Operations that require the VM's actual IP address
- Cluster initialization commands
- Node joining operations
- Starting required services
- Host file configuration

Example `setup.sh` for a Kubernetes control plane node:

```bash
#!/usr/bin/env bash
# shellcheck shell=bash
set -ex

# Configure host entries
echo "$(hostname -I)" controlplane1 k8scp | tee -a /etc/hosts

# Initialize the Kubernetes cluster
kubeadm init --config=/root/kubeadm-config.yaml --upload-certs --node-name=controlplane1 |
  tee /root/kubeadm-init.out
```

### 5. Ensure Continuity Between Environments

For effective incremental labs:

- Create each environment to exactly match the expected state at the end of the previous lab
- Consider all VMs in the environment (control plane, worker nodes, workstation)
- Maintain configuration files, network settings, and installed software
- Ensure hosts can communicate with each other

## Real-world Example: Creating a Kubernetes Lab Series

Let's look at a concrete example of creating incremental labs across a two-part Kubernetes installation course:

### Lab 3.1: Manual Kubernetes Installation

Learners set up a Kubernetes cluster from scratch in the first lab.

**VM Configuration for Lab 3.1:**

- Minimal setup required as learners build the cluster themselves
- Simple `build.sh` scripts to prepare the environment

Example for control plane:
```bash
#!/usr/bin/env bash
# shellcheck shell=bash
set -ex

cp assets/kubeadm-config.yaml /root/
```

### Lab 3.2: Working with a Pre-configured Cluster

This lab begins where 3.1 ended - with a working Kubernetes cluster.

**VM Configuration for Lab 3.2:**

- `build.sh` installs necessary components and configurations
- `setup.sh` handles runtime initialization of the cluster

Control plane `build.sh`:
```bash
#!/usr/bin/env bash
# shellcheck shell=bash
set -ex

cp /dev/null /root/.bashrc
cp assets/kubeadm-config.yaml /root/

apt remove kubectl
```

Control plane `setup.sh`:
```bash
#!/usr/bin/env bash
# shellcheck shell=bash
set -ex

echo "$(hostname -I)" controlplane1 k8scp | tee -a /etc/hosts

kubeadm init --config=/root/kubeadm-config.yaml --upload-certs --node-name=controlplane1 |
  tee /root/kubeadm-init.out
```

Worker node configuration follows similar patterns, with setup scripts handling runtime operations.

You can find complete examples of incremental labs in the LFS258 course repositories:

- [Lab 3.1 Environment](https://github.com/lftraining/LFS258-Labs/tree/feature/implement-LFS2580003/compute-environments/available/LFS2580003)
- [Lab 3.2 Environment](https://github.com/lftraining/LFS258-Labs/tree/feature/implement-LFS2580003.2/compute-environments/available/LFS2580003.2)

These examples show how the second lab (3.2) builds upon the state established in the first lab (3.1).

## Best Practices

1. **Distinguish between build and runtime operations**

   - `build.sh`: Persistent changes, package installation, file setup
   - `setup.sh`: Runtime configuration, networking, service initialization

2. **Replicate exactly what the learner would have done**

   - Follow the previous lab's instructions to understand what state to recreate
   - Ensure all files, directories, and configurations match the expected state

3. **Consider dependencies between systems**

   - Ensure proper sequencing of operations across multiple VMs
   - Configure networking to allow systems to communicate

4. **Test thoroughly**

   - Manually test the transition between labs
   - Verify that the environment picks up seamlessly where the previous lab left off


## Conclusion

Creating incremental labs requires careful planning to recreate the exact state expected at the end of a previous lab. By properly using `build.sh` and `setup.sh` scripts, you can create a seamless learning experience that allows learners to progress through complex topics without losing their work.

Remember that what is instructed to the learner in one lab is up to you as the lab author to recreate in the next lab, distinguishing between operations that can be baked into the build and those that must happen at runtime.
