<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 05/2023
	Dependancy:
		header - head
		style - generalStyle, bodyStyleCss, listStyleCss
		senderReceiver - senderReceiver
        recordTitle - SLSP-multilingual, SLSP-greeting
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="header.xsl" />
    <xsl:include href="senderReceiver.xsl" />
    <xsl:include href="mailReason.xsl" />
    <xsl:include href="footer.xsl" />
    <xsl:include href="style.xsl" />
    <xsl:include href="recordTitle.xsl" />

<!-- Prints the IZ message stored in label 'department' for the language of the letter.
		If value in the label is empty or with value "blank" does not print anything.
		The label can contain also HTML markup such as links or formatting.
		Usage:
			1. Configure the label department with text in all languages.
			2. <<already done by SLSP in this letter>>Insert the template: <xsl:call-template name="SLSP-IZMessage"/> -->
<xsl:template name="SLSP-IZMessage">
	<xsl:variable name="notice">@@department@@</xsl:variable>
	<xsl:if test="$notice != '' and $notice != 'blank'">
		<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
			<xsl:with-param name="en" select="'Notice of the library'"/>
			<xsl:with-param name="fr" select="'Avis de la bibliothèque'"/>
			<xsl:with-param name="it" select="'Comunicazione della biblioteca'"/>
			<xsl:with-param name="de" select="'Notiz der Bibliothek'"/>
		</xsl:call-template>:</strong>&#160;<xsl:value-of select="$notice" disable-output-escaping="yes" />
	</xsl:if>
</xsl:template>

    <xsl:template match="/">
        <html>
            <xsl:if test="notification_data/languages/string">
                <xsl:attribute name="lang">
                    <xsl:value-of select="notification_data/languages/string"/>
                </xsl:attribute>
            </xsl:if>

            <head>
                <title>
                    <xsl:value-of select="notification_data/general_data/subject"/>
                </title>

                <xsl:call-template name="generalStyle" />
            </head>
            <body>
                <xsl:attribute name="style">
                    <xsl:call-template name="bodyStyleCss" />;font-size: 100%;
                </xsl:attribute>
                <xsl:call-template name="head" /><!-- header.xsl -->

                <div class="messageArea">
                    <div class="messageBody">
                        <table role='presentation' cellspacing="0" cellpadding="5" border="0">
                            <xsl:for-each select="notification_data/receivers/receiver/user">
                                <tr>
                                    <td>
                                        <br />
                                        <xsl:if test="user_group = '92'">
                                            <strong>
                                                <xsl:call-template name="SLSP-multilingual">
                                                    <xsl:with-param name="en" select="'Special user cantonal library'"/>
                                                    <xsl:with-param name="fr" select="'Utilisateur spécial bibliothèque cantonale'"/>
                                                    <xsl:with-param name="it" select="'Utente speciale biblioteca cantonale'"/>
                                                    <xsl:with-param name="de" select="'Spezialnutzende Kantonsbibliothek'"/>
                                                </xsl:call-template>
                                            </strong>
                                            <br />
                                        </xsl:if>
                                        <xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/>
                                    <br />
                                    <!-- set the barcode values in variables -->
                                    <!-- set the Barcode NZ, if there are more then only first one is returned -->
                                    <xsl:variable name="NZ_barcode">
                                        <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
                                    </xsl:variable>
                                    <!-- set the Barcode edu-ID, if there are more then only first one is returned -->
                                    <xsl:variable name="edu-id_barcode">
                                        <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
                                    </xsl:variable>
                                    <!-- set the Barcode IZ, if there are more then only first one is returned -->
                                    <xsl:variable name="IZ_barcode">
                                        <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='03']/value"/>
                                    </xsl:variable>
                                    <!-- set the barcode values in variables -->

                                    <xsl:call-template name="SLSP-multilingual">
                                        <xsl:with-param name="en" select="'User ID'"/>
                                        <xsl:with-param name="fr" select="'ID utilisateur'"/>
                                        <xsl:with-param name="it" select="'ID utente'"/>
                                        <xsl:with-param name="de" select="'Benutzer-ID'"/>
                                    </xsl:call-template>: 
                                    <xsl:choose>
                                        <xsl:when test="$edu-id_barcode != ''">
                                            <xsl:value-of select="$edu-id_barcode"/>
                                            <br />
                                        </xsl:when>
                                        <xsl:when test="$NZ_barcode != ''">
                                            <xsl:value-of select="$NZ_barcode"/>
                                            <br />
                                        </xsl:when>
                                        <xsl:when test="$IZ_barcode != ''">
                                            <xsl:value-of select="$IZ_barcode"/>
                                            <br />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td>
                                <br />
                                <xsl:call-template name="SLSP-greeting" />
                            </td>
                        </tr>
                        <xsl:choose>
                            <xsl:when test="notification_data/success='true'">
                                <!--<td>@@on@@ <xsl:value-of select="notification_data/general_data/current_date"/> @@we_renewed_y_req_from@@ <xsl:value-of select="notification_data/outgoing/create_date"/> @@detailed_below@@ :</td>-->
                                <tr>
                                    <td>@@renewed_loan@@:</td>
                                </tr>
                            </xsl:when>
                            <xsl:otherwise>
                                <td>@@not_renewed_loan@@:</td>
                            </xsl:otherwise>
                        </xsl:choose>
                        <tr>
                            <td>
                                <xsl:call-template name="recordTitle" />
                            </td>
                        </tr>
                        <xsl:choose>
                            <xsl:when test="notification_data/success='true'">
                                <tr>
                                    <td>@@new_due_date@@: <xsl:value-of select="notification_data/item_loan_due_date"/></td>
                                </tr>

                                <tr>
                                    <td>
                                        <strong>@@success_reason@@</strong>
                                    </td>
                                </tr>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="notification_data/note != ''">
                                        <tr>
                                            <td>
                                                <strong>@@failure_reason@@: <xsl:value-of select="notification_data/note"/></strong>
                                            </td>
                                        </tr>
                                    </xsl:when>
                                </xsl:choose>
                                <tr>
                                    <td>
                                        <strong>@@contact_dep@@</strong>
                                    </td>
                                </tr>
                            </xsl:otherwise>
                        </xsl:choose>
                        <tr>
                            <td>
                                <xsl:call-template name="SLSP-IZMessage"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                                @@sincerely@@
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <xsl:value-of select="/notification_data/organization_unit/name"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br/>
                                <i>powered by SLSP</i>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- <xsl:call-template name="lastFooter" /> -->
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>