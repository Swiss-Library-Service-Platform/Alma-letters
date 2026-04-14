<?xml version="1.0" encoding="utf-8"?>
<!-- 
    IZ customization: document link per view

SLSP customized 02/2021
	01/2022 - Added POL number and greeting
    07/2024 - greeting using template
	03/2026 - updated message format
	04/2026 - added IZ message template and swisscovery link-->
	<!-- Dependancy: 
		recordTitle - SLSP-multilingual
		style - generalStyle, bodyStyleCss
		header - head -->
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

<!-- Template to generate a link to the document in swisscovery.
 Takes the variable in General:Other settings:email_my_account and changes it to a link to the full display of the document.
 The link goes to the common view.-->
<xsl:template name="SLSP-displayLink">
	<xsl:variable name="lang" select="/notification_data/receivers/receiver/preferred_language" />
	<xsl:variable name="accountLink">
		@@email_my_account@@
	</xsl:variable>
	<!-- replace "/account?" with "/fulldisplay?" in the link -->
	<xsl:variable name="linkBase" select="substring-before($accountLink, '/discovery/')" />
	<xsl:variable name="docLink" select="concat($linkBase, '/discovery/fulldisplay?', substring-after($accountLink, '/account?'))" />
	<xsl:variable name="mmsId" select="notification_data/mms_id" />
	<xsl:variable name="finalLink" select="concat($docLink, '&amp;docid=alma', $mmsId, '&amp;context=L', '&amp;lang=', $lang)" /> 
	<a>
		<xsl:attribute name="href">
			<xsl:value-of select="$finalLink" />
		</xsl:attribute>
		<xsl:attribute name="target">_blank</xsl:attribute>
		<xsl:value-of select="$linkBase" />
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
		<xsl:call-template name="generalStyle" />
		</head>
			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
				<tr>
					<td>
						<br />
						<xsl:call-template name="SLSP-greeting" />
					</td>
				</tr>
				<tr>
					<td>
						<br />
						@@You_were_specify@@:
						<br />
					</td>
				</tr>
				<tr>
					<td>
                        <br />
                        <strong><xsl:value-of  select="notification_data/title"/></strong>
                        <br />
					</td>
                </tr>
				<tr>
					<td>
						@@orderNumber@@:&#160;<xsl:value-of  select="notification_data/line_number"/>
						<br />
					</td>
				</tr>
                <!-- IZ customization: document link per view -->
                 <tr>
                    <td>
                        @@mmsId@@:
                        <xsl:choose>
                                <xsl:when test="(substring(/notification_data/organization_unit/code, 1,3) = 'LUH'  
                                or  substring(/notification_data/organization_unit/code, 1,5) = 'LUMHS')">
                                <br/>  
                                <a target="_blank">
                        <xsl:attribute name="href">http://rzs.swisscovery.slsp.ch/discovery/search?query=any,contains,<xsl:value-of select="/notification_data/mms_id"/>&#38;sortby=rank&#38;vid=41SLSP_RZS:VU06&#38;offset=0</xsl:attribute>
                        <xsl:value-of select="/notification_data/mms_id"/></a>          
                                </xsl:when>  

                                <xsl:when test="(substring(/notification_data/organization_unit/code , 1,3) = 'LUP'  
                                or  substring(/notification_data/organization_unit/code, 1,5) = 'LUUHL' )">
                                <a target="_blank">
                        <xsl:attribute name="href">http://rzs.swisscovery.slsp.ch/discovery/search?query=any,contains,<xsl:value-of select="/notification_data/mms_id"/>&#38;sortby=rank&#38;vid=41SLSP_RZS:VU07&#38;offset=0</xsl:attribute>
                        <xsl:value-of select="/notification_data/mms_id"/></a>          
                                </xsl:when>  

                            <xsl:otherwise>   
                            <a target="_blank">                                
                        <xsl:attribute name="href">http://rzs.swisscovery.slsp.ch/discovery/search?query=any,contains,<xsl:value-of select="/notification_data/mms_id"/>&#38;sortby=rank&#38;vid=41SLSP_RZS:VU15&#38;offset=0</xsl:attribute>
                        <xsl:value-of select="/notification_data/mms_id"/></a>          
                        </xsl:otherwise>
                        </xsl:choose>

                    </td>
                </tr>
                <!-- End of IZ customization -->
				<!-- if the /notification_data/letter_params/subject contains 'activated' or 'aktiviert'
				 or 'activé' or 'attivato' display the link-->
				<!-- <xsl:if test="contains(notification_data/letter_params/subject, 'activated') or contains(notification_data/letter_params/subject, 'aktiviert') or contains(notification_data/letter_params/subject, 'activé') or contains(notification_data/letter_params/subject, 'attivato')">
					<tr>
						<td>
						<br />
						@@mmsId@@: <xsl:call-template name="SLSP-displayLink" />
						</td>
					</tr>
				</xsl:if> -->
				
			<!-- 	<tr>
					<td>
						<br />
						@@callNumber@@:
						<br />
					</td>
					<td>
						<br />
						<xsl:value-of  select="notification_data/poline_inventory/call_number"/>
						<br />
					</td>
				</tr> -->
				<!-- <tr>
					<td>
						<br />
						@@receivingNote@@:
						<br />
					</td>
					<td>
						<br />
						<xsl:value-of select="notification_data/receiving_note"/>
						<br />
					</td>
				</tr> -->
                <tr>
					<td>
                        <br />
                        <b>@@message@@:</b>
                        <br />
                        <xsl:value-of  select="notification_data/message"/>
                        <br />
					</td>
                </tr>
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
					<td><br/>
						<xsl:value-of select="notification_data/organization_unit/name" />
					</td>
				</tr>
				<tr>
					<td><br/><i>powered by SLSP</i></td>
				</tr>
			</table>
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>