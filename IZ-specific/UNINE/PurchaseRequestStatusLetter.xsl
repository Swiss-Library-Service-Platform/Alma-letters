<?xml version="1.0" encoding="utf-8"?>
<!-- IZ Customization: added author and issn/isbn

    SLSP version - 07/2024
    
    08/2025 - added author and issn/isbn

	Dependance:
		header - head
		style - generalStyle, bodyStyleCss
		SenderReceiver - senderReceiver
		recordTitle - SLSP-multilingual
-->
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
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>

		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<!-- <xsl:call-template name="toWhomIsConcerned" />  --><!-- mailReason.xsl -->
				<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
							<xsl:call-template name="SLSP-greeting" />
						</td>
					</tr>
					<tr>
						<td>@@introduction@@
							<xsl:choose >
								<xsl:when test="/notification_data/purchase_request/request_status='APPROVED'">
									<strong>@@approved@@</strong>.<br /><br />
									<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Order number'"/>
										<xsl:with-param name="fr" select="'No de commande'"/>
										<xsl:with-param name="it" select="'Numero di ordini'"/>
										<xsl:with-param name="de" select="'Bestellnummer'"/>
									</xsl:call-template>: </strong><xsl:value-of select="notification_data/purchase_request/poline_reference" />
								</xsl:when>
								<xsl:otherwise>
									<strong>@@rejected@@</strong>.<br /><br />
									<strong><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Reason for rejection'"/>
											<xsl:with-param name="fr" select="'Raison du rejet'"/>
											<xsl:with-param name="it" select="'Motivo del rifiuto'"/>
											<xsl:with-param name="de" select="'Grund für die Ablehnung'"/>
											</xsl:call-template>: </strong><xsl:value-of select="notification_data/purchase_request/reject_reason_desc" />
								</xsl:otherwise>
							</xsl:choose>
							<br /><strong>@@title@@: </strong><xsl:value-of select="notification_data/purchase_request/title" />
							<br /><xsl:if test="notification_data/purchase_request/author != ''"><strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Author'"/>
										<xsl:with-param name="fr" select="'Auteur.e'"/>
										<xsl:with-param name="it" select="'Autore'"/>
										<xsl:with-param name="de" select="'Autor'"/>
						    			</xsl:call-template>: </strong><xsl:value-of select="notification_data/purchase_request/author" />
						    			</xsl:if>
						    <br /><xsl:if test="notification_data/purchase_request/issn_isbn != ''"><strong>@@ISBN@@: </strong><xsl:value-of select="notification_data/purchase_request/issn_isbn" />
						          </xsl:if>
						</td>
					</tr>
				</table>
				<table>
					<tr><td><br />@@sincerely@@</td></tr>
					<tr><td><br /><xsl:value-of select="notification_data/organization_unit/name" /></td></tr>
					<tr>
						<td><br/><i>powered by SLSP</i></td>
					</tr>
				</table>
				<!-- <xsl:call-template name="lastFooter" />  --><!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>