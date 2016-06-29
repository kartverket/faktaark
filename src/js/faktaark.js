String.prototype.firstUpperCase = function () {
    return this.substr(0, 1).toUpperCase() + this.substr(1);
}

var i,j;

var translations = {
    'nor': 'Norsk',
    'sme': 'Nordsamisk',
    'nevneform': 'Nemneform',
    'nominativ': 'Nominativ',
    'genitiv-akkusativ': 'Genetiv akkusativ',
    'iverksattVedtak': 'Vedtak iverksatt',
    'ubehandlet': 'Ubehandla',
    'vedtatt': 'Vedtak',
    'godkjent': 'Godkent',
    'avslått': 'Avslege',
    'feilført': 'Feilført',
    'hovednavn': 'Hovudnamn',
    'sidenavn': 'Sidenamn',
    'bruk': 'Bruk',
    'gardsbebyggelse': 'Gardsbebyggelse',
    'bebyggelse': 'Bebyggelse',
    'kommune': 'Kommune',
    'administrativeIndelinger': 'Administrative inndelinger',
    'offentligAdministrasjon': 'Offentlig administrasjon'
};

var translates = document.getElementsByClassName('translate');
for (i = 0, j = translates.length; i < j; i++) {
    var content = (translates[i].innerText || translates[i].textContent).trim();
    console.log(content);
    if (translations.hasOwnProperty(content)) {
        translates[i].textContent = translations[content];
        translates[i].classList.add('translated');
    } else {
        translates[i].textContent = content.firstUpperCase();
    }
}

var spellingClickHandler = function (event) {
    event.preventDefault();
    var targetId = this.dataset.targetId || '';
    if  (targetId != '') {
        var targetElement = document.getElementById(targetId);
        if (targetElement !== null) {
            targetElement.classList.toggle('open');
        }
    }
}
var spellings = document.getElementsByClassName('js-spelling-toggle');
for (i = 0, j = spellings.length; i < j; i++) {
    spellings[i].addEventListener('click', spellingClickHandler, false);
}