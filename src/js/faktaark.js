var fooHandler = function (event) {
    var tbody = document.getElementById('bar');
    var rows = tbody.getElementsByTagName('tr');
    tbody.appendChild(rows[0]);
    //console.log(rows);
}
document.getElementById('foo').addEventListener('click', fooHandler, false);

var order = [4, 1, 3, 2];var rekkefølge = [];
var foobarHandler = function (event) {
    var tbody = document.getElementById('bar');
    for (var idx in order) {
        tbody.appendChild(document.getElementById('ssr-row-'+order[idx].toString()));
        console.log(order[idx]);
    }
    /*var rows = tbody.getElementsByTagName('tr');
    tbody.appendChild(rows[0]);*/
    //console.log(rows);
}
document.getElementById('foobar').addEventListener('click', foobarHandler, false);

var translations = {
    'nevneform': 'Nemneform',
    'nominativ': 'Nominativ',
    'genitiv-akkusativ': 'Genetiv akkusativ',
    'iverksattVedtak': 'Vedtak iverksatt',
    'hovednavn': 'Hovudnamn',
    'sidenavn': 'Sidenamn'
};

var transatables = document.getElementsByClassName('translate');
for (var i = 0, j = transatables.length; i < j; i++) {
    var content = (transatables[i].innerText || transatables[i].textContent).trim();
    if (translations.hasOwnProperty(content)) {
        transatables[i].textContent = translations[content];
        transatables[i].classList.add('translated');
    }
}