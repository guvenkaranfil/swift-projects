var Action = function () {}

Action.prototype = {
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},
    
finalize: function() {
    
}
    
};

var ExtensionProccessingJS = new Action
