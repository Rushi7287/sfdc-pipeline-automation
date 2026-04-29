🚀 SFDC CI/CD Workflow & Testing
📌 Overview

This repository demonstrates a Salesforce CI/CD pipeline implementation using GitHub Actions.
It includes automated and manual workflows for deployment, testing, and backup strategies.

⚙️ Workflows Included
🔹 Auto Run with Full Backup

File: auto_run_with_full_backup.yml

Runs automatically on code push
Executes deployment
Takes full metadata backup
Ensures safe rollback capability
🔹 Auto Run without Test Class

File: auto_run_without_test_class.yml

Runs automatically
Deploys without executing test classes
Useful for quick deployments (non-production)
🔹 Manual Run with Package Backup

File: manual_run_with_package_backup.yml

Triggered manually
Deploys selected metadata using package.xml
Takes backup before deployment
🔹 Manual Run with Test Class

File: manual_run_with_test_class.yml

Triggered manually
Runs Apex test classes
Ensures deployment validation

🛠️ Tech Stack
Salesforce (SFDC)
GitHub Actions
Apex
Metadata API
SFDX CLI
🔐 Required Secrets

Configure the following GitHub Secrets :
SFDX_INTEGRATION_URL 
how to get that : Auth an Org in VS code => sf org display --verbose => Sfdx Auth Url

📂 Project Structure
.github/
  workflows/
    auto_run_with_full_backup.yml
    auto_run_without_test_class.yml
    manual_run_with_package_backup.yml
    manual_run_with_test_class.yml

🚀 How It Works
Push code to repository → triggers auto workflows
Manual workflows can be triggered via GitHub Actions UI
Deployment is executed using SFDX CLI
Backup ensures recovery in case of failure

🎯 Use Cases
CI/CD pipeline setup for Salesforce
Automated deployments
Backup and recovery strategies
Testing integration in deployment lifecycle

📌 Best Practices Followed
Separation of auto & manual workflows
Backup before deployment
Controlled test execution
Modular pipeline design

🔥 Future Enhancements
Add scratch org validation
Add static code analysis (PMD)
Add multi-org deployment
Integrate approval-based deployments

🙌 Note : 
This repository is designed as a learning to demonstrate real-world Salesforce DevOps practices.