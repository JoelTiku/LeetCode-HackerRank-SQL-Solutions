# LeetCode HackerRank Q&A

## SQL Coding Questions and Answers

### Running this Project Locally

### Using Command Line:

### Check Git Version

 

To check the version of Git installed on your system, use the following command:

 

*Note the following commands are provided for Windows environments.

Please use the Windows Command Prompt or PowerShell to run the following commands:*

 

```sh

C:\ git --version

```

 

### Clone the Repository

 

To clone this repository to your local machine, use the following command:

 

```sh

C:\ git clone <repo url>

```

 

### Change Directory to the Repository

 

Navigate to the cloned repository directory using the `cd` command:

 

```sh

C:\ cd <repo-name>

```

 

### Switch to the Main Branch and Pull Latest Changes

 

Ensure you are on the `main` branch and have the latest changes by running:

 

```sh

C:\ git checkout main

C:\ git pull

```

 

### Create and Switch New Branch

 

To create a new branch, use the following command. Replace `<new branch name>` with the desired branch name (e.g., `developer/joel`)

```sh

C:\ git checkout -b <new branch name>

```

 

### Stage Changes

 

Add your changes to the staging area using the following command:

 

```sh

C:\ git add .   or   git add README.md


```

 

### Commit Your Changes

 

Commit your local changes to the new branch. Use the following commands to add and commit your changes.

 

```sh

C:\ git commit -m "Your descriptive commit message"

                OR

C:\ git commit -m "message" --no-gpg-sign
```

 

### Push the New Branch to the Remote Repository

 

Push the new branch to the remote repository on GitHub/Azure DevOps:

 

```sh

C:\ git push origin <new-branch-name>

        OR

C:\ git push origin main
```

 

### Cleanup (Optional)

 

If you no longer need the feature branch locally, you can delete it after it's merged:

 

```sh

C:\ git branch -d <new-branch-name>

```

### Aggregate Function

- [Countries You Can Safely Invest In.sql](https://github.com/JoelTiku/LeetCode-HackerRank-SQL-Solutions/blob/main/LeetCode/SQL/Aggregate%20Function/Countries%20You%20Can%20Safely%20Invest%20In.sql)








### Amazon BIE Coding Challenges

- [SumUptoCurrentRow.sql](https://github.com/JoelTiku/LeetCode-HackerRank-SQL-Solutions/blob/main/Companies/Amazon/Generating%20a%20Cumulative%20Salary%20Table%20Using%20Only%20DML%20Operations%20in%20SQL.sql)
