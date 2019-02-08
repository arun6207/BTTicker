# BTTicker
BiTicker assessment for BitOasis
Code
Swift 4.2
Minimum deployment target iOS 12.1
Build Requirements
XCode 10.1
Project Structure
📁 ViewModel :  All view models of the project
📁 Views    : All custom views
📁 Controlles    : All ViewControllers of the project
📁 Models : All models
📁 Network : All Network related files
📁 Utility : All Global,extension files
📁 BitTIckerTests : All testcases for non-UI clasess - Implemented test cases for DataValidator class.
📁 BitTIckerUITests : All UI testcases - Implemented test cases for login screen 

The project is done using following third pod libraries: 
'Starscream' -  for web socket connection
'Firebase/Core' - used for saving User ddeatils and crash reports
'Firebase/Auth' - used of authenticcating user  details 
'Charts' - for displaying virctual currencies in a chart
Constraints
-It's not possible to debug using devices higher than iOS 12.1 (max version Xcode 10.1 supports)
- Create new user using signup button or use following credentails for login:
-  username : test@test.com
-  password: 12346


