# Create issues form
Purpose: customize the templates that are available for contributors to use when they open new issues in the repository.


**Create form for issues/bug report**
* Create .github/ISSUE_TEMPLATE/bug.yml file in your repository with the following content:<br />


```
name: 🐞 Bug Report
description: File a bug/issue
title: "[Bug]: <title>"
labels: ["bug", "triage"]
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking that time to report this issue! Your contribution helps us build great stuff.
  - type: textarea
    id: current-behavior
    attributes:
      label: Current Behavior
      description: Tell us what went wrong.
      placeholder: A clear and concise description of what the bug is. Add screenshots to help explain your problem.
    validations:
      required: true
  - type: textarea
    id: expected-behavior
    attributes:
      label: Expected Behavior
      description: Tell us what should've happened.
      placeholder: A clear and concise description of what you expected to happen. Add screenshots to help explain your problem.
    validations:
      required: true
  - type: textarea
    id: additional-context
    attributes:
      label: Additional Context
      description: Add any other context about the problem here.
  - type: textarea
    id: logs
    attributes:
      label: Relevant log or code
      description: Copy and paste any relevant log output or commands. This will be automatically formatted into code, so no need for backticks.
      render: shell
```

**Test it out**
* Under your repository name, click 'Issue' tab
* Click 'New issue' bottom
* Test #1; you should see a nice dialogue window showing your newly create '🐞 Bug Report' form. 
* Test #2; click 'Get started' on your new form, you'll see a nice GUI form for submitting issues. 
