<?xml version="1.0" encoding="utf-8"?>
<!-- IZ customization: receipt printer format
	
	SLSP Customized 11/2021
		01/2022 - Added user Barcode (SUPPORT-8376)
		01/2022 - Fix for item non-readable barcodes with 11 chars (SUPPORT-5303)
		05/2022 Added rapido request note, rapido volume, rapido pages
		06/2022 added personal delivery field extraction
		11/2022 format adjustments to fit A4 (SUPPORT-19945)
		11/2022 add extraction for destination of Rapido requests
		06/2024 changed format to fit receipt printer (SUPPORT-29017)
		03/2025 added chapter title, author and pages for GetIt digitization requests
		02/2026 added logic to display logo for non-PHGR libraries
	Dependance:
		header - head
		style - generalStyle
		recordTitle - recordTitle, SLSP-multilingual, SLSP-Rapido-request-note, SLSP-Rapido-extract-volume,
SLSP-Rapido-extract-pages, SLSP-Rapido-persDel
	-->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<!-- insert transit header without logo-->
    <xsl:template name="head-letterName-print-date">
		<table cellspacing="0" cellpadding="5" border="0">
			<xsl:attribute name="style">
				<xsl:call-template name="headerTableStyleCss" />; height: 15mm;
			</xsl:attribute>
			<tr>
				<xsl:for-each select="notification_data/general_data">
					<td>
						<h1><xsl:value-of select="subject"/></h1>
					</td>
					<td align="right">
						<xsl:value-of select="current_date"/>
					</td>
				</xsl:for-each>
			</tr>
		</table>
    </xsl:template>

	<xsl:template match="/">
		<html>
			<xsl:if test="notification_data/languages/string">
				<xsl:attribute name="lang">
					<xsl:value-of select="notification_data/languages/string" />
				</xsl:attribute>
			</xsl:if>
			<head>
				<title>
					<xsl:value-of select="notification_data/general_data/subject" />
				</title>
				<xsl:call-template name="generalStyle" />
			</head>
			<body style="font-size: 100%; font-family: arial; color:#333;">
				<xsl:if test="notification_data/user_for_printing/name != ''">
					<h2>
						<strong>@@requested_for@@ : <xsl:value-of select="notification_data/user_for_printing/name" /></strong>
					</h2>
				</xsl:if>
				
				<xsl:choose>
                    <xsl:when test="/notification_data/organization_unit/code = 'N12'">
                        <xsl:call-template name="head-letterName-print-date" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="head" />
                    </xsl:otherwise>
                </xsl:choose>

				<div class="messageArea">
					<div class="messageBody">
						<xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
							<p>
								<strong>@@note_item_specified_request@@.</strong>
							</p>
						</xsl:if>
						<xsl:if test="notification_data/request/manual_description != ''">
							<p>
								<strong>@@please_note@@: </strong>@@manual_description_note@@ - <xsl:value-of
									select="notification_data/request/manual_description" />
							</p>
						</xsl:if>
						<p>
							<strong>@@request_id@@:</strong>
							<br />
							<img src="cid:request_id_barcode.png" alt="Request Barcode" />
						</p>
						<xsl:if test="/notification_data/incoming_request != ''">
                            <p>
								<strong>Rapido request ID: </strong>
								<br />
								<img>
									<xsl:attribute name="src">cid:group_qualifier.png</xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="notification_data/group_qualifier" /></xsl:attribute>
								</img>
							</p>
						</xsl:if>
						<xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
							<p>
								<strong>@@item_barcode@@:</strong>
								<br />
								<img src="cid:item_id_barcode.png" alt="Item Barcode" />
							</p>
						</xsl:if>
						<xsl:if test="notification_data/external_id != ''">
							<p>
								<strong>@@external_id@@: </strong>
								<xsl:value-of select="notification_data/external_id" />
							</p>
						</xsl:if>
						<xsl:if test="notification_data/user_for_printing/name">
							<p>
								<strong>@@requested_for@@: </strong>
								<xsl:value-of select="notification_data/user_for_printing/name" />
								<br />
								<!-- set the barcode values in variables -->
								<!-- set the Barcode NZ, if there are more then only first one
								is returned -->
								<xsl:variable name="NZ_barcode">
									<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='02']/value" />
								</xsl:variable>
								<!-- set the Barcode edu-ID, if there are more then only first
								one is returned -->
								<xsl:variable name="edu-id_barcode">
									<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='01']/value" />
								</xsl:variable>
								<!-- set the Barcode IZ, if there are more then only first one
								is returned -->
								<xsl:variable name="IZ_barcode">
									<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='03']/value" />
								</xsl:variable>
								<!-- set the barcode values in variables -->

								<strong><xsl:call-template name="SLSP-multilingual"> <!--
										recordTitle -->
										<xsl:with-param name="en" select="'User ID'" />
										<xsl:with-param name="fr" select="'ID utilisateur'" />
										<xsl:with-param name="it" select="'ID utente'" />
										<xsl:with-param name="de" select="'Benutzer-ID'" />
									</xsl:call-template>: </strong>
								<xsl:choose>
									<xsl:when test="$edu-id_barcode != ''">
										<xsl:value-of select="$edu-id_barcode" />
										<br />
									</xsl:when>
									<xsl:when test="$NZ_barcode != ''">
										<xsl:value-of select="$NZ_barcode" />
										<br />
									</xsl:when>
									<xsl:when test="$IZ_barcode != ''">
										<xsl:value-of select="$IZ_barcode" />
										<br />
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="/notification_data/user_for_printing/identifiers/code_value[code='Primary Identifier']/value" />
									</xsl:otherwise>
								</xsl:choose>
							</p>
						</xsl:if>
						<p>
							<xsl:call-template name="recordTitle" />
						</p>
						<xsl:if test="notification_data/phys_item_display/edition != ''">
							<p>
								<strong>@@edition@@: </strong>
								<xsl:value-of select="notification_data/phys_item_display/edition" />
						</p>
						</xsl:if>
						<!-- DBL (4. 6. 2021): Added Series field to better localize norms -->
						<xsl:if test="notification_data/request/record_display_section/series_small != ''">
							<p>
								<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Series'" />
										<xsl:with-param name="fr" select="'Collection'" />
										<xsl:with-param name="it" select="'Serie'" />
										<xsl:with-param name="de" select="'Serie'" />
									</xsl:call-template>: </strong>
								<xsl:value-of select="notification_data/request/record_display_section/series_small" />
							</p>
						</xsl:if>
						<!-- DBL -->
						<!-- SLSP Add volume from Rapido request if available -->
						<xsl:variable name="requestVolume">
							<xsl:call-template name="SLSP-Rapido-extract-volume" />
						</xsl:variable>
						<xsl:if test="$requestVolume != ''">
							<p>
								<strong>
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Volume'" />
										<xsl:with-param name="fr" select="'Volume'" />
										<xsl:with-param name="it" select="'Volume'" />
										<xsl:with-param name="de" select="'Band'" />
									</xsl:call-template>: </strong>
								<xsl:value-of select="$requestVolume" />
							</p>
						</xsl:if>
						<!-- SLSP Add pages from Rapido request if available -->
						<xsl:variable name="requestPages">
							<xsl:call-template name="SLSP-Rapido-extract-pages" />
						</xsl:variable>
						<xsl:if test="$requestPages != ''">
						<p>
							<strong>
								<xsl:call-template name="SLSP-multilingual">
									<xsl:with-param name="en" select="'Pages'" />
									<xsl:with-param name="fr" select="'Pages'" />
									<xsl:with-param name="it" select="'Pagine'" />
									<xsl:with-param name="de" select="'Seiten'" />
								</xsl:call-template>: </strong>
							<xsl:value-of select="$requestPages" />
						</p>
						</xsl:if>
						<!-- SLSP add the digitization request information if present -->
						<xsl:if test="notification_data/request/request_type = 'PHYSICAL_TO_DIGITIZATION'">
							<p>
								<!-- SLSP add chapter title from the getit digitization request -->
								<xsl:if test="notification_data/request/chapter_article_title != ''">
									<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Chapter title'" />
										<xsl:with-param name="fr" select="'Titre du chapitre'" />
										<xsl:with-param name="it" select="'Titolo del capitolo'" />
										<xsl:with-param name="de" select="'Kapiteltitel'" />
									</xsl:call-template>: </strong>
									<xsl:value-of select="notification_data/request/chapter_article_title" />
									<br/>
								</xsl:if>
								<!-- SLSP add chapter authors from the getit digitization request -->
								<xsl:if test="notification_data/request/chapter_article_author != ''">
									<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Chapter author'" />
										<xsl:with-param name="fr" select="'Auteur du chapitre'" />
										<xsl:with-param name="it" select="'Autore del capitolo'" />
										<xsl:with-param name="de" select="'Kapitelautor'" />
									</xsl:call-template>: </strong>
									<xsl:value-of select="notification_data/request/chapter_article_author" />
									<br/>
								</xsl:if>
								<!-- SLSP add pages from the getit digitization request -->
								<xsl:if test="notification_data/request/pages != ''">
									<strong><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Pages'" />
										<xsl:with-param name="fr" select="'Pages'" />
										<xsl:with-param name="it" select="'Pagine'" />
										<xsl:with-param name="de" select="'Seiten'" />
									</xsl:call-template>: </strong>
									<xsl:value-of select="notification_data/request/pages" />
								</xsl:if>
							</p>
						</xsl:if>
						<p>
							<strong>@@location@@: </strong>
							<xsl:value-of select="notification_data/phys_item_display/location_name" />
							<xsl:if test="notification_data/phys_item_display/call_number != ''">
								<br/>
								<strong>@@call_number@@: </strong>
								<xsl:value-of select="notification_data/phys_item_display/call_number" />
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/accession_number != ''">
								<br/>
								<strong>@@accession_number@@: </strong>
								<xsl:value-of select="notification_data/phys_item_display/accession_number" />
							</xsl:if>
						</p>
						<xsl:if test="notification_data/phys_item_display/shelving_location/string">
							<xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
								<p>
									<strong>@@shelving_location_for_item@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
							<xsl:if test="notification_data/request/selected_inventory_type='HOLDING'">
								<p>
									<strong>@@shelving_locations_for_holding@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
							<xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'">
								<p>
									<strong>@@shelving_locations_for_holding@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
						</xsl:if>
						<xsl:if test="notification_data/phys_item_display/display_alt_call_numbers/string">
							<xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
								<p>
									<strong>@@alt_call_number@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
							<xsl:if test="notification_data/request/selected_inventory_type='HOLDING'">
								<p>
									<strong>@@alt_call_number@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
							<xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'">
								<p>
									<strong>@@alt_call_number@@: </strong>
									<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
										<xsl:value-of select="." />&#160;
									</xsl:for-each>
								</p>
							</xsl:if>
						</xsl:if>
						<p>
							<strong>@@move_to_library@@: </strong>
							<!-- SLSP: extract destination for Rapido requests -->
							<xsl:variable name="destination">
								<xsl:call-template name="SLSP-Rapido-destination" />
							</xsl:variable>
							<xsl:value-of select="$destination" />
							<br />
							<xsl:variable name="podName">
								<xsl:call-template name="SLSP-Rapido-pod-name" />
							</xsl:variable>
							<xsl:if test="$podName != ''">
								<strong>Pod: </strong>
								<xsl:value-of select="$podName"/>
								<br />
							</xsl:if>
							<!-- SLSP: Add personal delivery field to request type -->
							<xsl:variable name="personalDelivery">
								<xsl:call-template name="SLSP-Rapido-persDel" />
							</xsl:variable>
							<strong>@@request_type@@: </strong>
							<xsl:value-of select="notification_data/request_type" />
							<xsl:if test="$personalDelivery != ''"> - <xsl:value-of select="$personalDelivery" />
							</xsl:if>
							<xsl:if test="notification_data/request/system_notes != ''">
								<br />
								<strong>@@system_notes@@: </strong>
								<xsl:value-of select="notification_data/request/system_notes" />
							</xsl:if>
							<!-- SLSP: Add request note from the Rapido request or normal
							request -->
							<xsl:variable name="requestNote">
								<xsl:call-template name="SLSP-Rapido-request-note" />
							</xsl:variable>
							<xsl:if test="$requestNote != ''">
								<br />
								<strong>@@request_note@@: </strong>
								<xsl:value-of select="$requestNote" />
							</xsl:if>
						</p>
						<!-- display available items if there is more than 1 in the XML -->
						<xsl:if test="notification_data/request/selected_inventory_type!='ITEM'">
							<xsl:choose>
								<xsl:when test="count(notification_data/phys_item_display/available_items/available_item)>5">
									<p><xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'More than 5 items available'" />
										<xsl:with-param name="fr" select="'Plus de 5 exemplaires disponibles'" />
										<xsl:with-param name="it" select="'Più di 5 copie disponibili'" />
										<xsl:with-param name="de" select="'Mehr als 5 Exemplare verfügbar'" />
									</xsl:call-template></p>
								</xsl:when>
								<xsl:when test="count(notification_data/phys_item_display/available_items/available_item)>1">
									<xsl:if test="notification_data/phys_item_display/available_items/available_item/barcode!='ITEM'">
										<p>
											<strong>
												<xsl:call-template name="SLSP-multilingual">
													<xsl:with-param name="en"
														select="'Available items'" />
													<xsl:with-param name="fr"
														select="'Exemplaires disponibles'" />
													<xsl:with-param name="it"
														select="'Copie disponibili'" />
													<xsl:with-param name="de"
														select="'Verfügbare Exemplare'" />
												</xsl:call-template>
											</strong>
										</p>
										<p>
											<strong>
											<xsl:call-template name="SLSP-multilingual">
													<xsl:with-param name="en" select="'Call Number'" />
													<xsl:with-param name="fr" select="'Cote'" />
													<xsl:with-param name="it" select="'Segnatura'" />
													<xsl:with-param name="de" select="'Signatur'" />
												</xsl:call-template>
											|
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Library'" />
												<xsl:with-param name="fr" select="'Bibliothèque'" />
												<xsl:with-param name="it" select="'Biblioteca'" />
												<xsl:with-param name="de" select="'Bibliothek'" />
											</xsl:call-template>
											|
											@@location@@
											|
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Item policy'" />
												<xsl:with-param name="fr">
													<![CDATA[Politique de l'exemplaire]]>
												</xsl:with-param>
												<xsl:with-param name="it" select="'Politica della copia'" />
												<xsl:with-param name="de" select="'Exemplar-Richtlinie'" />
											</xsl:call-template>
											</strong>
											<xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
												<br/>
												<xsl:value-of select="call_number" />
												|
												<xsl:value-of select="library_name" />
												|
												<xsl:value-of select="location_name" />
												|
												<xsl:value-of select="item_policy" />
											</xsl:for-each>
										</p>
									</xsl:if>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</div>
				</div>
				<!-- <xsl:call-template name="lastFooter" />  -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>