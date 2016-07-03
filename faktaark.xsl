<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:app="http://skjema.geonorge.no/SOSI/produktspesifikasjon/Stedsnavn/5.0" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:wfs="http://www.opengis.net/wfs/2.0">
    <!-- Globale variabled -->
    <xsl:variable name="språkprioritering" select="wfs:FeatureCollection/wfs:member/app:Sted/app:språkprioritering" />
    <xsl:variable name="skrivemåteprioritering" select="'godkjent-vedtatt-vedtattNavneledd-avslått-avslåttNavneledd-feilført-internasjonal-privat-historisk-foreslått-uvurdert'" />
    <xsl:template match="/">
        <html>
            <head>
                <meta content="utf-8" />
                <meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
                <title>Faktaark - Kartverket</title>
                <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
                <link href="css/faktaark.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <!-- Faktaark -->
                <section class="wrapper">
                    <h1 class="kv-heading">
                        <span class="text">Faktaark</span>
                        <span class="line"></span>
                    </h1>
                    <p>Eit stadnamn er namnet på ein lokalitet. Stadnamn skal skrivast på bestemte måtar. Lov om stadnamn beskriv prosessane for fastsetjing av skrivemåten og bruken av stadnamn. Kartverket driftar Sentralt stadnamnregister (SSR), som inneheld offisielle skrivemåtar og sakshandsamingsinformasjon. Vedtekne skrivemåtar skal nyttast av det offentlege. Når eit namn ikkje er handsama etter reglane i lov om stadnamn, kan namnet ha fleire godkjende skrivemåtar. I slike tilfelle er det oppgjeve kva for ein godkjend skrivemåte som bør nyttast.</p> 
                    <p><a href="http://www.kartverket.no/Kart/Stedsnavn/">Les meir om stadnamn</a></p>
                </section>
                
                <xsl:apply-templates select="wfs:FeatureCollection/wfs:member/app:Sted" />
                
                <script src="js/jquery.min.js"></script>
                <script src="js/faktaark.js"></script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="app:Sted">
        <!-- Kva og kvar -->
        <section class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Kva og kvar</span>
                <span class="line"></span>
            </h2>
            <div class="ssr-table">
                <table>
                    <tbody>
                        <tr>
                            <th scope="row">Stedsnummer</th>
                            <td>
                                <xsl:value-of select="app:stedsnummer" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                Kommune<xsl:if test="count(app:kommune/app:Kommune) &gt; 1">r</xsl:if>
                            </th>
                            <td>
                                <ul>
                                    <xsl:for-each select="app:kommune/app:Kommune">
                                        <li><xsl:value-of select="app:kommunenavn" /> (<xsl:value-of select="app:kommunenummer" />), <xsl:value-of select="app:fylkesnavn" /></li>
                                    </xsl:for-each>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Vedtaksmynde</th>
                            <td>
                                <xsl:value-of select="app:vedtaksmyndighet" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Koordinater</th>
                            <td>
                                <xsl:value-of select="app:posisjon/gml:MultiPoint/gml:pointMember[1]/gml:Point/gml:pos" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Namnetype</th>
                            <td>
                                <span class="translate"><xsl:value-of select="app:navneobjekttype" /></span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Namnetype gruppe</th>
                            <td>
                                <span class="translate"><xsl:value-of select="app:navneobjektgruppe" /></span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Namnetype hovedgruppe</th>
                            <td>
                                <span class="translate"><xsl:value-of select="app:navneobjekthovedgruppe" /></span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Stadnamn og skrivemåten for stadnamn</span>
                <span class="line"></span>
            </h2>

            <div class="spellings">
                <xsl:for-each select="app:stedsnavn/app:Stedsnavn/app:skrivemåte/app:Skrivemåte">
                    <xsl:sort data-type="number" select="string-length(substring-before($språkprioritering, ../../app:språk))" />
                    <xsl:sort data-type="number" select="string-length(substring-before($skrivemåteprioritering, app:skrivemåtestatus))" />
                    <xsl:sort data-type="text" order="descending" select="app:prioritertSkrivemåte" />
                    <div class="spelling">
                        <div class="ssr-general">
                            <div class="row">
                                <div class="col none">
                                    <a class="js-toggle" data-closest=".spelling" href="#">
                                        <i class="fa fa-plus-circle fa-2x text-grey toggle-opened"></i>
                                        <i class="fa fa-minus-circle fa-2x text-grey toggle-closed"></i>
                                    </a>
                                </div>
                                <div class="col double">
                                    <dl>
                                        <dt>
                                            Skrivemåte
                                        </dt>
                                        <xsl:for-each select="app:kasuser/app:KasusForSkrivemåte">
                                            <dd>
                                                <div class="names">
                                                    <xsl:variable name="rekkefølgefiks" select="concat(../../app:rekkefølge, '-K-V-F')" />
                                                    <xsl:if test="app:kjernenavn != ''">
                                                        <span class="name" data-type="K">
                                                            <xsl:attribute name="style">order: <xsl:value-of select="string-length(substring-before($rekkefølgefiks, 'K'))" />;</xsl:attribute>
                                                            <xsl:value-of select="app:kjernenavn" />
                                                        </span>
                                                    </xsl:if>
                                                    <xsl:if test="app:variasjonstillegg != ''">
                                                        <span class="name" data-type="V">
                                                            <xsl:attribute name="style">order: <xsl:value-of select="string-length(substring-before($rekkefølgefiks, 'V'))" />;</xsl:attribute>
                                                            <xsl:value-of select="app:variasjonstillegg" />
                                                        </span>
                                                    </xsl:if>
                                                    <xsl:if test="app:funksjonstillegg != ''">
                                                        <span class="name" data-type="F">
                                                            <xsl:attribute name="style">order: <xsl:value-of select="string-length(substring-before($rekkefølgefiks, 'F'))" />;</xsl:attribute>
                                                            <xsl:value-of select="app:funksjonstillegg" />
                                                        </span>
                                                    </xsl:if>
                                                    <span class="case">
                                                        <span class="translate"><xsl:value-of select="app:kasusTilKjernenavn" /></span>
                                                    </span>
                                                </div>
                                            </dd>
                                        </xsl:for-each>
                                    </dl>
                                </div>
                                <div class="col half">
                                    <dl>
                                        <dt>
                                            Språk
                                        </dt>
                                        <dd>
                                            <span class="translate"><xsl:value-of select="../../app:språk" /></span>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="col">
                                    <dl>
                                        <dt>
                                            Namnesakstatus
                                        </dt>
                                        <dd>
                                            <span class="translate"><xsl:value-of select="../../app:navnesakstatus" /></span>
                                        </dd>
                                    </dl>
                                </div>
                                <div class="col">
                                    <dl>
                                        <dt>
                                            Skrivemåtestatus
                                        </dt>
                                        <dd>
                                            <xsl:call-template name="hent-skrivemåtestatus">
                                                <xsl:with-param name="skrivemåtestatus" select="app:skrivemåtestatus" />
                                                <xsl:with-param name="prioritertSkrivemåte" select="app:prioritertSkrivemåte" />
                                            </xsl:call-template>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                        <div class="ssr-shadow toggle">
                            
                            <div class="ssr-info open">
                                <div class="heading">
                                    <a class="js-toggle" data-closest=".ssr-info" href="#">
                                        <i class="fa fa-plus-circle closed"></i>
                                        <i class="fa fa-minus-circle opened"></i>
                                        Informasjon om skrivemåten
                                    </a>
                                </div>
                                <div class="body">
                                    <div class="ssr-columns">
                                        <dl>
                                            <dt>Stadnamn</dt>
                                            <dd>
                                                <xsl:value-of select="app:langnavn" />
                                            </dd>
                                            <dt>Stadnamnnummer</dt>
                                            <dd>
                                                <xsl:value-of select="../../../../app:stedsnummer" />
                                                <xsl:text>-</xsl:text>
                                                <xsl:value-of select="../../app:stedsnavnnummer" />
                                            </dd>
                                            <dt>Skrivemåtenr.</dt>
                                            <dd>
                                                <xsl:value-of select="../../../../app:stedsnummer" />
                                                <xsl:text>-</xsl:text>
                                                <xsl:value-of select="../../app:stedsnavnnummer" />
                                                <xsl:text>-</xsl:text>
                                                <xsl:value-of select="app:skrivemåtenummer" />
                                            </dd>
                                            <dt>Språk</dt>
                                            <dd>
                                                <span class="translate"><xsl:value-of select="../../app:språk" /></span>
                                            </dd>
                                            <dt>Opphavsspråk</dt>
                                            <dd>
                                                <span class="translate"><xsl:value-of select="../../app:opphavsspråk" /></span>
                                            </dd>
                                            <dt>Namnestatus</dt>
                                            <dd>
                                                <span class="translate"><xsl:value-of select="../../app:navnestatus" /></span>
                                            </dd>
                                            <dt>Vedtatt av</dt>
                                            <dd>
                                                <!--xsl:value-of select="$vedtaksmyndighet" /-->
                                            </dd>
                                            <dt>Statusdato</dt>
                                            <dd>
                                                <xsl:call-template name="formater-dato">
                                                    <xsl:with-param name="dato" select="app:statusdato" />
                                                </xsl:call-template>
                                            </dd>
                                            <dt>Namnesak dok.-nr.</dt>
                                            <dd>
                                                <xsl:apply-templates select="app:dokumentasjon/app:DokumenterVedtak" />
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </div>
                            <div class="ssr-info">
                                <div class="heading">
                                    <a class="js-toggle" data-closest=".ssr-info" href="#">
                                        <i class="fa fa-plus-circle closed"></i>
                                        <i class="fa fa-minus-circle opened"></i>
                                        Tilleggsopplysningar
                                    </a>
                                </div>
                                <div class="body">
                                    <div class="ssr-column">
                                        <xsl:for-each select="../../app:tilleggsopplysninger/app:Tilleggsopplysning">
                                            <dl>
                                                <dt>
                                                    <xsl:value-of select="app:tilleggsopplysningstype" />
                                                </dt>
                                                <dd>
                                                    <xsl:value-of select="app:tekst" />
                                                </dd>
                                            </dl>
                                        </xsl:for-each>
                                    </div>
                                </div>
                            </div>
                            <div class="ssr-info">
                                <div class="heading">
                                    <a class="js-toggle" data-closest=".ssr-info" href="#">
                                        <i class="fa fa-plus-circle closed"></i>
                                        <i class="fa fa-minus-circle opened"></i>
                                        Dokumentasjon på offentleg bruk
                                    </a>
                                </div>
                                <div class="body">
                                    <div class="ssr-docs">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Dokumentasjon</th>
                                                    <th>Offentleg</th>
                                                    <th>Kartbladnr.</th>
                                                    <th>Registrert dato</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <xsl:for-each select="app:dokumentasjon/*">
                                                    <xsl:sort select="app:registreringsdato" />
                                                    <tr>
                                                        <xsl:variable name="dokumentasjonstype" select="substring-after(name(.), ':')" />
                                                        <xsl:choose>
                                                            <xsl:when test="$dokumentasjonstype = 'Kartforekomst'">
                                                                <td>
                                                                    <xsl:value-of select="app:produktkode" />
                                                                </td>
                                                                <td>
                                                                    Ja
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:when test="$dokumentasjonstype = 'DokumentertVedtak' or $dokumentasjonstype = 'DokumentertKlage'">
                                                                <td>
                                                                    Dokumentert vedtak
                                                                </td>
                                                                <td>
                                                                    Ja
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:when test="$dokumentasjonstype = 'DokumentertSamlevedtak'">
                                                                <td>
                                                                    Dokumentert samlevedtak
                                                                </td>
                                                                <td>
                                                                    Ja
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:when test="$dokumentasjonstype = 'Dokument'">
                                                                <td>
                                                                    <xsl:value-of select="app:beskrivelse" />
                                                                </td>
                                                                <td>
                                                                    ?
                                                                </td>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td>
                                                                    <xsl:value-of select="app:id" /> (<xsl:value-of select="$dokumentasjonstype" />)
                                                                </td>
                                                                <td>
                                                                    -
                                                                </td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <td>
                                                            <xsl:value-of select="app:kartblad" />
                                                        </td>
                                                        <td>
                                                            <xsl:call-template name="formater-dato">
                                                                <xsl:with-param name="dato" select="app:registreringsdato" />
                                                            </xsl:call-template>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </xsl:for-each>
            </div>
        </section>
    </xsl:template>

    <xsl:template name="formater-dato">
        <xsl:param name="dato" />
        
        <xsl:value-of select="substring($dato, 9, 2)" />
        <xsl:text>. </xsl:text>
        
        <xsl:variable name="måned" select="substring($dato, 6, 2)" />
        <xsl:choose>
            <xsl:when test="$måned = '01'">
                <xsl:text>jan</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '02'">
                <xsl:text>feb</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '03'">
                <xsl:text>mar</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '04'">
                <xsl:text>apr</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '05'">
                <xsl:text>mai</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '06'">
                <xsl:text>jun</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '07'">
                <xsl:text>jul</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '08'">
                <xsl:text>aug</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '09'">
                <xsl:text>sep</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '10'">
                <xsl:text>okt</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '11'">
                <xsl:text>nov</xsl:text>
            </xsl:when>
            <xsl:when test="$måned = '12'">
                <xsl:text>des</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$måned" />
            </xsl:otherwise>
        </xsl:choose>

        <xsl:text> </xsl:text>
        <xsl:value-of select="substring($dato, 1, 4)" />
    </xsl:template>

    <xsl:template name="hent-skrivemåtestatus">
        <xsl:param name="skrivemåtestatus" />
        <xsl:param name="prioritertSkrivemåte" />
        
        <xsl:choose>
            <xsl:when test="$skrivemåtestatus = 'godkjent' and $prioritertSkrivemåte = 'true'">
                <i class="fa fa-circle text-green"></i>Godkjent og tilrådd
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'godkjent' and $prioritertSkrivemåte = 'false'">
                <i class="fa fa-circle text-orange"></i>Godkjent og ikkje tilrådd
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'vedtatt'">
                <i class="fa fa-circle text-green"></i>Vedtatt
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'vedtattNavneledd' and $prioritertSkrivemåte = 'true'">
                <i class="fa fa-circle text-green"></i>Vedtatt namneledd og tilrådd
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'vedtattNavneledd' and $prioritertSkrivemåte = 'false'">
                <i class="fa fa-circle text-orange"></i>Vedtatt namneledd og ikkje tilrådd
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'avslått'">
                <i class="fa fa-circle text-red"></i>Avslege
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'avslåttNavneledd'">
                <i class="fa fa-circle text-red"></i>Avslege namneledd
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'feilført'">
                <i class="fa fa-circle text-red"></i>Feilført
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'internasjonal'">
                <i class="fa fa-circle text-blue"></i>Internasjonalt
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'privat'">
                <i class="fa fa-circle text-yellow"></i>Privat
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'historisk'">
                <i class="fa fa-circle text-brown"></i>Historisk
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'foreslått'">
                <i class="fa fa-circle text-red"></i>Føreslege
            </xsl:when>
            <xsl:when test="$skrivemåtestatus = 'uvurdert'">
                <i class="fa fa-circle text-red"></i>Uvurdert
            </xsl:when>
            <xsl:otherwise>
                <i class="fa fa-circle text-grey"></i><xsl:value-of select="$skrivemåtestatus" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>


