//  vim: tw=78 ts=2 sts=2 et foldmethod=marker foldmarker=//{{{,//}}}:

var grid = slate.operation("grid",{
  "grids":{
    "2560x1440": {
      "width": 12,
      "height": 12
    }
  },
  "padding": 8
});

//{{{ Shells
//var goToSpace1 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp1.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//var goToSpace2 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp2.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//var goToSpace3 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp3.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//var goToSpace4 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp4.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//var goToSpace5 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp5.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//var goToSpace6 = slate.operation("shell",{
//    "command": "/usr/bin/osascript chsp6.applescript",
//    //"wait: true,
//    "path": "/Users/admin/.scripts/spaces-hacks/"
//});

//}}}

//WIP SpreadApp
//{{{
var spreadAppVertical = function(theApp, xOff, width) {
  var makeWide = width || "screenSizeX/3";
  var winCount = 0;
  var logstr = "In spreadAppVertical";
  theApp.eachWindow(function(winObj){
    logstr += "\n\trunning window speader part 1";
    //if (!winObj.isMinimizedHidden()){
    winCount += 1;
    logstr+="\n \t\tCounting, on window" + winCount.toString();
    //}
  });
  logstr += "\n\t\t Done Counting!";
  var winIdx=0;
  logstr += "\n\trunning window speader part 2";
  theApp.eachWindow(function(winObj){
    winIdx +=1;
    //if (!winObj.isMinimizedHidden()){
    var sucMv = winObj.move({
      "x":  xOff,
      "y": "screenOriginY+"+winIdx.toString()+"*(screenSizeY/"+winCount.toString()+")"
    });
    var sucRz = winObj.resize({
      "width" : makeWide,
      "height": "screenSizeY/" + winCount.toString()
    });
    if (!sucRz){
        logstr+="resizeError";
    }else{
      logstr+="\n\t\t Window" + winIdx.toString() + " resized to ["+makeWide +" x " +"screenSizeY/"+winCount.toString()+" ]";
    }
    if (!sucMv) {
      logstr+= "\n\t\tmoveError!";
      logstr+= "\n\t\t\twinIdx:"+ winIdx.toString();
      logstr+= "\n\t\t\txexpression ==>"+ xOff;
      logstr+= "\n\t\t\ty expression ==> screenOriginY+"+winIdx.toString()+"*(screenSizeY/"+winCount.toString()+")";
    }else{
      logstr+="\n\t\t Window" + winIdx.toString() + " moved to ["+ xOff + " x " + "screenOriginY+screenSizeY/" + winIdx.toString() + " ]";
    }
    //}
  });
  slate.log(logstr);
};
//}}}

//{{{ col dector
var detectWindoCol = function(windowObj) {
  var myScreen = windowObj.screen();
  var scrnRect = myScreen.rect();
  var screenSizeX = scrnRect.x;
  var winTL = windowObj.topLeft();
  if( winTL.x <=  screenSizeX/3 ) {
    slate.log("dectected screenOriginX");
    return "screenOriginX";
  }else if (winTL.x >screenSizeX/3 && winTL.x <= (screenSizeX/3)*2){
    slate.log("dectected screenOriginX+screenWidth/3");
    return "screenOriginX+screenSizeX/3"
  }else{
    slate.log("dectected screenOriginX+2*screenSizeX/3");
    return "screenOriginX+2*(screenSizeX/3)"
  }
};
//}}}
//{{{ strech tall
var strechTall = function(winObj) {
  size = winObj.size();
  width = size.width;
  var xOff = detectWindoCol(winObj);
  var tempMove = slate.operation("move", {
    "width" : width,
    "height" : "screenSizeY",
    "x" : xOff,
    "y" : "screenOriginY"
  });
  winObj.doOperation(tempMove);
  slate.log("windowStreched");
};
//}}}


//{{{ Runner
//Experimental have this fucntion do soemthing with apps folder to act as a
//"dmenu" type interface?
var askMe = function(question, choices){
  var promptString = question.toString();
  var returnVal = "";
  var typeOfReturn = null;

  if (!!( choices )){
    if ( _.isArray(choices) ){
      typeOfReturn = Array;
      var count = 0;
      promptString += "\n Choose by number:";
      choices.forEach(function(option){
        count +=1;
        promptString += "\n\t ("+ count.toString() + ")   =="+ option.toString() +"==";
      });
    }else if( _.isObject(choices)  ){
      typeOfReturn = Object;
      promptString += "\n Choose by name:";
      Object.getOwnPropertyNames(choices).sort().forEach(function ( val, idx, array){
        promptString += "\n \t ["+ val + "]  ==" + choices[val] + "==";
      } );
    }else if( _isString(choices) ){
      typeOfReturn = String;
      promptString += "\n Choose by:";
      promptString += "\n \t "+ choices;
    }else{
      typeOfReturn = Boolean;
    }
  }
  promptString += "\n";
  var message = prompt(promptString,"??");
  if (message != null ){
    slate.log("askMe got " + message);
    switch (returnVal) {
      case Array:
        return choices[ Number(message) ];
        break;

      case Object:
        return choices[message.toString()];
        break;

      case String:
        return message;

      case Boolean:
        if ( message === "y" || message === "yes" || message === "true" ) {
           return true;
        }else{
          return false;
        }
        break;

      default:
        slate.log("askMe Error: no-return-type detected from choices : "+ choices);
        return false;
    }
  } else {
    slate.log('askMe ERROR: error-nomessage');
    return false;
  }
};

//}}}
