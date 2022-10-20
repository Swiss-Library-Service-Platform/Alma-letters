<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 10/2022
	Dependancy:
		header - head
		style - generalStyle, bodyStyleCss, listStyleCss
		recordTitle - SLSP-multilingual-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:preserve-space elements="notification_data/request/cancel_reason" />
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<!--Fix to transform the note coming from Alma UI to insert new lines
		Takes the parameter text and replaces new lines with <br/> 
	Source: https://stackoverflow.com/questions/561235/xslt-replace-n-with-br-only-in-one-node
		@Tomalak, CC-BY-SA 3.0
	-->
	<xsl:template name="break">
		<xsl:param name="text" select="string(.)"/>
		<xsl:choose>
			<xsl:when test="contains($text, '&#xa;')">
			<xsl:value-of select="substring-before($text, '&#xa;')"/>
			<br/>
			<xsl:call-template name="break">
				<xsl:with-param 
				name="text" 
				select="substring-after($text, '&#xa;')"
				/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
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
				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
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
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Hello,'"/>
										<xsl:with-param name="fr" select="'Bonjour,'"/>
										<xsl:with-param name="it" select="'Buongiorno,'"/>
										<xsl:with-param name="de" select="'Guten Tag'"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									@@we_cancel_y_req_of@@
								</td>
							</tr>
							<tr>
								<td>
									<strong>@@reason_deleting_request@@: </strong>
									<xsl:value-of select="notification_data/request/status_note_display" />
								</td>
							</tr>
							<xsl:if test="notification_data/request/cancel_reason != ''">
								<tr>
									<td>
										<strong>@@request_cancellation_note@@: </strong>
										<xsl:call-template name="break">
											<xsl:with-param name="text" select="notification_data/request/cancel_reason"/>
										</xsl:call-template>
									</td>
								</tr>
							</xsl:if>
							<xsl:variable name="callNo">
								<xsl:choose>
									<xsl:when test="notification_data/phys_item_display/display_alt_call_numbers != ''">
										<xsl:value-of select="notification_data/phys_item_display/display_alt_call_numbers"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="notification_data/phys_item_display/call_number"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<!-- Title information -->
							<tr>
								<td>
									<xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
									<xsl:if test="$callNo != ''">
										<strong>@@call_number@@: </strong><xsl:value-of select="$callNo"/>
									</xsl:if>
								</td>
							</tr>
							<!--
								display owning library
								if the owning library name is resource sharing library then take first address row instead
							-->
							<xsl:if test="notification_data/phys_item_display/owning_library_name != '' and notification_data/phys_item_display/owning_library_details/address1 != ''">
								<tr>
									<td>
										<strong>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Library'"/>
												<xsl:with-param name="fr" select="'Bibliothèque'"/>
												<xsl:with-param name="it" select="'Biblioteca'"/>
												<xsl:with-param name="de" select="'Bibliothek'"/>
											</xsl:call-template>: </strong>
										<xsl:choose>
											<xsl:when test="notification_data/phys_item_display/owning_library_name = 'Resource Sharing Library'">
												<xsl:value-of select="notification_data/phys_item_display/owning_library_details/address1" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="notification_data/phys_item_display/owning_library_name" />
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:if>
							<!-- <xsl:if test="notification_data/metadata/title != ''">
								<tr>
									<td>
										<strong>@@title@@: </strong>
										<xsl:value-of select="notification_data/metadata/title" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/journal_title != ''">
								<tr>
									<td>
										<strong> @@journal_title@@: </strong>
										<xsl:value-of select="notification_data/metadata/journal_title" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/author != ''">
								<tr>
									<td>
										<strong> @@author@@: </strong>
										<xsl:value-of select="notification_data/metadata/author" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/author_initials != ''">
								<tr>
									<td>
										<strong>@@author_initials@@: </strong>
										<xsl:value-of select="notification_data/metadata/author_initials" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/edition != ''">
								<tr>
									<td>
										<strong> @@edition@@: </strong>
										<xsl:value-of select="notification_data/metadata/edition" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/identifier != ''">
								<tr>
									<td>
										<strong>@@identifier@@: </strong>
										<xsl:value-of select="notification_data/metadata/identifier" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/lccn != ''">
								<tr>
									<td>
										<strong> @@lccn@@: </strong>
										<xsl:value-of select="notification_data/metadata/lccn" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/issn != ''">
								<tr>
									<td>
										<strong>@@issn@@: </strong>
										<xsl:value-of select="notification_data/metadata/issn" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/isbn != ''">
								<tr>
									<td>
										<strong> @@isbn@@: </strong>
										<xsl:value-of select="notification_data/metadata/isbn" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/oclc_nr != ''">
								<tr>
									<td>
										<strong> @@oclc_nr@@: </strong>
										<xsl:value-of select="notification_data/metadata/oclc_nr" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/doi != ''">
								<tr>
									<td>
										<strong>@@doi@@: </strong>
										<xsl:value-of select="notification_data/metadata/doi" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/pmid != ''">
								<tr>
									<td>
										<strong> @@pmid@@: </strong>
										<xsl:value-of select="notification_data/metadata/pmid" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/publisher != ''">
								<tr>
									<td>
										<strong> @@publisher@@: </strong>
										<xsl:value-of select="notification_data/metadata/publisher" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/publication_date != ''">
								<tr>
									<td>
										<strong>@@publication_date@@: </strong>
										<xsl:value-of select="notification_data/metadata/publication_date" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/place_of_publication != ''">
								<tr>
									<td>
										<strong> @@place_of_publication@@: </strong>
										<xsl:value-of select="notification_data/metadata/place_of_publication" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/additional_person_name != ''">
								<tr>
									<td>
										<strong> @@additional_person_name@@: </strong>
										<xsl:value-of select="notification_data/metadata/additional_person_name" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/source != ''">
								<tr>
									<td>
										<strong>@@source@@: </strong>
										<xsl:value-of select="notification_data/metadata/source" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/series_title_number != ''">
								<tr>
									<td>
										<strong> @@series_title_number@@: </strong>
										<xsl:value-of select="notification_data/metadata/series_title_number" />
									</td>
								</tr>
							</xsl:if>
							
							<xsl:if test="notification_data/metadata/volume != ''">
								<tr>
									<td>
										<strong>@@volume@@: </strong>
										<xsl:value-of select="notification_data/metadata/volume" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/part != ''">
								<tr>
									<td>
										<strong> @@part@@: </strong>
										<xsl:value-of select="notification_data/metadata/part" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/chapter != ''">
								<tr>
									<td>
										<strong> @@chapter@@: </strong>
										<xsl:value-of select="notification_data/metadata/chapter" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/pages != ''">
								<tr>
									<td>
										<strong>@@pages@@: </strong>
										<xsl:value-of select="notification_data/metadata/pages" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/start_page != ''">
								<tr>
									<td>
										<strong> @@start_page@@: </strong>
										<xsl:value-of select="notification_data/metadata/start_page" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/end_pagee != ''">
								<tr>
									<td>
										<strong> @@end_page@@: </strong>
										<xsl:value-of select="notification_data/metadata/end_page" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/issue != ''">
								<tr>
									<td>
										<strong>@@issue@@: </strong>
										<xsl:value-of select="notification_data/metadata/issue" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/metadata/note != ''">
								<tr>
									<td>
										<strong> @@note@@: </strong>
										<xsl:value-of select="notification_data/metadata/note" />
									</td>
								</tr>
							</xsl:if> -->

							
							<xsl:if test="notification_data/request/start_time != ''">
								<tr>
									<td>
										<strong> @@start_time@@: </strong>
										<xsl:value-of select="notification_data/booking_start_time_str" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/end_time != ''">
								<tr>
									<td>
										<strong> @@end_time@@: </strong>
										<xsl:value-of select="notification_data/booking_end_time_str" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/request/note != ''">
								<tr>
									<td>
										<strong> @@request_note@@: </strong>
										<xsl:value-of select="notification_data/request/note" />
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<br />
									@@sincerely@@
								</td>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="notification_data/organization_unit/name" />
								</td>
							</tr>
							<tr>
								<td>
									<br/><i>powered by SLSP</i>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>