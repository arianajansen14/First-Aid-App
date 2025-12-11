# Pull Requests How to Use Them

This guide explains how to create, review, and merge Pull Requests (PRs) for the project.

---

## 1. What is a Pull Request?

A Pull Request (PR) is how you:

- Submit your work for review  
- Compare your branch to `main`  
- Merge your work safely  
- Avoid breaking the project  

You NEVER merge directly into `main`.  
You always use a Pull Request.

---

## 2. Before you create a PR

Make sure you:

1. Are on your own branch  !!!
2. Saved all changes in Xcode  
3. Added and committed your work  
4. Pushed your branch to GitHub  

Example:

git add .
git commit -m "added new UI"
git push

If you don’t push, GitHub won’t see your changes.

---

## 3. How to open a Pull Request

### Step 1 — Go to your branch on GitHub  
Use the branch selector at the top left.  
Choose your branch (example: `feature/ariana/new-ui`).

### Step 2 — Click “Compare & Pull Request”  
A yellow banner appears when GitHub detects a new branch.  
Click it.

### Step 3 — Fill in the Pull Request form  
- **Title:** short description (example: “New training menu UI”)  
- **Description:** explain what you changed  
- **Base branch:** must be `main`  
- **Compare branch:** your branch  

Then click:

**Create Pull Request**

Your PR is now open.

---

## 4. What happens after you open a PR

Your collaborators (us :P) can:

- Read your description  
- View all changed files  
- Comment on code  
- Request updates  
- Approve the work  
- Merge it into main  

This protects the project from bugs and unfinished work.

---

## 5. How to merge a Pull Request

When your PR is approved:

1. Click **Merge Pull Request**  
2. Click **Confirm Merge**  

Your branch is now part of `main`.

---

## 6. After merging: delete your branch

Click:

**Delete Branch**

Why?

- The work is already in `main`  
- The branch will not be updated anymore  
- Keeping old branches creates clutter  

Deleting the branch does NOT delete any of your work.

---

## 7. Update your local main after a merge

On your computer:

git checkout main  
git pull

This gives you the latest version of the project.

---

## 8. If your Pull Request has conflicts

Conflicts happen when two people edit the same lines.

GitHub will show something like:

<<<<<<< HEAD
your version
=======
their version
>>>>>>> other-branch

To fix the conflict:

1. Choose which version to keep  
2. Remove the conflict markers  
3. Save the file  
4. Commit and push:

git add .
git commit -m "resolved merge conflict"
git push

GitHub will update the PR automatically.

---

## 9. Quick PR workflow

1. Create a branch  
2. Edit code in Xcode  
3. git add .  
4. git commit -m "message"  
5. git push  
6. Open Pull Request on GitHub  
7. Review + merge  
8. Delete branch  
9. git pull (update main)

---

## 10. Common commands

Create a branch:
git checkout -b feature/name

Commit changes:
git add .
git commit -m "message"

Push branch:
git push -u origin feature/name

Switch back to main:
git checkout main
git pull

---

Pull Requests keep the project safe, organised, and easy to collaborate on :3
