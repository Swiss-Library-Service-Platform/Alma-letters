<?xml version="1.0" encoding="utf-8"?>
<!-- IZ Customization: added inventory number and storage ID
	
	SLSP Customized 11/2021
	05/2022 - Added inventory number and storage ID (SUPPORT-6810)
	06/2022 Added rapido request note, rapido volume extraction
	06/2022 added personal delivery field extraction
	11/2022 added extraction of rapido destination
	03/2025 added chapter title, author and pages for GetIt digitization requests
	Dependancy:
        recordTitle - recordTitle, SLSP-Rapido-request-note, SLSP-Rapido-extract-volume, SLSP-Rapido-extract-pages, SLSP-Rapido-persDel
        style - generalStyle
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
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>
				<xsl:call-template name="generalStyle" />
			</head>
			<body>
				<h1>
					<strong>@@requested_for@@ :
						<xsl:value-of select="notification_data/user_for_printing/name"/>
					</strong>
				</h1>
				<xsl:call-template name="head" />
				<!-- header.xsl -->
				<div class="messageArea">
					<div class="messageBody">
						<table role='presentation'  cellspacing="0" cellpadding="5" border="0">
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
								<tr>
									<td>
										<strong>@@note_item_specified_request@@.</strong>
									</td>
								</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/manual_description != ''" >
								<tr>
									<td>
										<strong>@@please_note@@: </strong>@@manual_description_note@@ -
										<xsl:value-of select="notification_data/request/manual_description"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<strong>@@request_id@@: </strong>
									<img src="cid:request_id_barcode.png" alt="Request Barcode"/>
								</td>
							</tr>
							<xsl:if test="/notification_data/incoming_request != ''">
                            <tr>
                                <td>
									<strong>Rapido request ID: </strong>
                                    <br />
                                    <img src="externalId.png" alt="externalId" />
                                </td>
                            </tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
								<tr>
									<td>
										<strong>@@item_barcode@@: </strong>
										<img src="cid:item_id_barcode.png" alt="Item Barcode"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if  test="notification_data/external_id != ''" >
								<tr>
									<td>
										<strong>@@external_id@@: </strong>
										<xsl:value-of select="notification_data/external_id"/>
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/user_for_printing/name">
								<tr>
									<td>
										<strong>@@requested_for@@: </strong>
										<xsl:value-of select="notification_data/user_for_printing/name"/>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td>
									<xsl:call-template name="recordTitle" />
								</td>
							</tr>
							<xsl:if test="notification_data/phys_item_display/edition != ''">
								<tr>
									<td><strong>@@edition@@: </strong><xsl:value-of select="notification_data/phys_item_display/edition"/>
									</td>
								</tr>
							</xsl:if>
							<!-- DBL (4. 6. 2021): Added Series field to better localize norms 
								Reused Bcc for Series label -->
							<xsl:if test="notification_data/request/record_display_section/series_small != ''">
								<tr>
									<td>
										<strong><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Series'"/>
											<xsl:with-param name="fr" select="'Collection'"/>
											<xsl:with-param name="it" select="'Serie'"/>
											<xsl:with-param name="de" select="'Serie'"/>
										</xsl:call-template>: </strong>
										<xsl:for-each select="notification_data/request/record_display_section/series_small_list/string">
											<xsl:value-of select="."/>;
										</xsl:for-each>
									</td>
								</tr>
							</xsl:if>
							<!-- DBL -->
							<!-- SLSP Add volume from Rapido request if available -->
                            <xsl:variable name="requestVolume">
                                <xsl:call-template name="SLSP-Rapido-extract-volume" />
                            </xsl:variable>
                            <xsl:if test="$requestVolume != ''">
                                <tr>
                                    <td colspan="3">
                                        <strong>
                                            <xsl:call-template name="SLSP-multilingual">
                                                <xsl:with-param name="en" select="'Volume'"/>
                                                <xsl:with-param name="fr" select="'Volume'"/>
                                                <xsl:with-param name="it" select="'Volume'"/>
                                                <xsl:with-param name="de" select="'Band'"/>
                                            </xsl:call-template>:
                                        </strong>
                                        <xsl:value-of select="$requestVolume"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- SLSP Add chapter/article title from request if available -->
                            <xsl:if test="notification_data/request/chapter_article_title != ''">
                                <tr>
                                    <td colspan="3">
                                        <strong>
                                            <xsl:call-template name="SLSP-multilingual">
                                                <xsl:with-param name="en" select="'Chapter / Article'"/>
                                                <xsl:with-param name="fr" select="'Chapitre / Article'"/>
                                                <xsl:with-param name="it" select="'Capitolo / Articolo'"/>
                                                <xsl:with-param name="de" select="'Kapitel / Artikel'"/>
                                            </xsl:call-template>:
                                        </strong>
                                        <xsl:value-of select="notification_data/request/chapter_article_title"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- SLSP Add chapter/article author from request if available -->
                            <xsl:if test="notification_data/request/chapter_article_author != ''">
                                <tr>
                                    <td colspan="3">
                                        <strong>
                                            <xsl:call-template name="SLSP-multilingual">
                                                <xsl:with-param name="en" select="'Author'"/>
                                                <xsl:with-param name="fr" select="'Auteur'"/>
                                                <xsl:with-param name="it" select="'Autore'"/>
                                                <xsl:with-param name="de" select="'Autor'"/>
                                            </xsl:call-template>:
                                        </strong>
                                        <xsl:value-of select="notification_data/request/chapter_article_author"/>
                                    </td>
                                </tr>
                            </xsl:if>
                            <!-- SLSP Add pages from Rapido request if available -->
							<xsl:variable name="requestPages">
								<xsl:call-template name="SLSP-Rapido-extract-pages" />
							</xsl:variable>
							<xsl:if test="$requestPages != ''">
								<tr>
									<td colspan="3">
										<strong>
										<xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Pages'"/>
											<xsl:with-param name="fr" select="'Pages'"/>
											<xsl:with-param name="it" select="'Pagine'"/>
											<xsl:with-param name="de" select="'Seiten'"/>
										</xsl:call-template>: </strong><xsl:value-of select="$requestPages"/>
									</td>
								</tr>
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
                            <!-- SLSP -->
							<tr>
								<td>
									<h2>
										<strong>@@location@@: </strong>
										<xsl:value-of select="notification_data/phys_item_display/location_name"/>
									</h2>
								</td>
								<xsl:if test="notification_data/phys_item_display/call_number != ''">
									<td>
										<h2>
											<strong>@@call_number@@: </strong>
											<xsl:value-of select="notification_data/phys_item_display/call_number"/>
										</h2>
									</td>
								</xsl:if>
								<xsl:if test="notification_data/phys_item_display/accession_number != ''">
									<td>
										<h2>
											<strong>@@accession_number@@: </strong>
											<xsl:value-of select="notification_data/phys_item_display/accession_number"/>
										</h2>
									</td>
								</xsl:if>
							</tr>
							<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
								<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
									<tr>
										<td colspan="3">
											<strong>@@shelving_location_for_item@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
												<xsl:value-of select="."/>
									&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
									<tr>
										<td colspan="3">
											<strong>@@shelving_locations_for_holding@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
												<xsl:value-of select="."/>
								&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
									<tr>
										<td colspan="3">
											<strong>@@shelving_locations_for_holding@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
												<xsl:value-of select="."/>
								&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
							<xsl:if  test="notification_data/phys_item_display/display_alt_call_numbers/string" >
								<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
									<tr>
										<td>
											<strong>@@alt_call_number@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
												<xsl:value-of select="."/>
									&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
									<tr>
										<td>
											<strong>@@alt_call_number@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
												<xsl:value-of select="."/>
								&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
									<tr>
										<td>
											<strong>@@alt_call_number@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
												<xsl:value-of select="."/>
								&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
							<strong></strong>
							<tr>
								<td colspan="3">
									<strong>@@move_to_library@@: </strong>
									<!-- SLSP: extract destination for Rapido requests -->
									<xsl:variable name="destination">
										<xsl:call-template name="SLSP-Rapido-destination" />
									</xsl:variable>
									<xsl:value-of select="$destination"/>
									<br />
									<!-- SLSP: Add personal delivery field to request type -->
									<xsl:variable name="personalDelivery">
										<xsl:call-template name="SLSP-Rapido-persDel" />
									</xsl:variable>
									<strong>@@request_type@@: </strong>
									<xsl:value-of select="notification_data/request_type"/>
									<xsl:if test="$personalDelivery != ''">
										- <xsl:value-of select="$personalDelivery"/>
									</xsl:if>
									<xsl:if test="notification_data/request/system_notes != ''">
										<br />
										<strong>@@system_notes@@: </strong>
										<xsl:value-of select="notification_data/request/system_notes"/>
									</xsl:if>
									<!-- SLSP: Add request note from the Rapido request or normal request -->
									<xsl:variable name="requestNote">
										<xsl:call-template name="SLSP-Rapido-request-note" />
									</xsl:variable>
									<xsl:if test="$requestNote != ''">
										<br />
										<strong>@@request_note@@: </strong><xsl:value-of select="$requestNote"/>
									</xsl:if>
								</td>
							</tr>
						</table>
						<!-- Adapted code from ETH (escherer) -->
						<xsl:if test="notification_data/request/selected_inventory_type!='ITEM'">
							<xsl:if test="notification_data/phys_item_display/available_items/available_item/barcode!='ITEM'">
								<table cellpadding="5" class="listing">
									<xsl:attribute name="style">
										<xsl:call-template name="mainTableStyleCss"/>
									</xsl:attribute>
									<tr>
										<td colspan="6">
											<strong><xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Available items'"/>
												<xsl:with-param name="fr" select="'Exemplaires disponibles'"/>
												<xsl:with-param name="it" select="'Copie disponibili'"/>
												<xsl:with-param name="de" select="'Verfügbare Exemplare'"/>
											</xsl:call-template></strong>
										</td>
									</tr>
									<tr>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Barcode'"/>
												<xsl:with-param name="fr" select="'Code-barres'"/>
												<xsl:with-param name="it" select="'Barcode'"/>
												<xsl:with-param name="de" select="'Strichcode'"/>
											</xsl:call-template>
										</th>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Call Number'"/>
												<xsl:with-param name="fr" select="'Cote'"/>
												<xsl:with-param name="it" select="'Segnatura'"/>
												<xsl:with-param name="de" select="'Signatur'"/>
											</xsl:call-template>
											(@@inventory_number@@)
										</th>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Library'"/>
												<xsl:with-param name="fr" select="'Bibliothèque'"/>
												<xsl:with-param name="it" select="'Biblioteca'"/>
												<xsl:with-param name="de" select="'Bibliothek'"/>
											</xsl:call-template>
										</th>
										<th>@@location@@ (@@shelving_location_for_item@@)</th>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Item policy'"/>
												<xsl:with-param name="fr">
													<![CDATA[Politique de l'exemplaire]]>
												</xsl:with-param>
												<xsl:with-param name="it" select="'Politica della copia'"/>
												<xsl:with-param name="de" select="'Exemplar-Richtlinie'"/>
											</xsl:call-template>
										</th>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Public note'"/>
												<xsl:with-param name="fr" select="'Note publique'"/>
												<xsl:with-param name="it" select="'Nota pubblica'"/>
												<xsl:with-param name="de" select="'Öffentliche Notiz'"/>
											</xsl:call-template>
										</th>
									</tr>
									<xsl:for-each select="notification_data/phys_item_display/available_items/available_item">
										<tr>
											<td>
												<xsl:value-of select="barcode"/>
											</td>
											<td>
												<xsl:value-of select="call_number"/>
												<xsl:if test="inventory_number != ''">
													(<xsl:value-of select="inventory_number"/>)
												</xsl:if>
											</td>
											<td>
												<xsl:value-of select="library_name"/>
											</td>
											<td>
												<xsl:value-of select="location_name"/>
												<xsl:if test="shelving_location != ''">
													(<xsl:value-of select="shelving_location"/>)
												</xsl:if>
											</td>
											<td>
												<xsl:value-of select="item_policy"/>
											</td>
											<td>
												<xsl:value-of select="public_note"/>
											</td>
										</tr>
									</xsl:for-each>
								</table>
							</xsl:if>
						</xsl:if>
					</div>
				</div>
				<table>
					<tr>
						<td>
							<xsl:value-of select="notification_data/organization_unit/name" />
						</td>
					</tr>
					<tr>
						<td>
							<br/>
							<i>powered by SLSP</i>
						</td>
					</tr>
				</table>
				<!-- <xsl:call-template name="lastFooter" />  -->
				<!-- footer.xsl -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>