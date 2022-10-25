<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP Customized 11/2021
		01/2022 - Added user Barcode (SUPPORT-8376)
		01/2022 - Fix for item non-readable barcodes with 11 chars (SUPPORT-5303)
		05/2022 Added rapido request note, rapido volume, rapido pages
		06/2022 added personal delivery field extraction
	Dependance:
		header - head
		style - generalStyle
		recordTitle - recordTitle, SLSP-multilingual, SLSP-Rapido-request-note, SLSP-Rapido-extract-volume, SLSP-Rapido-extract-pages, SLSP-Rapido-persDel
	-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<!-- Prints barcode from the node phys_item_display. Based on the owning library of the item chooses different printing method.
	Workaround for issue with non-readable barcodes. https://slsp.atlassian.net/browse/SUPPORT-5303 -->
	<xsl:template name="printBarcode">
		<xsl:choose>
			<xsl:when test="/notification_data/phys_item_display/library_code = 'E32'"> <!-- only items from Schweizerisches Nationalmuseum -->
				<xsl:variable name="itemBarcode" select="/notification_data/phys_item_display/barcode"/>
				<xsl:choose>
					<xsl:when test="string-length($itemBarcode) = 11 and contains($itemBarcode, '-')"> <!-- use font for printing -->
						<span style="font-family:Libre Barcode 39 Extended Text; font-size:32pt;">*<xsl:value-of select="$itemBarcode"/>*</span>
					</xsl:when>
					<xsl:otherwise> <!-- use Ex Libris barcode image -->
						<img src="cid:item_id_barcode.png" alt="Item Barcode"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise> <!-- use Ex Libris barcode image -->
				<img src="cid:item_id_barcode.png" alt="Item Barcode"/>
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
				<title>
					<xsl:value-of select="notification_data/general_data/subject"/>
				</title>
				<!-- Linking Google Open License font for barcodes. Works only sometimes when seen in browser. In most cases needs to be installed on the computer. -->
				<xsl:element name="link">
					<xsl:attribute name="href">https://fonts.googleapis.com/css2?family=Libre+Barcode+39+Extended+Text</xsl:attribute>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
				</xsl:element>
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
									<strong>@@request_id@@:</strong><br />
									<img src="cid:request_id_barcode.png" alt="Request Barcode"/>
								</td>
							</tr>
							<tr>
								<td>
									
								</td>
							</tr>
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
								<tr>
									<td colspan="2">
										<strong>@@item_barcode@@:</strong><br />
										<xsl:call-template name="printBarcode" />
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
										<xsl:value-of select="notification_data/user_for_printing/name"/><br />
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

										<strong><xsl:call-template name="SLSP-multilingual"> <!-- recordTitle -->
											<xsl:with-param name="en" select="'User ID'"/>
											<xsl:with-param name="fr" select="'ID utilisateur'"/>
											<xsl:with-param name="it" select="'ID utente'"/>
											<xsl:with-param name="de" select="'Benutzer-ID'"/>
										</xsl:call-template>: </strong>
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
							</xsl:if>
							<tr>
								<td>
									<xsl:call-template name="recordTitle" />
								</td>
							</tr>
							<!-- DBL (4. 6. 2021): Hidden isbn since it is comming from recordTitle -->
							<!-- <xsl:if test="notification_data/phys_item_display/isbn != ''">
								<tr>
								<td>@@isbn@@: <xsl:value-of select="notification_data/phys_item_display/isbn"/></td>
								</tr>
							</xsl:if> -->
							<!-- <xsl:if test="notification_data/phys_item_display/issn != ''">
								<tr>
								<td>@@issn@@: <xsl:value-of select="notification_data/phys_item_display/issn"/></td>
								</tr>
							</xsl:if> -->
							<xsl:if test="notification_data/phys_item_display/edition != ''">
								<tr>
									<td><strong>@@edition@@: </strong><xsl:value-of select="notification_data/phys_item_display/edition"/>
									</td>
								</tr>
							</xsl:if>
							<!-- <xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if> -->
							<!-- DBL (4. 6. 2021): Added Series field to better localize norms -->
							<xsl:if test="notification_data/request/record_display_section/series_small != ''">
								<tr>
									<td>
										<strong><xsl:call-template name="SLSP-multilingual">
											<xsl:with-param name="en" select="'Series'"/>
											<xsl:with-param name="fr" select="'Collection'"/>
											<xsl:with-param name="it" select="'Serie'"/>
											<xsl:with-param name="de" select="'Serie'"/>
										</xsl:call-template>: </strong><xsl:value-of select="notification_data/request/record_display_section/series_small"/>
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
										</strong><xsl:value-of select="$requestVolume"/>
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
										<td>
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
										<td>
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
										<td>
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
								<td>
									<strong>@@move_to_library@@: </strong>
									<xsl:value-of select="notification_data/destination"/>
								</td>
							</tr>
							<!-- SLSP: Add personal delivery field to request type -->
							<xsl:variable name="personalDelivery">
								<xsl:call-template name="SLSP-Rapido-persDel" />
							</xsl:variable>
							<tr>
								<td colspan="3">
									<strong>@@request_type@@: </strong>
									<xsl:value-of select="notification_data/request_type"/>
									<xsl:if test="$personalDelivery != ''">
										- <xsl:value-of select="$personalDelivery"/>
									</xsl:if>
								</td>
							</tr>
							<xsl:if test="notification_data/request/system_notes != ''">
								<tr>
									<td>
										<strong>@@system_notes@@:</strong>
										<xsl:value-of select="notification_data/request/system_notes"/>
									</td>
								</tr>
							</xsl:if>
							<!-- SLSP: Add request note from the Rapido request or normal request -->
							<xsl:variable name="requestNote">
								<xsl:call-template name="SLSP-Rapido-request-note" />
							</xsl:variable>
							<xsl:if test="$requestNote != ''">
								<tr>
									<td colspan="3">
										<strong>@@request_note@@: </strong><xsl:value-of select="$requestNote"/>
									</td>
								</tr>
							</xsl:if>
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
										</th>
										<th>
											<xsl:call-template name="SLSP-multilingual">
												<xsl:with-param name="en" select="'Library'"/>
												<xsl:with-param name="fr" select="'Bibliothèque'"/>
												<xsl:with-param name="it" select="'Biblioteca'"/>
												<xsl:with-param name="de" select="'Bibliothek'"/>
											</xsl:call-template>
										</th>
										<th>@@location@@</th>
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
											</td>
											<td>
												<xsl:value-of select="library_name"/>
											</td>
											<td>
												<xsl:value-of select="location_name"/>
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
							<br /><xsl:value-of select="notification_data/organization_unit/name" />
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