<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 02/2021
	01/2022 - Added POL number and greeting -->
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
						<xsl:call-template name="SLSP-multilingual">
							<xsl:with-param name="en" select="'Hello'"/>
							<xsl:with-param name="fr" select="'Bonjour'"/>
							<xsl:with-param name="it" select="'Buongiorno,'"/>
							<xsl:with-param name="de" select="'Guten Tag'"/>
						</xsl:call-template>
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
						@@orderNumber@@ <xsl:value-of  select="notification_data/line_number"/>
						<br />
					</td>
				</tr>
				<!-- <tr>
					<td>
				<br />
				@@mmsId@@:

						<br />

					</td>
						<td>
				<br />
				<xsl:value-of  select="notification_data/mms_id"/>
						<br />
					</td>
					</tr> -->
				
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
						<a>
							<xsl:attribute name="href">https://rzs.swisscovery.slsp.ch/discovery/search?query=any,contains,<xsl:value-of select="/notification_data/mms_id"/>&#38;sortby=rank&#38;vid=41SLSP_RZS:VU15&#38;offset=0</xsl:attribute>
							<xsl:attribute name="target">_blank</xsl:attribute>
							@@mmsId@@
						</a>
					</td>
				</tr>
				</table>
				<br />
				<table>
					<tr>
						<td>
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