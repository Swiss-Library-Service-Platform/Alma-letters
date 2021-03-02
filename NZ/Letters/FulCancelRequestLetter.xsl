<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<!-- Source code from https://github.com/uio-library/alma-letters-ubo -->
	<!--
	Template to make it easier to insert multilingual text.
	Depends on: (none)
	USAGE:
		<xsl:call-template name="multilingual">
			<xsl:with-param name="en" select="'Testing multilingual text.'"/>
			<xsl:with-param name="fr" select="'Test de texte multilingue.'"/>
			<xsl:with-param name="it" select="'Test di testi multilingue.'"/>
			<xsl:with-param name="de" select="'Testen von mehrsprachigem Text.'"/>
		</xsl:call-template>
	-->
	<xsl:template name="multilingual">
	<xsl:param name="en" />
	<xsl:param name="fr" />
	<xsl:param name="de" />
	<xsl:param name="it" />
	<xsl:choose>
		<xsl:when test="notification_data/receivers/receiver/preferred_language = 'fr'"><xsl:value-of select="$fr"/></xsl:when>
		<xsl:when test="notification_data/receivers/receiver/preferred_language = 'en'"><xsl:value-of select="$en"/></xsl:when>
		<xsl:when test="notification_data/receivers/receiver/preferred_language = 'it'"><xsl:value-of select="$it"/></xsl:when>
		<xsl:when test="notification_data/receivers/receiver/preferred_language = 'de'"><xsl:value-of select="$de"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="$en"/></xsl:otherwise>
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
							<tr>
								<td>
									@@on@@
									<xsl:value-of select="notification_data/general_data/current_date" />@@we_cancel_y_req_of@@:
								</td>
							</tr>
							<tr>
								<td>
									<xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
								</td>
							</tr>
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

						<xsl:if test="notification_data/phys_item_display/call_number != ''">
							<tr>
								<td>
									@@call_number@@: 
									<xsl:value-of select="notification_data/phys_item_display/call_number" />
								</td>
							</tr>
						</xsl:if>

						<!--
							display owning library
							if the owning library name is resource sharing library then take first address row instead
						-->
						<xsl:if test="notification_data/phys_item_display/owning_library_name != '' and notification_data/phys_item_display/owning_library_details/address1 != ''">
							<tr>
								<td>
									<strong>
										<xsl:call-template name="multilingual">
											<xsl:with-param name="en" select="'Owning library'"/>
											<xsl:with-param name="fr" select="'Bibliothèque propriétaire'"/>
											<xsl:with-param name="it" select="'Biblioteca titolare'"/>
											<xsl:with-param name="de" select="'Besitzende Bibliothek'"/>
										</xsl:call-template>
									: </strong><br />
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
									<strong> @@reason_deleting_request@@: </strong>
									<xsl:value-of select="notification_data/request/status_note_display" />
								</td>
							</tr>
							<xsl:if test="notification_data/request/cancel_reason != ''">
								<tr>
									<td>
										<strong> @@request_cancellation_note@@: </strong>
										<xsl:value-of select="notification_data/request/cancel_reason" />
									</td>
								</tr>
							</xsl:if>
						</table>
						<br />
						<table>
							<tr>
								<td>
								@@sincerely@@<br/>
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
