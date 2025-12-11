# Branching Strategy for First-Aid-App

This guide explains how we work with branches so multiple people can edit the project without breaking the main version.
; works i hope
---

# 1. What is a branch?

A branch is a **copy** of the project at a specific moment.

- You create a branch from `main`
- You edit your own copy safely
- The main branch stays stable
- When your work is ready, you merge it back

Branches prevent people from overwriting each other’s changes.

---

# 2. Branch naming

Use this format:

feature/your-name/short-description  
bugfix/your-name/short-description  
experiment/your-name/short-description

Examples:

feature/ariana/new-ui  
feature/dajia/training-system  
bugfix/ariana/camera-freeze  
experiment/alexa/aid-logic

---

# 3. Creating a branch

Always start from the latest main:

git checkout main  
git pull  

Then create your branch:

git checkout -b feature/your-branch-name

Now you are working on your own copy.

---

# 4. Editing your branch

Make changes in Xcode. Save.

Then commit your work:

git add .  
git commit -m "describe what you changed"

Push your branch to GitHub:

git push -u origin feature/your-branch-name

---

# 5. Opening a Pull Request (PR)

When your branch is ready:

1. Go to GitHub  
2. Select your branch  
3. Click **Compare & Pull Request**  
4. Add a short description  
5. Assign it for review  
6. Click **Create PR**

When approved, the branch gets merged into `main`.

---

# 6. Merge conflicts (if both people edit the same code)

A conflict looks like this:

<<<<<<< HEAD  
your version  
=======  
their version  
>>>>>>> commit-hash

Fix it by:

1. Keeping the correct lines  
2. Deleting the conflict markers  
3. Then commit:

git add .  
git commit -m "resolved merge conflict"  
git push  

This is normal.

---

# 7. Keeping your branch updated with main

If someone else updates main while you’re working:

git checkout main  
git pull  
git checkout your-branch  
git merge main  

Fix conflicts if needed → save → commit → push.

This avoids big conflicts later.

---

# 8. Finishing a branch

After it’s merged into main:

Delete on GitHub  
Delete locally:

git branch -d your-branch-name

This keeps things clean.

(Main = the full timeline
Branch = a temporary workspace)

---

# 9. Summary

✔ `main` = stable version  
✔ New work happens in feature branches  
✔ You edit the copy, not main  
✔ Push branch → open PR → merge  
✔ Keep your branch updated  
✔ Delete it after merging  
