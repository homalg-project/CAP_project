<script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="https://unpkg.com/thebelab@0.0.3"></script>

<script type="text/javascript">overwriteStyle();</script>
</head>
<body class="chap3"  onload="jscontent()">

<script type="text/javascript">
  function convert_examples(){
    $('.GAPprompt').remove();
    $('.example').map(function (i, el) { 
      $(el).replaceWith( function() {
        return $('<pre data-executable=\"true\" data-language=\"gap\"></pre>').text(
          $(el).find('.GAPinput').map( function(i,elem){ return $(elem).text(); } ).get().join( "\n" )
          );
      });
    });
  }



<script type="text/javascript">
function binderKernel() {
  // request a kernel from Binder
  return thebelab
    .requestBinder({
      repo: "sebasguts/GAPBinderDemo",
    })
    .then(serverSettings => {
      console.log("binder settings", serverSettings);
      return thebelab.requestKernel({
        serverSettings,
        name: "gap-native",
      });
    });
}
function start_kernel(){
  let cells = thebelab.renderAllCells();
  binderKernel().then(kernel => {
    thebelab.hookupKernel(kernel, cells);
  });
}
convert_examples();
start_kernel();
</script>
