![CircleCi](https://circleci.com/gh/stabenfeldt/alliero-orwapp.png?circle-token=33b26842e62a1537d5582f72c7c718eea9a5bfc6)
## Alliero.orwapp.com

This app is used to keep track of `HoursSpent`.
Project leaders [1] create projects. A `Project` consist of one or more `Tasks`.
Each task can be delegated to one or more workers [2]. These workers report `HoursSpent` on the tasks they are given.
Reports are created by `ExcelController`. It's not really Excel files, but HTML pages transformed to PDF with PDFKit.
These reports are used by our customer to generate invoices.

[1] Users with 'project_leader' role.
[2] Users with 'worker' role.

## Workflow for developers

  1. Pick an open issue you want to implement or I delegate a task to you because I think you're the best suited to fix it. :-)
  2. Create a comment where you estimate how many hours you think it will take and when you can have it ready.
  3. Start working when we have accepted the estimated time.
  4. Do not start working on anything that has our approval. That goes for time and the feature itself. Don't start implementing things you think are needed if they are not requested explicitly.
  4. Write integration tests.
  5. Submit a pull request when you're ready. We'll review and accept it when it looks good.
     Attach image or video. See the section below.

## Videos and screenshots are required on PR that changes the UI
When creating or changing something in the view, please make a quick video of 
how it works from a user's perspective. A screenshot can be sufficient if the change is to a static page that does contain any interaction.
A good example could be CSV import of users from an Excel file. Record that you start with Excel, let us see the syntax. Export as CSV, import to the app and visit users/index.

This is how you make a recording in QuickTime Player for Mac:
File, New Screen Recording.

Save the video to "$RAILS_ROOT/feature-videos/#{pull_request_id}-#{description}.mov"
.mov is just an example, use a format that most people can open.



## Style Guide
Please follow our [Style Guide](https://github.com/stabenfeldt/alliero-orwapp/wiki/Style-guide)

## The Orwapp cloud

![The architecture](http://www.gliffy.com/go/publish/image/6487189/L.png)
