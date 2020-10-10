# DemRobo
Source backup of journal: System Design of Sympotom Detection of Mild Cognitive Impairment with Observational Robot [(Link)](http://www.jatit.org/volumes/Vol97No18/8Vol97No18.pdf) This git is written by multiple sources, PHP, Objective-C, and Python. The description below will be updated. 
 
## Description
### Server 
* Back-end
  - Database: mySQL
  - APIs: PHP
  
### Client
* iPad-based graphic user interface: iOS 11
* Supports KOREAN/ENGLISH 
* Due to unsupported Korean version of Google TTS at the time, we adopted Kakao TTS API into our project. (currently not uploaded in this git)
* Content
  - [DemTect](https://doi.org/10.1002/gps.1042)
  
* Front-end
  - django + CSS
  
* Design

### Robot-Side
* Physical Robot
  - Q.Bo: Raspberry Pi based robot system
  
* Chatbot
  - DialogFlow-based chatbot system (not applied)
  
* Sensors
  - Due to low capacity of Q.Bo's processor, pedestrian detection cannot be solved by vision-based solution. Hence, we adopted infra-red sensors to cover 240 degree of robot's sight ultimately to realize human-robot interaction. 
  
### Contribution
* Software developer: [Goeum](https://github.com/chagom)
* Webpage designer: [StellaDoeun](https://github.com/StellaDoeun)

#### Side notes
Refactoring codes at the client side, especially iOS one, might be required. (Followed MVC pattern)
