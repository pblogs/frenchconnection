![CircleCi](https://circleci.com/gh/stabenfeldt/alliero-orwapp.png?circle-token=33b26842e62a1537d5582f72c7c718eea9a5bfc6)
## Alliero.orwapp.com

This app is used to keep track of `HoursSpent`.
Project leaders [1] create projects. A `Project` consist of one or more `Tasks`.
Each task can be delegated to one or more workers [2]. These workers report `HoursSpent` on the tasks they are given.
Reports are created by `ExcelController`. It's not really Excel files, but HTML pages transformed to PDF with PDFKit.
These reports are used by our customer to generate invoices.




[1] Users with 'project_leader' role.

[2] Users with 'worker' role.
## Style Guide
Please follow our Style Guide: https://github.com/stabenfeldt/alliero-orwapp/wiki/Style-guide
