# HOW TO Work Locally

This guide shows you how to work on labs locally before testing manually in the staging cluster.

## Overview

Working locally allows you to test your changes before pushing them to the staging cluster. This allows for faster iteration and easier debugging. It does NOT replace manually testing in the staging cluster.

## Prerequisites

- Basic knowledge of shell scripting
- Understanding of the lab platform structure
- Familiarity with Kubernetes concepts (for Kubernetes-specific labs)

## Spinning Up the Environment

### 1. Inside the Lab Item Directory
For example, if you are working on the lab 3.1 item for LFS258:
```bash
cd compute-environments/available/LFS2580003.1/
```

To build the entire lab environment run:
```bash
make shell
```

This will open a tmux session with a pane for each VM. To switch panes you must press `Ctrl+B`, let go, and tap the arrow key that corresponds to the pane you want to switch to.

### 2. VM Structure

 Inside each VM, the VM directory is mounted in /item. Whatever you edit in your VM inside the /item directory will also update the repositroy. /item should be the directory that you are in when you run `make shell`.
 You can edit setup.sh by running:
 ```bash
 vim /item/scripts/setup.sh
 ```

To test your changes, run:
```bash
./scripts/setup.sh
```
When you are done developing, exit out of each VM by running:
```bash
exit
```
### 3. Cleaning Up
Run:
```bash
make clean
```
This will remove the VMs and clean up.