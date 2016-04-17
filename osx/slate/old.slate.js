//{{{1 heading-modeline-opening log
//  vim: tw=78 ts=2 sts=2 et foldmethod=marker foldmarker=//{{{,//}}}:
// Javascript Config for Slate
//  amjames
slate.log("Starting Config... ~/.slate.js");
//
//{{{1 define re-usables: hacks, functions, variables
//{{{2 spaces-hacks

//{{{3 goToX shell operations
//    goToSpaceX will use an apple script to move (focus not window)
//    works by simulating keyboard shortcut

var goToSpace1 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp1.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

var goToSpace2 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp2.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

var goToSpace3 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp3.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

var goToSpace4 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp4.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

var goToSpace5 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp5.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

var goToSpace6 = slate.operation("shell",{
    "command": "/usr/bin/osascript chsp6.applescript",
    //"wait: true,
    "path": "/Users/admin/.scripts/spaces-hacks/"
});

//{{{2 pureJSFunctions

//{{{3 toArray(o)
// convert object o into an array to loop over
var toArray = function(o) {
  return Array.prototype.slice.call(o);
}

//{{{3 askMe(question,choices)
// question: string - text for prompt box
// choices: array that defines acceptable choices or a map that defines return
// values for valid input (ie return choices[inputVal] )
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


//{{{3 helpers vertical tiling

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

//{{{3 col dector
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

//{{{3 strech tall
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
//{{{2 operations
//
//{{{3 pushing

var pushRightBar = slate.operation("push",{
  "direction" : "right",
  "style" : "bar-resize:screenSizeX/6"
});
var pushRight = slate.operation("push",{
  "direction" : "right"
});

var pushLeft =  slate.operation("push",{
  "direction" : "left"
});

var pushDown = slate.operation("push",{
  "direction" : "down"
});

var pushUp =  slate.operation("push",{
  "direction" : "up"
});

var toTopBar = slate.operation("push",{
  "direction" : "up",
  "syle" : "bar-resize:screenSizeY/6"
});



//{{{2 nudges
var nudgeRight = slate.operation("nudge",{
  "x" : "+10%",
  "y" : "+0"
});

var nudgeLeft = slate.operation("nudge",{
  "x" : "-10%",
  "y" : "+0"
});

var nudgeDown = slate.operation("nudge",{
  "x" : "+0",
  "y" : "-10%"
});

var nudgeUp = slate.operation("nudge",{
  "x" : "+0",
  "y" : "+10%"
});

//{{{2 bar
var runnerBar = slate.operation("sequence", {
  "operations" :  [ [ MoveRight3Upper3 ] , [ halfSize ] ,  [ pushUp ] ]
});

//{{{2focus Cycle

var focusUp = slate.operation("focus",{
    "direction": "up"
});

var focusDown = slate.operation("focus",{
    "direction": "down"
});

var cycleFocusUp = slate.operation("sequence",{
  "operations" : [
    [
      function (windowObj) {
        var colOff = detectWindoCol(windowObj);
        spreadAppVertical(windowObj.app(), colOff);
      },
      focusUp
    ],
    [ function(windowObj) {strechTall(windowObj);} ]
  ]
});

var cycleFocusDown = slate.operation("sequence",{
  "operations" : [
    [
      function (windowObj) {
        var colOff = detectWindoCol(windowObj);
        spreadAppVertical(windowObj.app(), colOff);
      },
      focusDown
    ],
    [ function(windowObj) {strechTall(windowObj);} ]
  ]
});
//{{{2 movers
//
//{{{3 Sizers
//
//
var halfSize = slate.operation("resize",{
  "width" : "+0",
  "height": "-50%"
});
//{{{3 Rightmovers
var MoveRight3Lower2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y" : "screenOriginY+(screenSizeY/2)"
});

var MoveRight3Upper2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y": "screenOriginY"
});

var MoveRight3Lower3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y" : "screenOriginY+(2*screenSizeY/3)"
});

var MoveRight3Mid3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y" : "screenOriginY+screenSizeY/3"
});

var MoveRight3Upper3 = slate.operation("move", {
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y" : "screenOriginY",
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3"
});

var MoveRight3Full = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height": "screenSizeY",
  "x" : "screenOriginX+(2*screenSizeX/3)",
  "y" : "screenOriginY"
});

//{{{3 Center
var MoveCenter3Lower2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y" : "screenOriginY+(screenSizeY/2)"
});
var MoveCenter3Upper2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y": "screenOriginY"
});
var MoveCenter3Lower3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y" : "screenOriginY+(2*screenSizeY/3)"
});
var MoveCenter3Mid3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y" : "screenOriginY+(screenSizeY/3)"
});
var MoveCenter3Upper3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y" : "screenOriginY"
});
var MoveCenter3Full = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height": "screenSizeY",
  "x" : "screenOriginX+(screenSizeX/3)",
  "y": "screenOriginY"
});


//{{{3 Left mOvers
var MoveLeft3Lower2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX",
  "y" : "screenOriginY+(screenSizeY/2)"
});

var MoveLeft3Upper2 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/2",
  "x" : "screenOriginX",
  "y": "screenOriginY"
});
var MoveLeft3Lower3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX",
  "y" : "screenOriginY+(2*screenSizeY/3)"
});
var MoveLeft3Mid3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX",
  "y" : "screenOriginY+(screenSizeY/3)"
});
var MoveLeft3Upper3 = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height" : "screenSizeY/3",
  "x" : "screenOriginX",
  "y": "screenOriginY"
});
var MoveLeft3Full = slate.operation("move", {
  "width" : "screenSizeX/3",
  "height": "screenSizeY",
  "x" : "screenOriginX",
  "y" : "screenOriginY"
});

//{{{2 grids
var grid = slate.operation("grid",{
  "grids":{
    "2560x1440": {
      "width": 12,
      "height": 12
    }
  },
  "padding": 8
});

//{{{2 layouts
var officeLayout = slate.layout("officeLayout",{
  "Airmail": {
    "operations" : [ MoveRight3Lower3 ],
    "ignore-fail" : true,
    "repeat": true
  },
  "1Password" : {
    "operations" : [ MoveCenter3Upper3 ],
    "ignore-fail" : true
  },
  "Safari":{
    "operations": [ MoveRight3Upper3, MoveRight3Mid3, MoveRight3Lower3 ],
    "ignore-fail": true,
    "repeat":true
  },
  "Terminal":{
    "operations": [runnerBar, MoveLeft3Full, MoveLeft3Lower3],
    "title-order-regex" : ["^runner$"],
    "ignore-fail" : true,
    "repeat-last" : true
  }
});


//{{{1 configs
slate.config("windowHintsShowIcons",true);
//slate.config("focusCheckWidth",1);
//slate.config("focusCheckWidthMax",1000);
slate.config("resizePercentOf","windowSize");
slate.config("nudgePercentOf","screenSize");
slate.config("windowHintsSpreadSearchWidth",20);
slate.config("windowHintsSpread",true);
slate.config("windowHintsSpreadPadding",20);
slate.config("windowHintsOrder","persist");
slate.config("layoutFocusOnActivate",true);
slate.config("modalEscapeKey","esc");

//{{{1 bindings
//
//{{{2 grid

slate.bind("q:ctrl,cmd,shift", grid);

//{{{2 switchers

slate.bind("tab:ctrl,cmd",slate.operation("switch"));

///{{{2 hints

slate.bind("space:ctrl,cmd",slate.operation("hint"));

//{{{2 arrange all

//slate.bind("1:alt:toggle")

//{{{2 window movement (alt lead)
//{{{3 pushes
slate.bind("l:alt", pushRight);
slate.bind("h:alt", pushLeft);
slate.bind("j:alt", pushDown);
slate.bind("k:alt", pushUp);

//{{{2 nudges
slate.bind("l:alt,shift", nudgeRight);
slate.bind("h:alt,shift", nudgeLeft);
slate.bind("j:alt,shift", nudgeDown);
slate.bind("k:alt,shift", nudgeUp);

//{{{1 default
slate.default(["2560x1440"],officeLayout);

//{{{1 event listeners

//{{{2 on window focus make it full length + return last window to smaller
//    size
//{{{3 WIP
//slate.bind("`:ctrl", cycleFocusUp );
//slate.bind("`:ctrl,shift", cycleFocusDown );
//{{{
var winLog = function(eventName, appOrWin){
  var winLog = " eventFired!>> " + eventName + " in process: " + appOrWin.pid();
  //eventHistoryList.push(winLog);
}

var appLog = function(eventName, appOrWin){
  var winLog = " eventFired!>> " + eventName + " in process: " + appOrWin.pid();
  //eventHistoryList.push(winLog);
}



slate.on("windowFocused", function(event, win){
  winLog(event,win);
});
slate.on("windowMoved", function(event,win){
  winLog(event,win);
});
slate.on("windowResized", function(event,win){
  winLog(event,win);
});
slate.on("windowOpened", function(event,win){
  winLog(event,win);
});
slate.on("windowClosed", function(event, win){
  winLog(event,win);
});
slate.on("windowTitleChanged", function(event,win){
  winLog(event,win);
});

slate.on("appHidden", function(event,app){
   appLog(event,app)
});
slate.on("appOpened", function(event,app){
  appLog(event,app);
});
slate.on("appClosed", function(event,app){
  appLog(event,app);
});
slate.on("appUnhidden", function(event,app){
  appLog(event,app);
});
slate.on("appActivated", function(event,app){
  appLog(event,app);
});
slate.on("appDeactivated", function(event,app){
  appLog(event,app);
});

//temporary (for debugging)
slate.bind("r:ctrl,shift,cmd", function(){
  logstr="!!eventInfoReport---->>>";
  eventHistoryList.forEach(function(logEntry){
     logstr+="\n\t event:" + logEntry;
  });
  slate.log(logstr);
});

slate.bind("t:ctrl,shift,cmd", function() {
  eventHistoryList = ["nada"];
});

slate.log("Config is DONE! HORAYYYY!")
