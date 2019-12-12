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

#### updates milestone 4:

- Did not enforce modularization of code for our R app, as we didn’t have much time to look over and re-factor the code.

- Switched order of box plots to be chronological and gave box plots more meaningful labels in the R version of our app (didn’t have time to re-wrangle the data to implement this in our Python app, so we addressed that feedback this time around).

- We received feedback that a good feature could be to add selection by country of origin and we agree that this is a good potential future improvement to our app. We did not address it for this project as it would require finding additional data sources (our data source did not contain country of origin data) which was out of the scope of this project.

- Made updates to a few interactive features based on feedback received on our Python app, narrowed down the number of radio buttons on tab one and switched from a drop down to radio buttons on tab two.

- We noticed that the font size of the y-axis labels (airline names) in our bar chart was maybe a bit too large to see them all properly, this is a small visual element that could be improved upon (we looked into it and saw it required changing the theme and didn’t have the time to address it). 

- TA feedback suggested focusing on practicing interactivity, we found it a little difficult to fine tune certain interactive elements as switching from default values was less intuitive and not always supported in dashR (did not support bootstrap components, for example).

- Based on peer and TA feedback on our Python app, we added in descriptions of our plots and information on what data is being shown, included note to encourage users to hover over plots to utilize interactive elements and added sources for data and classification of First World countries.

- We think we did a good job of continuing to use issues and pull requests to streamline our group processes. We recognize that some of us didn’t always include meaningful commit messages or communicate effectively over GitHub - this is something we all agree we need to continue to improve on for future group work.

- Overall, we feel our app fulfilled our proposal 100%. It showed the intended plots of total fatality rates by airline, as well as boxplots of different variables by time period effectively. We did a good job addressing and implementing both peer and TA feedback when going from our Python app to our R app, however, due to the timeline and scope of this app, there are a few things we did not get around to polishing and some small aesthetic improvements that could be made.
