<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP WG: Letters version 12/2021
		01/2022 - Fixed FR version of librariesURL template
		10/2022 - replaced greeting template
		05/2023 - Added IZ message template; removed previous solution
				- Updated URL to list of libraries
		11/2023 - Updated the label for link to libraries list
		07/2024 - Added request note -->
<!-- Dependance:
		recordTitle - SLSP-multilingual, SLSP-userAccount, recordTitle, SLSP-greeting, SLSP-IZMessage
		style - generalStyle, bodyStyleCss
		header - head
		-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!-- Template to display link to list of Libraries on SLSP page -->
<xsl:template name="SLSP-librariesURL">
	<a>
		<xsl:attribute name="href">https://libraries.swisscovery.help/?lang=<xsl:value-of select="/notification_data/receivers/receiver/preferred_language"/></xsl:attribute>
		<xsl:attribute name="target">_blank</xsl:attribute>
		<xsl:call-template name="SLSP-multilingual">
			<xsl:with-param name="en" select="'Further information on library locations'"/>
			<xsl:with-param name="fr"><![CDATA[Plus d’informations sur la localisation des bibliothèques]]></xsl:with-param>
			<xsl:with-param name="it" select="'Ulteriori informazioni sulle biblioteche'"/>
			<xsl:with-param name="de" select="'Weitere Informationen zu den Bibliotheksstandorten'"/>
		</xsl:call-template>
	</a>
</xsl:template>

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
		<head>
		<xsl:call-template name="generalStyle" />
		</head>
			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
				<div class="messageArea">
					<div class="messageBody">
						<table cellspacing="0" cellpadding="5" border="0">
							<!-- New feature for displaying user group 92 information -->
							<xsl:for-each select="notification_data/receivers/receiver/user">
								<tr>
									<td>
										<br />
										<xsl:if test="user_group = '92'">
											<strong>
												<xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
													<xsl:with-param name="en" select="'Special user cantonal library'"/>
													<xsl:with-param name="fr" select="'Utilisateur spécial bibliothèque cantonale'"/>
													<xsl:with-param name="it" select="'Utente speciale biblioteca cantonale'"/>
													<xsl:with-param name="de" select="'Spezialnutzende Kantonsbibliothek'"/>
												</xsl:call-template>
											</strong><br />
										</xsl:if>
										<xsl:value-of select="first_name"/>&#160;<xsl:value-of select="last_name"/><br />
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

										<xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
											<xsl:with-param name="en" select="'User ID'"/>
											<xsl:with-param name="fr" select="'ID utilisateur'"/>
											<xsl:with-param name="it" select="'ID utente'"/>
											<xsl:with-param name="de" select="'Benutzer-ID'"/>
										</xsl:call-template>: 
										<xsl:choose>
											<xsl:when test="$edu-id_barcode != ''">
												<xsl:value-of select="$edu-id_barcode"/><br />
											</xsl:when>
											<xsl:when test="$NZ_barcode != ''">
												<xsl:value-of select="$NZ_barcode"/><br />
											</xsl:when>
											<xsl:when test="$IZ_barcode != ''">
												<xsl:value-of select="$IZ_barcode"/><br />
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
							<tr>
								<td>
									<xsl:if test="not(contains(notification_data/request/notes, '#'))">
										@@following_item_requested_on@@&#160;<xsl:value-of select="notification_data/request/create_date"/>@@can_picked_at@@
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td>
									<xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
									@@call_number@@
									<xsl:choose>
										<xsl:when test="notification_data/phys_item_display/display_alt_call_numbers != ''">
											<xsl:value-of select="notification_data/phys_item_display/display_alt_call_numbers"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="notification_data/phys_item_display/call_number"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<xsl:if test="/notification_data/request/note != ''">
								<tr>
									<td>
										<span><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Request note'"/>
											<xsl:with-param name="fr" select="'Note de demande'"/>
											<xsl:with-param name="it" select="'Nota di richiesta'"/>
											<xsl:with-param name="de" select="'Notiz zur Bestellung'"/>
										</xsl:call-template>: </span><xsl:value-of select="notification_data/request/note"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<span style="font-size: 140%; font-weight: bold;">@@circulation_desk@@&#160;<xsl:value-of select="notification_data/request/delivery_address"/></span>
									(<xsl:call-template name="SLSP-librariesURL"/>)<br />
									<xsl:if test="notification_data/request/work_flow_entity/expiration_date">
										<tr>
											<td>
												@@note_item_held_until@@ <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.<br />
											</td>
										</tr>
									</xsl:if>
								</td>
							</tr>
							<tr>
								<td>
									<xsl:call-template name="SLSP-IZMessage"/>
								</td>
							</tr>
							<tr>
								<td>
									<xsl:call-template name="SLSP-userAccount"/>
								</td>
							</tr>
							<tr>
								<td>
									<br />@@sincerely@@
								</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/request/delivery_address" />
								</td>
							</tr>
							<tr>
								<td><br /><i>powered by SLSP</i></td>
							</tr>
						</table>
					</div>
				</div>
			</body>
	</html>
	</xsl:template>
</xsl:stylesheet>