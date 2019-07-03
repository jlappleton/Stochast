[![Build Status](https://travis-ci.com/jlappleton/Stochast.svg?branch=master)](https://travis-ci.com/jlappleton/Stochast-Front-End)   [![codecov](https://codecov.io/gh/jlappleton/Stochast/branch/master/graph/badge.svg)](https://codecov.io/gh/jlappleton/Stochast-Front-End)    [![CodeFactor](https://www.codefactor.io/repository/github/jlappleton/stochast-front-end/badge)](https://www.codefactor.io/repository/github/jlappleton/stochast-front-end)
***

# Stochast

Stock Forecasting Web Application

```
CST 499: Computer Science Capstone
Joseph Appleton
June 18, 2019
```

## Executive Summary

The goal of this project was to create a web application using Ruby and Rails. The purpose of

this web application is to generate and provide stock forecasts for users. The forecasts will be

free and only require the user answer a multiple choice question. This multiple choice question

will ask the user a simple question about an excerpt or summary from a larger text such as a

news article. The answers submitted by users will be used as data for training future models in

hopes of increasing the accuracy. The web application will use AWS services for hosting, data

storage and inference.

Data for training as well as trained models are served and stored using Simple Storage

Service(S3). Models are trained and deployed using SageMaker and Amazon’s DeepAR

time-series forecasting algorithm. Time-series financial data, relevant news, and other data about

stocks are gathered from IEXCloud. This data is used for training models, requesting inferences,

displaying charts and news, and creating tasks. The Ruby on Rails web application is deployed

on Elastic Beanstalk using an application load balancer which serves the application from up to

four servers, scaling up and down according to demand. The database for the application is

hosted on Relation Database Service(RDS) as a dedicated database server using MySQL.

The application was developed using the Agile methodology for its flexibility as well as its

coding standards and testing requirements that encourage well written and well tested code.

Features written in feature branches and all tests were run using automated continuous

integration tools on every push to GitHub. Automated code reviews are also performed in

addition to the generation of a code coverage report that details the percentage of untested code

and where it can be found.


## Table of Contents

- Part One
   - Introduction
   - Project Goals and Objectives
   - Stakeholders and Community
   - Feasibility Discussion
- Part Two
   - Functional Decomposition
   - Selection of Design Criterion
   - Final Deliverables
   - Approach and Methodology
   - Ethical Considerations
   - Legal Considerations
- Part Three
   - Timeline
   - Resources and Budget
   - Usability Testing and Evaluation
   - Final Implementation
   - Discussion
   - Conclusion
- References


## Part One

### Introduction

The name of the project is Stochast. It is a web based application that supplies stock forecasts. It

is designed as a Software as a Service application, so the user will only need access to a modern

web browser. Machine Learning and statistical methods are used to inform securities trading

strategies around the world however, access to those tools and technologies is not readily

available for the average investor.

The product is a web application that forecasts stock prices and movement in exchange for

human assistance with labeling data. The main interface is a simple listing of stocks. Selecting a

stock will open that stock’s page. A stock’s page will contain historical data, news, and forecast

data. The forecast data will include numerical and charted predictions for the next five days

closing prices.

Use of the application will not require the user to be logged in. Recently generated forecast

content for any stock will be gated with a data labeling task. When the response to the data

labeling task has been submitted the content will be released to the user, an additional task must

be completed for fresh prediction. While forecast data for future times will be gated, stale

forecast data will be freely available for all stocks. The user of this web application will benefit

by receiving forecast data without a cost and the application owner will benefit by receiving

human labeled data to improve the forecasting model. It is important that the advantages

available to the wealthy few can be distributed and used by anyone.


### Project Goals and Objectives

The structure of this project is a set of services that work in concert to provide data and

predictions for traded securities. The project will be split into a Ruby on Rails web application, a

MySQL database, an S3 data storage bucket, and a SageMaker inference endpoint. The goals of

the project are to manage the data required for predictions, create and store questions, train and

deploy a machine learning model for stock predictions, and to implement a front end to display

the results. These goals and their objectives can be found in the following list.

```
● Collect data from an external API
```
```
○ Access and pull in data from IEXCloud
```
```
■ Limit the amount of duplicate requests for data to lower overall cost of
```
```
ownership for the application
```
```
■ Store and transform data using Amazon Web Services(AWS) resources
```
```
● A SageMaker Jupyter notebook to explore data from IEXCloud
```
```
● Functions to transform data into JSON Lines format and place it in
```
```
the S3 bucket for model training
```
```
● Create and store questions
```
```
○ Connect to IEXCloud and retrieve news data about stocks covered by the
```
```
application
```
```
○ Convert the news data into a Rails model
```
```
○ Insert model into the Rails MySQL database
```
```
○ Implement a way to poll users using the stored models
```
```
■ Store poll responses in the same model
```

```
● Training and deployment of a deep learning model
```
```
○ With a SageMaker Jupyter notebook create a JSON Lines formatted collection of
```
```
data using the JSON Lines files and invoke a training job using the AWS
```
```
SageMaker API
```
```
○ Upon successful training of the model and using the Sagemaker API, create a
```
```
deep learning model from the results of training
```
```
○ Deploy the new model by creating an endpoint for inference
```
```
● Implement interface to request and view the results of inferences made by the model
```
```
○ View all currently predicted for stocks
```
```
○ View and respond to data labeling tasks
```
```
○ Access to predictions after respond to a data labeling task
```
```
■ Chart of the predicted ranges
```
```
■ Table of predicted prices
```
```
○ View relevant news
```
### Stakeholders and Community

This project will provide the internet community with forecasting data for stocks they may be

interested in investing in. The benefit to the community is the extra data point that can be used to

inform investing strategies. The stakeholder of this project would be the owner of the servers and

runner of the service. In exchange for running the service, the users would submit data to help

the predictions become more accurate. If the stakeholder is also an investor this would be

beneficial for both the community of users and the stakeholder as better models will yield more

accurate predictions.


The end user for this web-based application is someone who has internet access but would

consider paying a monthly charge or giving an email as too high a cost. Subscription costs or

tiered payment plans are common with access to market data and the costs can be very high, the

cost of a Bloomberg terminal is famously high for access to their financial data and the use of

their hardware. If access to information is gated with such a large amount of money it will deter

people with less money and less expensive services suffer from skeptics wary of fraud and the

true value of the information. If access to the information is tied to an email account, then the

end user risks having their email sold to spammers or scammers.

The end user would also have an interest in investing and an interest in developing their own

investment strategies. The user of this web application would not be looking to be told which

stock to buy or a list of stocks expected to go up. They would look for confirmation of their own

independent research or as an additional data point and would like a free forecasting service to

provide it.

### Feasibility Discussion

Similar solutions exist and can be found on the internet and the Play Store. The Cable News

Network(CNN, 2019) offers a free 12-month price forecast that is the estimate of several

analysts along with news, historical data, and information about the security. All this information

is free, but the site only has a 12-month prediction. The solution implemented will provide a

shorter term forecast as well as news and historical data. While a team of professional analysts is

not available to directly provide analysis to inform the predictions generated, IEXCloud provides

a rich source of data including social sentiment, intraday and historical prices, as well as

additional information such as financials and news.


Another similar actor in this space is I Know First Stock Forecast (IKF, 2019) which delivers a

“stock forecasts based on a predictive algorithm”. I was unable to find any predictions on their

site and was directed to give my email for predictive services with the caveat that “algorithmic

signals are sold separately”(IKF, 2019). Another, Market Sensei, offers a web app in addition to

their iOS and Android applications. The forecasts are generated from the individual forecasts of

the user base and there is a monthly cost of $19.95 to $49.95 (Stock Market Sensei, 2019). The

solution implemented does not require an email or membership, nor does it charge money for

access to forecasts. With the exception of the administration page the entire application is

accessible to users with the forecast information only gated by a simple multiple choice question.

Wallet Investor (WalletInvestor.com, 2019) is another site that offers to forecast for securities,

though the focus of the site is cryptocurrency forecast prices for individual stocks are offered

from 14 days to 5 years. A 7 day exclusive forecast is available, but email is required. The

solution as implemented will not require account registration, will not charge for forecasts, and

will not require an email. Instead, it utilizes the human compute power of a user to help prepare

data in order to create more accurate predictions. While some of the above solutions use the

work of analysts or user-generated predictions the proposed solution will use linear modeling

and a neural network. Both CNN and Wallet Investor do not focus on forecasting securities,

while Market Sensei and I Know First do focus on their forecasting, there is an associated cost

for the services they provide.


## Part Two

### Functional Decomposition

The final application will consist of four distinct pieces. The first being the Front End

application. It is a Ruby on Rails web application with a MySQL database, an S3 data storage

bucket, and SageMaker resources. The front end Rails application connects with the external API

to request data that it then formats into a JSON Lines inference request object to send to the

SageMaker endpoint. The endpoint responds with a JSON object that includes the results of five

days of forecasts in quantiles 0.1 - 0.9. The forecast data is then combined with a one month

chart to display a chart of where the deep learning model predicts the closing price of the stock

might go. When a stock is clicked on or selected from the dropdown menu a check is performed

to ensure a data labeling task is available. If it is not, or according to a 51% chance that it will

happen, news data from the external API is gathered and used to create new tasks.


### Selection of Design Criterion

The Rails Application is deployed using AWS Elastic Beanstalk in order to take advantage of the

automatic configuration of an Application Load Balancer which handles user requests and routes

them to the application, spreading requests out among up to three additional servers as demand

dictates. This configuration allows high availability with lower costs when the additional

resources are not needed. The Rails Application uses a MySQL database also hosted by AWS.

Using Amazon’s Relational Database Service a monitored and highly available database is

configurable with the option to scale the capacity and replicate the data across zones. It is also

accessible from a local computer using MySQL Workbench for better administration of the

database.

An Amazon S3 bucket is used for scalable and durable storage that provides a high availability

place to store data used to make inferences and train machine learning models. From S3 events

can be logged and sent to a monitoring console for free using the SNS to send and carry the

appropriate data. Another benefit to using S3 is that as files are uploaded on S3, SNS messages

can be sent to multiple consoles or even a Slack channel so that monitoring an application can be

relatively hands free.

SageMaker is being used for an API that allows the creation and training of a model as well as

deploying an endpoint so that inferences can be requested and delivered using the newly created

model. For training, jobs can be created that uses appropriate and affordable infrastructure to

train and tune multiple models simultaneously and returning one or more of the best performing

models. Different parameters and error functions can be chosen for the tuning process and the

resultant models, as many as five, can be deployed simultaneously for the same endpoint and


traffic to that endpoint can be spread between the models evenly or per model. Using SageMaker

also gives access to the machine learning algorithms provided by Amazon. This application uses

the DeepAR forecasting algorithm. The advantage to using the DeepAR algorithm is that it trains

on one or more time series, the series that are going to be forecasted for can all be trained and

forecasted on the same model. This reduces the number of models required for inference.

### Final Deliverables

The final product of The Project is a web application available at https://jltav.com. The

application is secured with SSL and hosted using AWS. The Front End of the application has a

main page that displays stocks available for prediction, a second page that dynamically updates

to display prediction data and stock information. The front end also has an administration page

that allows the application owner to change the stocks available and manually trigger the services

that support the application as well as view prediction and stock data in tabular format.

The data required for inferences is pulled from IEXCloud in six month increments. The data is

transformed and stored in JSON Lines format for when it needs to be used to perform additional

training. The Prediction Service generates predictions for the stocks whose data are sent, it is not

required that the model was trained with the stock it is predicting prices for. News data will be

stored and a task for each news data will be created and stored in the database. This task will be

displayed to the user whenever any particular stock page is loaded.

When the user selects a stock from the main page, or changes the chosen stock from the

prediction page, the prediction page will be loaded with historical data and a task from the task

database will be loaded in place of the prediction data. The task will be a short amount of text

and a multiple choice question. Once the user submits an answer the prediction database will be


queried and the data loaded and displayed for the user. The submitted answer to the task will

update the database entry for that task.

### Approach and Methodology

An Agile approach and Behavior Driven Design has been used to develop the services that make

up this project. Development cycles were executed in two 2-day sprints and one 3-day sprint

each seven-day period. The beginning of each sprint was a refinement of the current user story,

generation of documentation, and implementation of unit and functional tests. The remainder of

the sprint was the implementation of the user story feature. All implementations will adhere to

commenting standards to allow for the use of available documentation tools and style standards

will be defined and followed. In addition to adhering to BDD for test implementation, Test

Driven Development drove the implementation of the services with the goal of high code

coverage.

Metrics were used to gauge the test coverage and complexity of the code; Cyclomatic

Complexity was used to help determine functions that are too complex and approximate the

necessary number of tests and Codecov was used to examine and report code coverage on the

repositories. Git was used for version control and GitHub was chosen to host the repository. The

primary strategy was to create and work on feature branches that were then pulled into the master

branch. Commits were made as frequently as possible, covered reasonable amounts of change

and include useful commit messages.

The project is structured using Service Oriented Architecture with each major subsystem

consisting of an independent service that can be queried for data or set to work in a stateless

manner. HTTP requests identify requested resources and all data will be transferred and stored as


JSON Lines objects. The approach to completing the project was to build the back-end services

after implementing a mock front end, starting with the data service and the question service.

With the data available for request, the prediction service and machine learning model was

created and fed the question results and stored data. Endpoints were then created for requesting

model inferences. To complete the project, the front-end web application was further refined for

ease of use, appearance, and to accommodate design changes during earlier implementation of

the supporting back end services.

### Ethical Considerations

The web application implemented is not a game, does not have points, and is not designed with

the intention of encouraging any behavior. There is no benefit or penalty for responding to a task

other than unlocking the gated prediction data for user review. The application is designed as a

simple tool that provides prediction data in exchange for data munging services via the tasks.

Though not designed to create or attract gambling addicts some may end up using the

application.

Although investing and gambling are not the same thing both involve speculation on a future that

is not certain. Just as it is possible to gamble responsibly it is possible to invest irresponsibly.

Irresponsible investment can lead to harmful outcomes. If a user is willing to take greater

amounts of risk and take short positions based on incorrect predictions that a stock will go down,

there is no limit to the amount of money it is possible to lose. With the current volatility of the

market problematic behavior such as borrowing to finance an investment or committing crimes

to facilitate investing can be especially damaging. The group most negatively impacted by this


project would be poor people who are not risk-averse. Investment can be seen as a way to make

money to solve immediate financial problems.

To mitigate the possibility of abetting irresponsible investors the application implements a flash

message that appears periodically with links to various organizations that help those with

gambling problems. Gamblers Anonymous offers a list of 20 questions to help a person

determine if they are a compulsive gambler. While not all 20 can apply to investing in the same

way that they do to gambling, some have been adapted for the flash messages. These messages

are delivered in an unobtrusive but noticeable way. Another thing that may discourage problem

investors is the task gating on the prediction data as a natural mechanism to break the cycle of

searching for the latest predictions.

### Legal Considerations

The European General Data Protection Regulation(GDPR) is a very impactful set of laws that

concerns the collection of personal information from any individual from the European Union.

To comply with the GDPR the only data that needs to be taken care of is the log data from the

access, error, and security logs. The policy that will be applied to the IP addresses contained in

the logs is an extremely short retention period. The services do not collect any other personal

information. The Children’s Online Privacy Protection Rule(COPPA) protects the personal

information of children. As the project does not collect any personal information, even within the

logs, and the answers generated by the Question service are predetermined and multiple choice

there is no chance at violating COPPA by collecting any personal information.


## Part Three

### Timeline

The following table outlines the proposed vs actual timeline for the project.

```
# Dates Subject of
Epic
```
```
Proposed Milestones Actual Milestones
```
```
1 5/01 - 5/07 Application
Front End
```
```
● Deployed Rails
Application
```
```
● Deployed Rails
Application
```
```
2 5/08 - 5/14 Data
Service
```
```
● Store and update
database
○ Stock data
○ News data
● Deployed Data
Service
```
```
● Data Service moved
to Rails application
● Access external API
for data and convert to
JSON Lines format
● Save to S
```
```
3 5/15 - 5/21 Prediction
Service
```
```
● Triggers on database
update
● Store and update
database
○ Prediction
data
● Deployed Prediction
Service
```
```
● Pull news from
external API and store
in application
database
● Display task, accept
answer, display
prediction
```
```
4 5/22 - 5/28 Task
Service
```
```
● Triggers on database
update
● Store and update
database
○ Task data
● Deployed Task
Service
```
```
● Use SageMaker to
investigate and
prepare data for
training
● Train models
● Deploy endpoint for
inferences
```
```
5 5/29 - 6/04 Testing/Deb
ug/Polish
```
```
● Increase Code
Coverage
● Track Issues and
Bugs
● Improve User
Interface
```
```
● Connect Rails
application to
endpoint for inference
● Chart and display
predictions
● Train better models
```

```
6 6/05 - 6/11 Testing/Deb
ug/Polish
```
```
● Increase Code
Coverage
● Track Issues and
Bugs
● Improve User
Interface
```
```
● Schedule complete
focus group testing
● Remove dynamic
features from training
set
● Train better models
```
```
7 6/12 - 6/18 Testing/Deb
ug/Polish
```
```
● Increase Code
Coverage
● Track Issues and
Bugs
● Refactor and
Optimize
```
```
● Add symbols for
tracking on navbar
● Increase Code
Coverage
● Track Issues and Bugs
● Refactor and Optimize
```
```
8 6/19 - 6/22 Testing/Deb
ug/Polish
```
```
● Increase Code
Coverage
● Track Issues and
Bugs
● Refactor and
Optimize
```
```
● Improve Application
Administration page
● Increase Code
Coverage
● Track Issues and Bugs
● Refactor and Optimize
```
### Resources and Budget

The Front End is deployed on AWS Elastic Beanstalk which requires one EC2 instance, one S

instance, and one load balancer. The load balancer is able to scale the application by

provisioning up to three additional EC2 instances in order to handle increased traffic. A MySQL

RDS database instance and an S3 instance are used for data storage. AWS DNS services and

Security services will be used for SSL and domain name routing. SageMaker will be used to

generate inferences. A model was created and deployed to an endpoint which receives

time-series stock data and returns inference results. The data throughput is expected to be low to

and from the SageMaker endpoint. The number of static assets is expected to be low and


generation of content using JavaScript will keep the number of static pages to a minimum. The

actual cost of ownership exceeds the projected cost due to the deceptive nature of free tier

services on AWS. The largest increase could be more than halved using a different endpoint

technique.


### Usability Testing and Evaluation

The testing and evaluation plans for the project include user feedback and automated testing

suites that run tests written during implementation on the latest commit of each branch. Usability

testing will primarily be done by the Front End integration and controller tests. These tests will

check the Front End from the routes and models to the controllers and views, testing the pages

for expected HTML elements and ensuring the controller functions are behaving as expected and

HTTP status codes can be tested as well. The SageMaker endpoint will not be able to be tested in

the same fashion. The model is tested during the training and the root mean square error of

predictions is minimized automatically. In order to achieve smaller error values for the model

addition training and features will be required.


The secondary usability test plan was conducting focus group testing with a small sample of

individuals. The focus group used consisted of three people. The ages of the participants ranged

from 30 to 70. Out of the group 66% were currently employed at or above 30 hours per week and

33% were retired. No one in the group was a moderate to advanced computer user and everyone

in the group had an interest in investing in the stock market. The general feedback on task 1, the

usability of the front page, was that it worked properly and was easy to use. Members of the

focus group for the most part did not know the stock symbol they were looking for which made

the second task of navigating to a stock’s page more difficult for some members of the focus

group. The third user task was to navigate to a stock’s page using the drop down menu but this

task had the same issues as the second. Implementing a search feature and clearly labeling the

stock cards with a company name could solve these issues.

The fourth task was to understand the historical charts used on a stock page. Users wanted larger

spans of time on the charts over intraday prices. Implementing better charts including a simple

moving average would solve this issue for readers of more sophisticated stock charts, and a

sliding scale historical chart of at least six months may be appropriate for novice users. The fifth

task was to read and interpret the prediction results. All users of the focus group wanted more

explanation to accompany the charted predictions and the table of results for the three displayed

quantiles. The use of smarter coloring schemes and the addition of tool-tips and help buttons can

solve the issues.

On each EC2 instance, and generated by the Front End and services, will be logs that relate to

access and errors. These logs will be examined for errors throughout the implementation and

deployment of each component. AWS also provides monitoring and performance metrics for all


resources used by the application that can be accessed online complete with the ability to

monitor and log any issues. Alarms for service outages and a periodic check for service ensures

the application is running and all non-IP containing logs from all services are stored in S3 for

inspection in the case of an application error.

Additional evaluation will be done utilizing testing suites. Testing will be run frequently using

Travis CI, a continuous integration tool that will run all tests to ensure each build passes before

the code is merged from a feature branch into the main branch. The continuous integration will

also be configured to generate code coverage reports to show the percentage of tested code. Code

Quality will also be tracked using Code Climate, a service that automates code reviews and

analyzes the quality of source code written in Python, Ruby, and JavaScript.

### Final Implementation

The web application is a set of pages and services that provides predictions for the closing price

of a stock for up to five days from its previous closing price. The stocks that can be predicted are

loaded on to the front page of the application with information about the market and sectors that

the stock is in. Each stock is in it’s own card and can be hovered over with a cursor or finger on

touch screens to reveal the company name or clicked on. If the stock is clicked on the user is

taken to that stock’s page.

When a stock’s page is loaded the user will be given a set of intraday price charts and a question

that must be answered in order to view the forecast. The intraday price charts are simple visuals

of the average intraday price, the high minus the low and the opening minus the closing values of

a stock for each minute. These are charted on the stocks page because they are currently being


investigated for use in a new model. Above these three charts is a red box with a question, link,

and answers next to checkboxes.

Questions are generated when a stock has no available questions or 51% of the time a stock is

clicked, even if questions regarding that stock already exist. Questions chosen for display are

randomly chosen in order to backfill those that have gone unanswered. A summary of an article

is presented along with a link and four simple answers. The answers correspond to a value

between 0 and 1. A question and a table of its answers and their values:

```
Answer I do not know It will not This may have a
negative effect
```
```
This may have a
positive effect
```
```
Value 0.5 0.5 0 1
```
The initial value of a question will be 0.5, corresponding to a neutral. This value will change as

users enter their opinions of the articles

In the front end database each question contains a running average of the answers and it is used

to gauge rough sentiment on the effects of the news on a stock. When enough data are collected

on a large enough number of stocks a model can be trained with the addition of this data.


When a user selects a checkbox for their desired answer, the content of the question is removed

and data is sent to SageMaker. Six months of stock history is fed to the neural network at the

endpoint in JSON Lines format and the JSON object returned contains the prediction data

separated by quantile and date. This data, along with the six months of stock history, is charted

and displayed for the user.

A blue line represents the historical closing price of the stock which meets up with a thin black

line representing the 0.5 quantile as shown in the following image.Above the black line is a

green shaded area representing the area from 0.9 to 0.5 and a red shaded area representing from

0.5 to 0.1. These quantiles divide the distribution of the predictions into high and low values.

Below the chart containing the prediction results is a table of the next five closing prices for

high, low, and mid quantiles. Each plotted point on the chart can be hovered over for more

information as seen below.


After the prediction results is a collection of recent news articles related to the stock being

looked at. Short summaries are provided for each article when they are available as well as the

source of the news, the date and time it was posted and the stock symbols for which it is relevant.

Each article can be clicked on and the user will have the article open in a new tab. The news

articles are grabbed with the IEXCloud API and are the most recent 5 articles available.

As seen above, from any page on the web application the navigation bar on the top of every page

can navigate a user to the front page by clicking Stochast on the left. A dropdown menu is

available for quickly navigating between stock pages. The About page is the markdown

README.md file available in the project’s GitHub repository that has been converted into a

webpage in order to match the style of the web application and provide the relevant information

on the project to the user. Navigating to this page will allow the user to read about the Stochast

web application and view information about the current build. Displayed information includes


the passing status of the current build, the percentage of the code covered by tests in the Rails

application, and the quality of the code according to an automated analysis.

Clicking on Privacy Policy in the navigation bar will take the user to the Stochast Privacy Policy

as clicking on Terms of Service will take the user to the Stochast Terms of Service. These are

required by Google to use their API for user authentication and have been created using online

policy and service generators. The Admin button takes the user to the administration page for the

application where an authorized user can add or remove stock symbols and upload or download

data stored for training.

From the SageMaker console the performance of the endpoint can be monitored and if necessary

a new model can be deployed or an endpoint can be shut down. In order to get a model with the

lowest error possible in a reasonable amount of time a number of training jobs were run, often in

parallel on multiple training instances in hyperparameter tuning jobs, where the parameters of the

model being trained are varied across multiple jobs. The purpose of a batch training job on the

same data like this is to quickly find and tune the most effective parameters for a given data set.


The above image shows all batch training jobs created for this project, prior to June 10th models

were being trained one at a time. This nearly 6 hours of training used 57 hours of computer

training time. The ability to train up to ten models at the same time allowed finding a model in a

much faster, but potentially more expensive way.

Hosting the application using Elastic Beanstalk allows the owner of the application to view

metrics and data about the application. Below are the available monitoring charts.

As can be seen, the response time of the application generally lies under 50 milliseconds and the

typical requests per day is under 200. The larger spikes in requestes can be wholly attributed to a

scan of the web application by an automated utility looking for vulnerabilities. The spike in CPU

and Max Network is the download off all instance logs for inspection after the scans were

noticed.

### Discussion

During the implementation of the project the original plan to use serverless architecture for the

back end fell apart one piece at a time. Deeper experimentation conducted during the

implementation phase revealed that Ruby on Rails does not interface well with a serverless

database instance. Further implementation revealed that a Lambda serverless function can not be

triggered by updates made to specific rows of a standard MySQL database. To solve these issues


the serverless architecture was dropped in favor of a standard database instance and moving the

most important functionality of the Lambdas to the Front End application for gathering data and

requesting inferences. The rest of the Lambda functionality was achieved using the SageMaker

console and a Jupyter notebook instance to train the initial models and investigate the time-series

data and newly created endpoints. The Jupyter notebook was in Python and the supporting

libraries were excellent for the task.

### Conclusion

This project is a web based application that supplies stock forecasts and relevant new to users

who supply human compute power and answer a small question. It is a Software as a Service

application that the user can access with a modern web browser on a desktop or mobile

computing device. The average investor does not have ready access to statistical or machine

learning methods to help inform their investing decisions. This web application provides access

to a neural network that has been trained to forecast five days worth of closing prices. In

exchange a user will assist in data labeling tasks for every prediction they receive.

The goals of this project were to collect data from an external API, to create and store questions

for users, training and deployment of a deep learning model, and implementation of an interface

to request and view the results of inferences made by the model. This project has achieved those

goals by pulling news and time-series data from IEXCloud, using Rails to create and store

questions for users, using SageMaker to train and deploy a deep learning model, and using Rails

to request inferences from that model so that it can chart and display them for a user.

The application does not require a user to log in, pay any money, or retain logs longer than

necessary in order to preserve user privacy. These set the application apart in the financial


forecasting space where paying for indicators or access to information is common along with

having to divulge an email address or a name.

The most recent iteration of the site is located at https://jltav.com, hosted behind an application

load balancer that can scale the service to accommodate a sharp uptick in demand, then scale

back down again to keep costs low. Inferences are requested from a SageMaker endpoint and

application data is stored in a MySQL database while training, test, and model data is stored in

an S3 bucket. An Agile approach was used to develop the application and the hosting provider

had a simple interface for manually or programmatically upgrading the version of the application

when new features were added. GitHub was used for version control and continuous integration

tools were used to automate code review, generate code coverage reports, and run tests. The

continuous integration tools run with every push to all branches of the GitHub repository to

ensure all commits are tested and reviewed.


## References

Cable News Network. (2019). ​ _Business and Financial News - CNN Money._ ​ Retrieved from

```
http://markets.money.cnn.com/research/lookup/lookup.asp
```
I Know First Stock Forecast. (2019). ​ _Stock Forecast Based On a Predictive Algorithm_ ​.

```
Retrieved from https://iknowfirst.com
```
Stock Market Sensei. (2019). ​ _Stock Market Sensei - Dashboard._ ​ Retrieved from

```
https://www.stockmarketsensei.net/Dashboard/pages/index.php
```
WalletInvestor.com. (2019). ​ _CryptoCurrency, Stock, Forex, Fund and Commodity Markets,_

```
Prices, Predictions & Charts. ​ Retrieved from https://walletinvestor.com/
```

