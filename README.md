Effect of Taking ACEI or ARB on Preventing Chronic Kidney Disease 
=================================================================

This repository contains an analysis of the effect of ACEI or ARB on preventing chronic kidney disease (CKD).
The original paper is ["A Machine Learning Analysis of Health Records of Patients With Chronic Kidney Disease 
at Risk of Cardiovascular Disease"](https://ieeexplore.ieee.org/document/9641833 "The Paper") and the data can
be obtained from Kaggle [here](https://www.kaggle.com/datasets/davidechicco/chronic-kidney-disease-ehrs-abu-dhabi?resource=download)

Using This Repository
=====================
This repository is best suited via Docker. After cloning this repository in your machine, you can build 
a Docker container from this command. 
```
docker build . -t ckdprevention
```
Once you build the Docker container, running this command will run the container. you can enter your own password in {yourpassword}.
You need to enter your local address in {youraddress} to connect it to the folder in Docker.
```
docker run -d -e PASSWORD={yourpassword} --rm -p 8787:8787 -v {youraddress}:/home/rstudio -t ckdprevention
```
Then, visit http://localhost:8787 via your browser and enter id:rstudio and password:{yourpassword} to start RStudio Server.

Project Organization
====================
You can replicate the anlysis including figures, report, etc by using Makefile. you can look into Makefile to see targets' names.
To create the report, run this code.
```
make report.html
```

Results
=======
This analysis uses causal framework to reveal the relationship between taking ACEI/ARB and developing CKD. The conclusion is somewhat limited
because of the possible violation of the assumptions in causal analysis. You can find out the details in "report.html". 