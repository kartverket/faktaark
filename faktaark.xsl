<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:app="http://skjema.geonorge.no/SOSI/produktspesifikasjon/Stedsnavn/5.0"
 xmlns:gml="http://www.opengis.net/gml/3.2"
 xmlns:wfs="http://www.opengis.net/wfs/2.0"
>
    <xsl:variable name="vedtaksmyndighet" select="/wfs:FeatureCollection/wfs:member/app:Sted/app:vedtaksmyndighet" />
    <xsl:variable name="kommune">
        <xsl:apply-templates select="/wfs:FeatureCollection/wfs:member/app:Sted/app:kommune" />
    </xsl:variable>
    <xsl:template match="app:kommune">
        <ul>
            <xsl:for-each select="app:Kommune">
                <li><xsl:value-of select="app:kommunenavn" /> (<xsl:value-of select="app:kommunenummer" />), <xsl:value-of select="app:fylkesnavn" /></li>
            </xsl:for-each>
        </ul>
    </xsl:template>



    <xsl:template match="/">
        <html>
            <head>
                <meta content="utf-8" />
                <meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
                <title>Faktaark - Kartverket</title>
                <link href="css/faktaark.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <xsl:apply-templates select="wfs:FeatureCollection/wfs:member/app:Sted" />
                <script src="js/faktaark.js"></script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="app:Sted">
        <div class="wrapper">
            <h1 class="kv-heading">
                <span class="text">Faktaark</span>
                <span class="line"></span>
            </h1>
            <p>Eit stadnamn er namnet på ein lokalitet. Stadnamn skal skrivast på bestemte måtar. Lov om stadnamn beskriv prosessane for fastsetjing av skrivemåten og bruken av stadnamn. Kartverket driftar Sentralt stadnamnregister (SSR), som inneheld offisielle skrivemåtar og sakshandsamingsinformasjon. Vedtekne skrivemåtar skal nyttast av det offentlege. Når eit namn ikkje er handsama etter reglane i lov om stadnamn, kan namnet ha fleire godkjende skrivemåtar. I slike tilfelle er det oppgjeve kva for ein godkjend skrivemåte som bør nyttast.</p> 
            <p><a href="http://www.kartverket.no/Kart/Stedsnavn/">Les meir om stadnamn</a></p>
            <p><xsl:value-of select="app:språkprioritering" /></p>
        </div>

        <div class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Stadnamn og skrivemåten for stadnamn</span>
                <span class="line"></span>
            </h2>
            <button id="foo" type="button">FOO</button>
            <button id="foobar" type="button">FOOBAR</button>
            <div class="ssr-table">
                <table>
                    <thead>
                        <tr>
                            <th>Namn og skrivemåtar</th>
                            <th>Språk</th>
                            <th>Kasus</th>
                            <th>Navnesakstatus</th>
                            <th>Skrivemåtestatus</th>
                        </tr>
                    </thead>
                    <tbody id="bar">
                        <xsl:apply-templates select="app:stedsnavn/app:Stedsnavn/app:skrivemåte/app:Skrivemåte/app:kasuser/app:KasusForSkrivemåte" />
                    </tbody>
                </table>
            </div>
        </div>

        <div class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Kva og kvar</span>
                <span class="line"></span>
            </h2>
            <div class="ssr-foo">
                <table>
                    <tbody>
                        <tr>
                            <th scope="row">Stedsnummer</th>
                            <td>
                                <xsl:value-of select="app:stedsnummer" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Kommune(r)</th>
                            <td>
                                <xsl:copy-of select="$kommune" />
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
                                <xsl:value-of select="app:navneobjekttype" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Namnetype gruppe</th>
                            <td>
                                <xsl:value-of select="app:navneobjektgruppe" />
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Namnetype hovedgruppe</th>
                            <td>
                                <xsl:value-of select="app:navneobjekthovedgruppe" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Informasjon om skrivemåten</span>
                <span class="line"></span>
            </h2>
            <div class="ssr-foo">
                <xsl:apply-templates select="app:stedsnavn/app:Stedsnavn/app:skrivemåte/app:Skrivemåte">
                    <xsl:sort select="../../app:stedsnavnnummer" data-type="number" />
                </xsl:apply-templates>
            </div>
        </div>

        <div class="wrapper">
            <h2 class="kv-heading">
                <span class="text">Dokumentasjon på offentleg bruk</span>
                <span class="line"></span>
            </h2>
            <div class="ssr-table">
                <table>
                    <thead>
                        <tr>
                            <th>Namn</th>
                            <th>Dokumentasjon</th>
                            <th>Kommune(r)</th>
                            <th>Kartbladnr.</th>
                            <th>Registrert dato</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="app:stedsnavn/app:Stedsnavn/app:skrivemåte/app:Skrivemåte/app:dokumentasjon/*" />
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="app:KasusForSkrivemåte">
        <tr>
            <xsl:attribute name="id">ssr-row-<xsl:value-of select="position()" /></xsl:attribute>
            <td>
                <xsl:value-of select="app:kjernenavn" /> (<xsl:value-of select="position()" />)
            </td>
            <td>
                <xsl:call-template name="hent-språk">
                    <xsl:with-param name="språk" select="../../../../app:språk" />
                </xsl:call-template>
            </td>
            <td>
                <span class="translate"><xsl:value-of select="app:kasusTilKjernenavn" /></span>
            </td>
            <td>
                <span class="translate"><xsl:value-of select="../../../../app:navnesakstatus" /></span>
            </td>
            <td>
                <xsl:call-template name="hent-skrivemåtestatus">
                    <xsl:with-param name="skrivemåtestatus" select="../../app:skrivemåtestatus" />
                </xsl:call-template>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="app:Skrivemåte">
        <table>
            <caption>
                <xsl:value-of select="app:langnavn" />
            </caption>
            <tbody>
                <tr>
                    <th scope="row">Stadnamnnummer</th>
                    <td>
                        <xsl:value-of select="../../../../app:stedsnummer" />
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="../../app:stedsnavnnummer" />
                    </td>
                </tr>
                <tr>
                    <th scope="row">Stadnamn</th>
                    <td>
                        <xsl:value-of select="app:langnavn" />
                    </td>
                </tr>
                <tr>
                    <th scope="row">Namnestatus</th>
                    <td>
                        <span class="translate"><xsl:value-of select="../../app:navnestatus" /></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Navnesakstatus</th>
                    <td>
                        <span class="translate"><xsl:value-of select="../../app:navnesakstatus" /></span>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Språk</th>
                    <td>
                        <xsl:call-template name="hent-språk">
                            <xsl:with-param name="språk" select="../../app:språk" />
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Opphavsspråk</th>
                    <td>
                        <xsl:call-template name="hent-språk">
                            <xsl:with-param name="språk" select="../../app:opphavsspråk" />
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Vedtatt av</th>
                    <td>
                        <xsl:value-of select="$vedtaksmyndighet" />
                    </td>
                </tr>
                <tr>
                    <th scope="row">Status</th>
                    <td>
                        <xsl:call-template name="hent-skrivemåtestatus">
                            <xsl:with-param name="skrivemåtestatus" select="app:skrivemåtestatus" />
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Statusdato</th>
                    <td>
                        <xsl:call-template name="formater-dato">
                            <xsl:with-param name="dato" select="app:statusdato" />
                        </xsl:call-template>
                    </td>
                </tr>
                <tr>
                    <th scope="row">Skrivemåtenr.</th>
                    <td>
                        <xsl:value-of select="../../../../app:stedsnummer" />
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="../../app:stedsnavnnummer" />
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="app:skrivemåtenummer" />
                    </td>
                </tr>
                <tr>
                    <th scope="row">Namnesak dok.-nr.</th>
                    <td>
                        <xsl:apply-templates select="app:dokumentasjon/app:DokumenterVedtak" />
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="app:dokumentasjon/*">
        <tr>
            <td>
                <span class="ssr-table-label">Namn</span>
                <xsl:value-of select="../../app:langnavn" />
            </td>
            <td>
                <span class="ssr-table-label">Dokumentasjon</span>
                <xsl:value-of select="app:beskrivelse" />
            </td>
            <td>
                <span class="ssr-table-label">Kommune(r)</span>
                <xsl:copy-of select="$kommune" />
            </td>
            <td>
                <span class="ssr-table-label">Kartbladnr.</span>
                <xsl:value-of select="app:id" />
            </td>
            <td>
                <span class="ssr-table-label">Registrert dato</span>
                <xsl:value-of select="name(.)" />
            </td>
        </tr>
    </xsl:template>






    <xsl:template name="hent-skrivemåtestatus">
        <xsl:param name="skrivemåtestatus" />
        <a class="ssr-status" href="http://www.kartverket.no/kart/stedsnavn/sentralt-stadnamnregister-ssr/saksbehandlingsstatus-for-skrivematen/" target="_blank">
            <xsl:choose>
                <xsl:when test="$skrivemåtestatus = 'vedtatt'">
                    <span class="icon green"></span>
                    <span class="text">Vedtak</span>
                </xsl:when>
                <xsl:when test="$skrivemåtestatus = 'godkjent'">
                    <span class="icon green"></span>
                    <span class="text">Godkjent</span>
                </xsl:when>
                <xsl:when test="$skrivemåtestatus = 'avslått'">
                    <span class="icon red"></span>
                    <span class="text">Avslege</span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="icon grey"></span>
                    <span class="text">
                        <xsl:value-of select="$skrivemåtestatus" />
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>

    <xsl:template match="app:DokumenterVedtak">
        <xsl:value-of select="app:dokument/app:DokumentIdent/app:år" />
        <xsl:text>/</xsl:text>
        <xsl:value-of select="app:dokument/app:DokumentIdent/app:saksnummer" />
        <xsl:text>/</xsl:text>
        <xsl:value-of select="app:arkivløpenummer" />
    </xsl:template>

    <xsl:template name="hent-språk">
        <xsl:param name="språk" />

        <xsl:choose>
            <xsl:when test="$språk = 'nor'">
                <xsl:text>Norsk</xsl:text>
            </xsl:when>
            <xsl:when test="$språk = 'sme'">
                <xsl:text>Nordsamisk</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$språk" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="formater-dato">
        <xsl:param name="dato" />
        
        <xsl:value-of select="substring($dato, 9, 2)" />
        <xsl:text>. </xsl:text>
        
        <xsl:variable name="måned" select="substring($dato, 6, 2)" />
        <xsl:choose>
            <xsl:when test="$måned = '01'">
                <xsl:text>januar</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$måned" />
            </xsl:otherwise>
        </xsl:choose>

        <xsl:text> </xsl:text>
        <xsl:value-of select="substring($dato, 1, 4)" />
    </xsl:template>

</xsl:stylesheet>