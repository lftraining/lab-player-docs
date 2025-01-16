# HOW TO Creates a Compute Environment Using Templates


# Prerequisites

!!!tip "You'll need access before begining"
    For access refer to [request-access-to-systems.md](request-access-to-systems.md)

Before you begin, ensure you:

  - Have access to lftraining GitHub Organization.
  - Have access to the following repos in the LF-Certification GitHub Organization.
    - [LF-Certification/copier-compute-environment](https://github.com/LF-Certification/copier-compute-environment)
    - LF-Certification/copier-multi-vm-shim
    - LF-Certification/copier-product
  - You have [setup your environment](setup-and-configure-your-environment.md) and with required tools.

## Create a feature branch from main
open your devcontainer

Create a feature branch from main to work on the compute environment.

!!!warning
    must be named `feature/implement-<compute-environment>`


```bash
git branch feature/implement-LFS2580004
```

switch to your branch

```bash
git checkout feature/implement-LFS2580004
```


cd to `compute-environments/available`


### Render the copier-multi-vm-shim template

!!!warning
    Before rendering copier templates, ensure your git repository is clean.

The `copier-multi-vm-shim` creates the base compute environment directory for the lab. it allows building, packing and publishing to be executed simultaneously on all virtual machine hosts needed in the lab

!!!note
    TODO explain the front end service
    explain that the lf-training one has ssh keys
    explain the default port


```bash
copier copy --trust "gh:LF-Certification/copier-multi-vm-shim" ./LFS2580004
🎤 What is the prefix for the compute environments?
   LFS2580004
🎤 What is the image for the front end service?
   ghcr.io/lftraining/ttyd:1.7.7
🎤 What is the port for the front end service?
   7681

Copying from template version 1.4.0
    create  .make
    create  .make/lab
    create  .make/lab/build
    create  .make/lab/clean
    create  .make/lab/package
    create  .make/lab/publish
    create  .make/lib.sh
    create  Makefile
    create  .copier-answers.yml

```

Commit the changes to the repository

```bash
git add ./LFS2580004/ && git commit -sm"feat(LFS2580004): Initalize copier-multi-vm-shim"
```


### Render the virtual machine directories required for hosts within the lab compute-environment

LFS2580004 Will require 2 VMs in the lab compute environment.

cd into the newly created directory:

```bash
cd ./LFS2580004
```

Apply the copier-compute-environment template for each host in the lab compute environment. We will start with `host1`

!!!note
    only `host<N>` are allowed as host names


```bash
copier copy --trust "gh:LF-Certification/copier-compute-environment" LFS2580004-host1
🎤 What is the name of the compute environment?
   LFS2580004-host1
🎤 Which base image does the compute environment use?
   ubuntu/kubernetes
🎤 How many CPU cores does the item require?
   2
🎤 How much memory does the compute environment require?
   4096M
🎤 How much storage (MiB) does the compute environment require for the user layer?
   300
🎤 How much storage (GiB) does the compute environment require for the build layer?
   5
🎤 Does the compute environment require swap?
   No
🎤 List of ports to expose?
    (Finish with 'Alt+Enter' or 'Esc then Enter')
> [22]
🎤 How are the scripts implemented?
   bashp

Copying from template version 1.2.2
    create  .hooks
    create  .hooks/lab
    create  .hooks/lab/post-build.sh
    create  .hooks/lab/pre-image.sh
    create  .hooks/p3
    create  .hooks/p3/post-build.sh
    create  .hooks/p3/pre-image.sh
    create  .hooks/temu
    create  .hooks/temu/pre-image.sh
    create  .hooks/post-clean.sh
    create  .make
    create  .make/jslinux
    create  .make/jslinux/build
    create  .make/jslinux/image
    create  .make/jslinux/package
    create  .make/jslinux/publish
    create  .make/jslinux/run
    create  .make/jslinux/test
    create  .make/lab
    create  .make/lab/build
    create  .make/lab/image
    create  .make/lab/package
    create  .make/lab/publish
    create  .make/lab/run
    create  .make/lab/test
    create  .make/lib.sh
    create  .make/p3
    create  .make/p3/Dockerfile
    create  .make/p3/build
    create  .make/p3/image
    create  .make/p3/k8s
    create  .make/p3/k8s/ssh
    create  .make/p3/k8s/ssh/id_rsa
    create  .make/p3/k8s/ssh/id_rsa.pub
    create  .make/p3/package
    create  .make/p3/publish
    create  .make/p3/run
    create  .make/p3/test
    create  .make/qemu
    create  .make/qemu/build
    create  .make/qemu/cloud-init
    create  .make/qemu/cloud-init/meta-data
    create  .make/qemu/cloud-init/user-data
    create  .make/qemu/image
    create  .make/qemu/package
    create  .make/qemu/publish
    create  .make/qemu/run
    create  .make/qemu/test
    create  .make/qemu/lib.sh
    create  .make/qti
    create  .make/qti/build
    create  .make/qti/image
    create  .make/qti/lib.sh
    create  .make/qti/package
    create  .make/qti/publish
    create  .make/temu
    create  .make/temu/build
    create  .make/temu/image
    create  .make/temu/lib.sh
    create  .make/temu/package
    create  .make/temu/publish
    create  .make/temu/run
    create  .make/temu/test
    create  Dockerfile
    create  Makefile
    create  assets
    create  assets/format-candidate-layer.sh
    create  assets/mkfs-hook.sh
    create  cli.sh
    create  k8s
    create  k8s/base
    create  k8s/base/kustomization.yaml
    create  k8s/base/virtualized-env.yaml
    create  k8s/base/manifest.yaml
    create  scripts
    create  scripts/answer.sh
    create  scripts/build.sh
    create  scripts/score.sh
    create  scripts/setup.sh
    create  temu
    create  temu/.gitattributes
    create  temu/.gitignore
    create  temu/temu.cfg
    create  temu/bbl64.bin
    create  temu/kernel-riscv64-4.19.249-minimal.bin
    create  temu/initrd
    create  .envrc
    create  .copier-answers.yml
```


Now that you have created the first virtual machine directory, commit your changes before rendering the second virtual machine directory.

```bash
git add ./LFS2580004-host1/ && git commit -sm"feat(host1): Initalize copier-compute-environment"
```
