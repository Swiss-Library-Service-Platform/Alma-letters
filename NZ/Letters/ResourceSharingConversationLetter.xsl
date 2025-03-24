<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 02/2025
    02/2025 - SLSP salutation, metadata erased from the body, metadata extracted from the letter XML
    03/2025 - added new line after message heading
    Dependance:
        header.xsl - head
        style - bodyStyleCss, generalStyle, mainTableStyleCss
        recordTitle - SLSP-greeting-ILL, SLSP-multilingual
 -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings"

xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:include href="header.xsl"/>
    <xsl:include href="senderReceiver.xsl"/>
    <xsl:include href="mailReason.xsl"/>
    <xsl:include href="footer.xsl"/>
    <xsl:include href="style.xsl"/>
    <xsl:include href="recordTitle.xsl"/>

<!-- replace template -->
    <xsl:template name="replace">
        <xsl:param name="text"/>
        <xsl:param name="search"/>
        <xsl:param name="replace"/>
        <xsl:choose>
            <xsl:when test="contains($text, $search)">
                <xsl:value-of select="substring-before($text, $search)"/>
                <xsl:value-of select="$replace"/>
                <xsl:call-template name="replace">
                    <xsl:with-param name="text" select="substring-after($text, $search)"/>
                    <xsl:with-param name="search" select="$search"/>
                    <xsl:with-param name="replace" select="$replace"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="printBody">
        <!-- <xsl:value-of select="/notification_data/body" /> -->
        <!-- Replace <br/> with ||| -->
        <xsl:variable name="bodyContent">
            <xsl:call-template name="replace">
                <xsl:with-param name="text" select="/notification_data/body"/>
                <xsl:with-param name="search" select="'&lt;br/&gt;'"/>
                <xsl:with-param name="replace" select="'|||'"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- <xsl:value-of select="$bodyContent" /> -->
        <xsl:for-each select="str:tokenize($bodyContent, '|||')">
            <xsl:if test="not(starts-with(., 'Title:') or starts-with(., 'ISBN:') or starts-with(., 'ISSN:') or starts-with(., 'External identifier:') or starts-with(., 'by:') or starts-with(., 'OCLC'))">
                <xsl:value-of select="." disable-output-escaping="yes"/>
                &lt;br/&gt;
            </xsl:if>
        </xsl:for-each>
        
    </xsl:template>

    <!-- Template to print the partner address from the conversation letter XML -->
    <xsl:template name="senderReceiver-conversation">
        <table cellspacing="0" border="0" width="100%">
            <tr>
                <td width="50%"  align="left"></td>
                <td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm;">
                    <table cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            font-weight: 600;font-size: 10pt;
                            <xsl:call-template name="listStyleCss" />
                            <!-- style.xsl -->
                        </xsl:attribute>
                    <!-- <xsl:if test="notification_data/partner_name_and_inst !=''">
                        <tr>
                            <td>
                                <br/>
                                <xsl:value-of select="/notification_data/partner_name_and_inst"/>
                            </td>
                        </tr>
                    </xsl:if> -->
                        <xsl:if test="notification_data/rapid_partner_address !=''">
                            <tr>
                                <td>
                                    <br/>
                                    <xsl:value-of select="notification_data/rapid_partner_address"/>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/line1 !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line1" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/line2 !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line2" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/line3 !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line3" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/line4 !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line4" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/line5 !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/line5" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/city !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/city" />
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="notification_data/partner_address/country !=''">
                            <tr>
                                <td>
                                    <xsl:value-of select="notification_data/partner_address/country" />
                                </td>
                            </tr>
                        </xsl:if>
                    </table>
                </td>
            </tr>
        </table>
    </xsl:template>

    <!-- Template to print the request metadata from the XML node request_metadata in lending or borrowing node
    <<<< the parsing does not work, need to do it the old way with str-before and str-after >>>>
    The template extracts the content of the <request_metadata> node.-->
    <xsl:template name="printMetadataXML">
        <xsl:variable name="requestMetadataContent" select="//request_metadata"/>
        <br />
        <!-- Extract the title, creator, imprint (place of publication, date, publisher) and ISBN/ISSN from the $requestMetadataContent XML using substring-after and substring-before -->
        <xsl:variable name="title" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:title&gt;'), '&lt;/dc:title&gt;')"/>
        <xsl:variable name="creator" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:creator&gt;'), '&lt;/dc:creator&gt;')"/>
        <xsl:variable name="publisher" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:publisher&gt;'), '&lt;/dc:publisher&gt;')"/>
        <xsl:variable name="place" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:rlterms_placeOfPublication&gt;'), '&lt;/dc:rlterms_placeOfPublication&gt;')"/>
        <xsl:variable name="date" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:date&gt;'), '&lt;/dc:date&gt;')"/>
        <xsl:variable name="isbn" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:identifier_isbn&gt;'), '&lt;/dc:identifier_isbn&gt;')"/>
        <xsl:variable name="issn" select="substring-before(substring-after($requestMetadataContent, '&lt;dc:identifier_issn&gt;'), '&lt;/dc:identifier_issn&gt;')"/>
        <!-- print the variables -->
        <xsl:if test="$title != ''">
            <strong><xsl:value-of select="$title"/></strong>
        </xsl:if>
        <xsl:if test="$creator != ''">
            <br/>
            <xsl:value-of select="$creator"/>
        </xsl:if>
        <br />
        <xsl:value-of select="$place" />:&#160;<xsl:value-of select="$publisher" />,&#160;<xsl:value-of select="$date" />
        <xsl:if test="$isbn != ''">
            <br/>
            <strong>ISBN:</strong>&#160;<xsl:value-of select="$isbn"/>
        </xsl:if>
        <xsl:if test="$issn != ''">
            <br/>
            <strong>ISSN:</strong>&#160;<xsl:value-of select="$issn"/>
        </xsl:if>
    </xsl:template>

<!-- Template to print the request metadata from the body of the message
    Deprecated: the body does not contain the metadata if the user deletes it-->
    <xsl:template name="printMetadataBody">
    <!-- test if the message is generated from lending request -->
    <!-- <xsl:variable name="lending" select="boolean(normalize-space(/notification_data/lending))" /> -->
    
    <xsl:variable name="bodyContent">
        <xsl:call-template name="replace">
            <xsl:with-param name="text" select="/notification_data/body"/>
            <xsl:with-param name="search" select="'&lt;br/&gt;'"/>
            <xsl:with-param name="replace" select="'|||'"/>
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="bodyTokenized" select="str:tokenize($bodyContent, '|||')"/>
    <xsl:variable name="bodyTitle" select="$bodyTokenized[starts-with(., 'Title:')]"/>
    <xsl:variable name="bodyISBN" select="$bodyTokenized[starts-with(., 'ISBN:')]"/>
    <xsl:variable name="bodyExternalId" select="$bodyTokenized[starts-with(., 'External identifier:')]"/>
    <xsl:variable name="bodyAuthor" select="$bodyTokenized[starts-with(., 'by:')]"/>
    <xsl:variable name="bodyOtherId" select="$bodyTokenized[starts-with(., 'OCLC:')]"/>
    <xsl:if test="$bodyTitle != ''">
        <!-- remove the "Title:" from the bodyTitle -->
        <xsl:variable name="bodyTitleClean" select="substring-after($bodyTitle, 'Title: ')"/>
        <strong><xsl:value-of select="$bodyTitleClean"/></strong>
    </xsl:if>
    <xsl:if test="$bodyAuthor != ''">
        <!-- remove the "by:" from the bodyAuthor -->
        <xsl:variable name="bodyAuthorClean" select="substring-after($bodyAuthor, 'by: ')"/>
        <br/>
        <strong><xsl:call-template name="SLSP-multilingual">
            <xsl:with-param name="en" select="'Author'"/>
            <xsl:with-param name="fr" select="'Auteur'"/>
            <xsl:with-param name="it" select="'Autore'"/>
            <xsl:with-param name="de" select="'Autor'"/>
        </xsl:call-template>:</strong>&#160;<xsl:value-of select="$bodyAuthorClean"/>
    </xsl:if>
    <xsl:if test="$bodyISBN != ''">
        <!-- remove the "ISBN:" from the bodyISBN -->
        <xsl:variable name="bodyISBNClean" select="substring-after($bodyISBN, 'ISBN: ')"/>
        <br/>
        <strong><xsl:call-template name="SLSP-multilingual">
            <xsl:with-param name="en" select="'ISBN'"/>
            <xsl:with-param name="fr" select="'ISBN'"/>
            <xsl:with-param name="it" select="'ISBN'"/>
            <xsl:with-param name="de" select="'ISBN'"/>
        </xsl:call-template>:</strong>&#160;<xsl:value-of select="$bodyISBNClean"/>
    </xsl:if>
    <xsl:if test="$bodyExternalId != ''">
        <!-- remove the "External identifier:" from the bodyExternalId -->
        <xsl:variable name="bodyExternalIdClean" select="substring-after($bodyExternalId, 'External identifier: ')"/>
        <br/>
        <strong><xsl:call-template name="SLSP-multilingual">
            <xsl:with-param name="en" select="'Request ID'"/>
            <xsl:with-param name="fr" select="'Identifiant de la demande'"/>
            <xsl:with-param name="it" select="'ID richiesta'"/>
            <xsl:with-param name="de" select="'Bestell-ID'"/>
        </xsl:call-template>:</strong>&#160;<xsl:value-of select="$bodyExternalIdClean"/>
    </xsl:if>

    
    <!-- <xsl:for-each select="$bodyTokenized">
        <xsl:if test="not(starts-with(., 'Title:') or starts-with(., 'ISBN:') or starts-with(., 'External identifier:') or starts-with(., 'by:') or starts-with(., 'OCLC'))">
            <xsl:value-of select="." disable-output-escaping="yes"/>
            <br/>
        </xsl:if>
    </xsl:for-each> -->
    
        <!-- <xsl:variable name="requestNode">
            <xsl:choose>
                <xsl:when test="/notification_data/lending">
                    <xsl:value-of select="/notification_data/lending"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="/notification_data/borrowing"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable> -->
        <!-- <xsl:value-of select="$requestNode/active_messages"/> -->
        
    </xsl:template>

    <xsl:template match="/">
        <html>
            <xsl:if test="notification_data/languages/string">
                <xsl:attribute name="lang">
                    <xsl:value-of select="notification_data/languages/string"/>
                </xsl:attribute>
            </xsl:if>

            <head>
                <xsl:call-template name="generalStyle"/>
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss" />;font-size: 100%;
                </xsl:attribute>
                <xsl:call-template name="head"/>
                <xsl:call-template name="senderReceiver-conversation"/>
                <div class="messageArea">
                    <div class="messageBody">
                        <p>
                            <xsl:call-template name="SLSP-greeting-ILL"/> <!-- recordTitle -->
                        </p>
                        <p>
                            <xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
                                <xsl:with-param name="en" select="'The library has sent you a message regarding the resource sharing request below.'"/>
                                <xsl:with-param name="fr">
                                    <![CDATA[La bibliothèque vous a envoyé un message concernant la commande de prêt à distance ci-dessous.]]>
                                </xsl:with-param>
                                <xsl:with-param name="it" select="'La biblioteca vi ha inviato un messaggio relativo alla richiesta di prestito interbibliotecario sotto riportata.'"/>
                                <xsl:with-param name="de" select="'Die Bibliothek hat Ihnen eine Meldung bezüglich der untenstehenden Fernleihbestellung geschickt.'"/>
                            </xsl:call-template>
                        </p>
                        <p>
                            <xsl:call-template name="printMetadataXML"/>
                            <xsl:variable name="requestId" select="//external_request_id"/>
                            <xsl:if test="$requestId != ''">
                                <br/>
                                <strong><xsl:call-template name="SLSP-multilingual">
                                    <xsl:with-param name="en" select="'Request ID'"/>
                                    <xsl:with-param name="fr" select="'Identifiant de la demande'"/>
                                    <xsl:with-param name="it" select="'ID richiesta'"/>
                                    <xsl:with-param name="de" select="'Bestell-ID'"/>
                                </xsl:call-template>:</strong>&#160;<xsl:value-of select="$requestId"/>
                            </xsl:if>
                        </p>
                        <xsl:variable name="bodyMsg">
                            <xsl:call-template name="printBody"/>
                        </xsl:variable>
                        <xsl:if test="$bodyMsg !=''">
                            <p>
                                <strong><xsl:call-template name="SLSP-multilingual">
                                <xsl:with-param name="en" select="'The message'"/>
                                <xsl:with-param name="fr" select="'Le message'"/>
                                <xsl:with-param name="it" select="'Il messaggio'"/>
                                <xsl:with-param name="de" select="'Die Meldung'"/>
                            </xsl:call-template>:</strong><br/>
                                <xsl:value-of select="$bodyMsg" disable-output-escaping="yes"/>
                            </p>
                        </xsl:if>
                        
                        <br/>

                        <p>
                            @@signature@@
                        </p>
                        <p>
                            <xsl:value-of select="notification_data/organization_unit/name"/>
                        </p>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
