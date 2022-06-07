<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP version 05/2022
        04/2022 hidden due and arrival dates
        04/2022 reorganized the presentation of data
        04/2022 added pickup library name
        04/2022 added user address from senderReceiver -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!-- template to show link to user account
	for link to swisscovery uses system variable @@email_my_account@@ in Configuration -> General -> Other Settings
	one link per IZ is possible, therefore the default view is used.
	The lang parameter for URL is used from the user preferred language
	Depends on:
		recordTitle - SLSP-multilingual
	USAGE: <xsl:call-template name="SLSP-userAccount"/>
	 -->
<xsl:template name="SLSP-userAccount-request">
	<xsl:call-template name="SLSP-multilingual">
		<xsl:with-param name="en" select="'To check your current loans, requests and fees that have not yet been invoiced please login at swisscovery: '"/>
		<!-- Adaptation to include single quote in "n'ont" in the text -->
		<xsl:with-param name="fr">
			<![CDATA[Pour consulter vos prêts en cours, vos demandes et les frais qui n'ont pas encore été facturés, veuillez vous connecter à swisscovery: ]]>
		</xsl:with-param>
		<xsl:with-param name="it" select="'Per controllare i suoi prestiti attuali, le richieste e i costi non ancora fatturati, effettui il login su swisscovery: '"/>
		<xsl:with-param name="de" select="'Um Ihre aktuellen Ausleihen, Bestellungen und noch nicht in Rechnung gestellten Gebühren zu überprüfen, loggen Sie sich bitte bei swisscovery ein: '"/>
	</xsl:call-template>
	<a>
		<xsl:attribute name="href">@@email_my_account@@&#38;lang=<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/>
		</xsl:attribute>
		<xsl:attribute name="target">
			_blank
		</xsl:attribute>
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'My account'"/>
			<xsl:with-param name="fr" select="'Mon compte'"/>
			<xsl:with-param name="it" select="'Il mio conto'"/>
			<xsl:with-param name="de" select="'Mein Konto'"/>
		</xsl:call-template>
	</a>
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
                <xsl:call-template name="bodyStyleCss" />
                <!-- style.xsl -->
            </xsl:attribute>
            <xsl:call-template name="head" />
            <!-- header.xsl -->
            <xsl:call-template name="senderReceiver" />
            <!-- SenderReceiver.xsl -->

            <div class="messageArea">
                <div class="messageBody">
                    <table role='presentation'  cellspacing="0" cellpadding="0" border="0">
                        <xsl:attribute name="style">
                            <xsl:call-template name="listStyleCss"/>
                            <!-- style.xsl -->
                        </xsl:attribute>
                        <tr>
                            <td style="padding-bottom: 10px">
                                @@header@@
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                @@start@@
                            </td>
                        </tr>
                        <xsl:for-each select="notification_data/display">
                            <xsl:if test="title !='' and journal_title = ''">
                                <tr>
                                    <td>
                                        <strong><xsl:value-of select="title"/></strong>
                                        <xsl:if test="author !=''">
                                            <br />
                                            <xsl:choose>
                                                <xsl:when test="contains(author, '$$Q')">
                                                    <xsl:value-of select="substring-after(author, '$$Q')"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="author"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:if>
                                        <xsl:if test="place_of_publication != '' and publisher != '' and publication_date != ''">
                                            <br /><xsl:value-of select="place_of_publication"/>:&#160;<xsl:value-of select="publisher"/>,&#160;<xsl:value-of select="publication_date"/>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="journal_title !=''">
                                <tr>
                                    <td>
                                        <strong> @@journalTitle@@: </strong>
                                        <xsl:value-of select="journal_title"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <strong> @@articleTitle@@: </strong>
                                        <xsl:value-of select="title"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="chapter_title !='' and composer = null and opus = null and song_movement = null and music_part = null">
                                <tr>
                                    <td>
                                        <strong> @@chapterTitle@@: </strong>
                                        <xsl:value-of select="chapter_title"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            
                            <xsl:if test="chapter_author !=''">
                                <tr>
                                    <td>
                                        <strong> @@chapterAuthor@@: </strong>
                                        <xsl:value-of select="chapter_author"/>
                                    </td>
                                </tr>
                            </xsl:if>				
                            <xsl:if test="chapter !=''">
                                <tr>
                                    <td>
                                        <strong> @@chapterNumber@@: </strong>
                                        <xsl:value-of select="chapter"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="/notification_data/volume !=''">
                                <tr>
                                    <td>
                                        <strong> @@volume@@: </strong>
                                        <xsl:value-of select="/notification_data/volume"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="issue !=''">
                                <tr>
                                    <td>
                                        <strong> @@issue@@: </strong>
                                        <xsl:value-of select="issue"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="pages !=''">
                                <tr>
                                    <td>
                                        <strong> @@pages@@: </strong>
                                        <xsl:value-of select="pages"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="pages = '' and (start_page !='' or end_page !='')">
                                <tr>
                                    <td>
                                        <strong> @@pages@@: </strong>
                                        <xsl:if test="start_page !=''">
                                            <xsl:value-of select="start_page"/>
                                        </xsl:if>
                                        -
                                        <xsl:if test="end_page !=''">
                                            <xsl:value-of select="end_page"/>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="composer !=''">
                                <tr>
                                    <td>
                                        <strong> @@composer@@: </strong>
                                        <xsl:value-of select="composer"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="opus !=''">
                                <tr>
                                    <td>
                                        <strong> @@opus@@: </strong>
                                        <xsl:value-of select="opus"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="song_movement !=''">
                                <tr>
                                    <td>
                                        <strong> @@songMovement@@: </strong>
                                        <xsl:value-of select="song_movement"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <xsl:if test="music_part !=''">
                                <tr>
                                    <td>
                                        <strong> @@part@@: </strong>
                                        <xsl:value-of select="music_part"/>
                                    </td>
                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                        <tr>
                            <td style="padding-bottom: 10px; padding-top: 10px;">
                                <strong> @@internalIdentifier@@: </strong>
                                <xsl:value-of select="notification_data/request_id"/>
                                <xsl:if test="notification_data/request/external_request_id !=''">
                                    <br /><strong> @@externalIdentifier@@: </strong>
                                    <xsl:value-of select="notification_data/request/external_request_id"/>
                                </xsl:if>
                                <xsl:if test="notification_data/pickup_location !='' and notification_data/format != 'Digital'">
                                    <br /><strong> @@pickupLocation@@: </strong>
                                    <xsl:value-of select="notification_data/pickup_location"/>
                                </xsl:if>
                                <xsl:if test="notification_data/format !=''">
                                    <br /><strong> @@format@@: </strong>
                                    <xsl:value-of select="notification_data/format"/>
                                </xsl:if>
                                <!-- <xsl:if test="notification_data/arrival_date !=''">
                                    <br /><strong> @@arrivalDate@@: </strong>
                                    <xsl:value-of select="notification_data/arrival_date"/>
                                </xsl:if> -->
                                <xsl:if test="notification_data/patron_cost !=''">
                                    <br /><strong> @@cost@@: </strong>
                                    <xsl:value-of select="notification_data/patron_cost"/>
                                    <xsl:value-of select="' '" />
                                    <xsl:value-of select="notification_data/currency" />
                                </xsl:if>
                                <xsl:if test="notification_data/request/note !=''">
                                    <br /><strong> @@note@@: </strong>
                                    <xsl:value-of select="notification_data/request/note"/>
                                </xsl:if>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                @@end@@
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <xsl:call-template name="SLSP-userAccount-request"/>
                            </td>
                        </tr>
                        <tr>
                            <td >@@signature@@</td>
                        </tr>
                        <tr>
                            <td style="padding-bottom: 10px">
                                <xsl:value-of select="notification_data/organization_unit/name" />
                            </td>
                        </tr>
                        <tr>
                            <td><br/><i>powered by SLSP</i></td>
                        </tr>
                    </table>
                    <br/>
                </div>
            </div>
            <!-- <xsl:call-template name="lastFooter" /> -->
            <!-- footer.xsl -->
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>