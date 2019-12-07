### Group Reflection - Milestone 2

- Overall, our app fulfilled our proposal 100%, and it shows the intended plots of total fatality rates by airline, as well as boxplots of fatalities by time period effectively.
- However, there wasn't enough time to polish up the rough edges in terms of x-axis labeling, or overall aesthetics.
- If we were to continue development of this application in the future, we can definitely include more complex features, like looking at individual airline's incident rates, or comparing specific airline's incident rates, in addition to improving the look of the app.
- In regards to the TA’s comments, next time any of us are putting together a teamwork contract, we will be sure to specify roles and responsibilities of each team member and outline the process for how tasks will be divided among team members.
- Hopefully our deployed app addresses any confusion on what the user has the ability to select on the first tab. The user can select to show either First World countries, Non-First World countries or both at the same time using a radio button and the histogram bar colours will change depending on the selection.
- We really made an effort while working on Milestone 2 to streamline our issue and pull request process and will continue to include meaningful comments to ensure effective communication over GitHub.
- During our first meeting, we agreed on dividing the task into modules, but since most of our teammates are not so familiar with modularizing. We were a bit confused when implementing our own modules. For the next project, we will still modularize the task, but we will make sure that we all understand the task completely.
- Modularizing really helps to make our code organized and easy to read. If the reader is interested in a specific part of the code, he could just look up the corresponding modules.
- Modularizing also made the code less prone to error. Before modularizing, we may have one long file that contains multiple errors, it is frustrating and daunting to fix them all. However, after modularizing, there would only be errors in each individual module, it would be much easier to solve. When we put all the modules together, we can be sure that modules we put together are error-free, and if we find errors in the main file, we can be sure it is from the main file.
- Every meeting in our team was very effective. One team member drew diagrams to demonstrate the task and ensured everyone understood, this method was very efficient because we could avoid explaining things back and forth.

#### updates:

- We had multiple peers give feedback that the order of the boxplots on the second tab should be chronological (time period from 1985-1999 before 2000-2014). As this required relabeling data columns, we have decided that we will address it when we create our plots in ggplot.

- Overall, there wasn’t much in terms of application-breaking bugs, mostly suggestions and minor typos. We addressed those in our Python Dash app relatively quickly.

- In terms of codebase refactoring, we didn’t have to do much, as we enforced code modularization from the beginning of development, and most if not all code were already PEP-8 compliant.

- We also addressed most of the TA’s feedback, as they mostly overlapped with the feedback received during peer review. The one exception was to cite the data; we have done this.

- The few pieces of feedback we were not able to address from the TA was the suggestions regarding selection by country. While this would be a really good feature, the data we chose does not contain any data. We could individually lookup the country of origin for each airline, but that would require additional data sources, and would be out of scope for this application.

