function note(o, n) {
  var nr = o.split("_")[1];
  for ( var i = 1; i <= 5; i++ ) {
    var id = "_" + nr + "_" + i + "_";
    var obj = document.getElementById(id);
    if ( i <= n ) {
      obj.innerHTML = "&#9733;"; // yea
    } else {
      obj.innerHTML = "&#9734;"; // nay
    }
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const auth = new URLSearchParams(window.location.search).get("auth");
  document.querySelectorAll("a[href*='{{auth}}']").forEach(link => {
    link.href = link.href.replace("{{auth}}", encodeURIComponent(auth));
  });

  document.querySelectorAll("form[action*='{{auth}}']").forEach(form => {
    form.action = form.action.replace("{{auth}}", encodeURIComponent(auth));
  });

  const items = document.querySelectorAll(".kmnt");
  items.forEach(item => {
    item.addEventListener("blur", function () {
      var lnk = "/hldw?auth="+auth+"&uid="+this.id+"&note="+this.value;
      console.log(lnk);
      document.getElementById("actor").src = lnk;
    });
  });

});

function jsonFormat(jsonString) {
  try {
    // Parse and re?stringify with indentation
    const obj = JSON.parse(jsonString);
    return JSON.stringify(obj, null, 2); // spaces indentation
  } catch (e) {
    console.error("Invalid JSON:", e);
    return jsonString; // Return original text if not valid JSON
  }
}

const open = '{"prompt":"@PRPT","n":1,"size":"1536x1024","quality":"high","model":"gpt-image-1","output_format":"jpeg","input_fidelity":"high"}';
const goog = '{"generationConfig":{"responseModalities":["Image"],"imageConfig":{"aspectRatio":"16:9"}},"contents":[{"parts":[{"text":"@PRPT"},{"inline_data":{"mime_type":"image/jpeg","data":"@JPEG"}}]}]}';
const grok = '{}';
/*
const prompts = [
`***en respectant strictement la structure de la pièce***,
transforme cette pièce en DESTINATION et
refais le design intérieur en style DESIGN`
,
`***en respectant strictement la structure de la pièce***,
transforme cette pièce en DESTINATION et
refais le design intérieur en style lumineux DESIGN haut de gamme`
,
`***en respectant strictement la structure de la pièce***,
rafraîchit le design intérieur`
]
*/

function stripSpaces(str){
  return str.replace(/\s+/g, ' ').trim();
}

function prep(){
  var params = open;
  var tool = document.getElementById("tool").value;
  switch ( tool ) {
    case "GOOG":
      params = goog;
      break;
    case "GROK":
      params = grok;
      break;
  }
  document.getElementById("params").value = jsonFormat(params);

  var prompt = document.getElementById("prpt").value;

  var dest = document.getElementById("dest").value;
  var dest_ = document.getElementById("dest").selectedOptions[0].text;
  if ( dest == "BOF" ) {
    prompt = prompt.replace("transforme cette pièce en DESTINATION et", "");
  } else {
    prompt = prompt.replace("DESTINATION", dest_.toUpperCase());
  }

  var styl = document.getElementById("styl").value;
  var styl_ = document.getElementById("styl").selectedOptions[0].text;
  if ( styl == "BOF" ) {
    prompt = prompt.replace("refais le design intérieur en style DESIGN", "rafraîchit le design intérieur");
  } else {
    prompt = prompt.replace("DESIGN", styl_.toUpperCase());
  }

  document.getElementById("prompt").value = stripSpaces(prompt);
}
function exec(){
  var link = "/hld2";

  const auth = new URLSearchParams(window.location.search).get("auth");
  link += "?auth=" + auth;
  const uid  = new URLSearchParams(window.location.search).get("uid");
  link += "&hst=" + uid;
  const tool = document.getElementById("tool").value;
  link += "&tool=" + tool;
  const dest = document.getElementById("dest").value;
  link += "&dest=" + dest;
  const styl = document.getElementById("styl").value;
  link += "&styl=" + styl;
  const para = document.getElementById("params").value;
  link += "&para=" + encodeURI(para);
  const prpt = document.getElementById("prompt").value;
  link += "&prpt=" + encodeURI(prpt);

  link = stripSpaces(link);
  console.log(link);

  if ( params.length < 5 || prpt.length < 5 ) {
    alert("Les params ou le prompt ne peuvent pas être vides !");
    return;
  }

  document.documentElement.style.cursor = 'wait';
  document.body.style.opacity = 0.5;
  fetch(link)
    .then(() => location.reload())
    .catch(() => alert('Homestaging failed.'));
}
