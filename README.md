# BFIDemoPlayer

Was built with Xcode 9.2
Using Swift 3.2


Libraries included (not all used)

RxSwift
Alamofire
RealmSwift
KIf


Requires Cocoapods 1.0.0 +
Need to run pod install on project


Notes 


Only one record retrieved from the set api has items (episodes) 
I wasn’t clear on the function of the api and would normally have clarified this before coding
However, as this is a tech test I have made the following assumptions
  Assumption -> Display all sets that are returned -> Including sets that have no Items. 
A number of sets / episodes appear to have no link to images -> handle
Temp_image -> couldn’t get to work / not sure on the proper api call here

Price -> would be good to display but no record returned had price therefore don’t show

App flow

If  item count 0 -> detail view (Set)  if > 0 episode list view (Item List View)

episode list view -> detail view (Episode)

Ran out of time to Include episodes List



Notes on Implementation
A tableview would have been suffice but a collection view offers more flexibility and therefore offers more scope in the future. Therefore a  collection view was chosen over a tableview



Improvements

Improved error handling
Unit tests and UITesting
