// Prototypes
String.prototype.firstUpperCase = function () {
    return this.substr(0, 1).toUpperCase() + this.substr(1);
}

// Translations
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

$(function(){
    // Translate
    var translateHandler = function (idx) {
        var content = $(this).text();
        console.log('"'+content+'"');
        if (translations.hasOwnProperty(content)) {
            $(this).text(translations[content]).addClass('translated');
        } else {
            $(this).text(content.firstUpperCase());
        }
    }
    $('.translate').each(translateHandler);

    // Toggle
    var ssrToggleHandler = function (event) {
        event.preventDefault();
        var targetIdentifier = $(this).data('closest') || '';
        $(this).closest(targetIdentifier).toggleClass('open');
        
    }
    $('.js-toggle').on('click', ssrToggleHandler);
});