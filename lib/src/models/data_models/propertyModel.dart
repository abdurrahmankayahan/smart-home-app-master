import 'dart:ui';

class PropertyModel {
String? propertyName="";  
String? pinNo="";
String? pinIO="";
String? pinVal="";
String? itsOn="";

Function({String? val})? updateFunc;

VoidCallback? updateValue;


 PropertyModel({
     this. propertyName="",
     this. pinNo="",
     this. pinIO="",
     this.pinVal="",
     this. itsOn="",
    this.updateValue,
    this.updateFunc,
  });

 Function({String? val}) get getUpdateFunc => this.updateFunc!;

 set setUpdateFunc(Function(String? updateFunc)) => this.updateFunc = updateFunc;

 VoidCallback get getUpdateValue => this.updateValue!;

 set setUpdateValue(VoidCallback updateValue) => this.updateValue = updateValue; 


 String? get getPropertyName => this.propertyName;

 set setPropertyName(String? propertyName) => this.propertyName = propertyName;

 String? get getPinNo => this.pinNo;

 set setPinNo(String? pinNo) => this.pinNo = pinNo;

 String? get getPinIO => this.pinIO;

 set setPinIO(String? pinIO) => this.pinIO = pinIO;

 String? get getPinVal => this.pinVal;

 set setPinVal(String? pinVal) => this.pinVal = pinVal;

 String? get getItsOn => this.itsOn;

 set setItsOn(String? itsOn) => this.itsOn = itsOn;
 

}