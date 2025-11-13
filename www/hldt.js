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

function post(obj) {
  var frm = obj.closest('form');
  var inp = frm.querySelector('input');
  inp.value = obj.src;
  frm.submit();
}

document.addEventListener("DOMContentLoaded", function () {
  const auth = new URLSearchParams(window.location.search).get("auth");
  document.querySelectorAll("a[href*='{{auth}}']").forEach(link => {
    link.href = link.href.replace("{{auth}}", encodeURIComponent(auth));
  });
  document.querySelectorAll("form[action*='{{auth}}']").forEach(form => {
    form.action = form.action.replace("{{auth}}", encodeURIComponent(auth));
  });
});
