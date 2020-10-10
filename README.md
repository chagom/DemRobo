# DemRobo
Source backup of journal: System Design of Sympotom Detection of Mild Cognitive Impairment with Observational Robot [Link](http://www.jatit.org/volumes/Vol97No18/8Vol97No18.pdf) This git is written by multiple sources, PHP, Objective-C, and Python.
 
## Description
### Server 
* Back-end
  - Database: mySQL
  - APIs: PHP
  
### Client
* iPad-based Graphic User Interface: iOS 11
* KOREAN/ENGLISH 
* Due to unsupported Korean version of Google TTS at the time, we adopted Kakao TTS API into our project. (currently not uploaded in this git)
* Content
  - [DemTect](https://doi.org/10.1002/gps.1042)
  
* Front-end
  - django + CSS

### Robot-Side
* Physical Robot
  - Q.Bo: Raspberry Pi based robot system
  
* Chatbot
  - DialogFlow-based chatbot system (not applied)
  
* Sensors
  - Due to the ability limitation of Q.Bo's processor, pedestrian detection cannot be solved by vision-based solution due to low capacity of local computing side. Hence, we adopted infra-red sensors to cover 240 degree of robot's sight ultimately to realize human-robot interaction. 

#### Side notes
Refactoring codes at the client side, especially iOS one, might be required. (Followed MVC pattern)
