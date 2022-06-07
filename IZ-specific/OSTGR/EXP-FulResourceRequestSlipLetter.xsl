<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP Customized 11/2021 -->
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
									<td>@@edition@@:
										<xsl:value-of select="notification_data/phys_item_display/edition"/>
									</td>
								</tr>
							</xsl:if>
							<!-- <xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if> -->
							<!-- DBL (4. 6. 2021): Added Series field to better localize norms 
								Reused Bcc for Series label -->
							<xsl:if test="notification_data/request/record_display_section/series_small != ''">
								<tr>
									<td>@@Bcc@@:
										<xsl:value-of select="notification_data/request/record_display_section/series_small"/>
									</td>
								</tr>
							</xsl:if>
							<!-- DBL -->
							<strong></strong>
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
							<tr>
								<td>
									<strong>@@request_type@@: </strong>
									<xsl:value-of select="notification_data/request_type"/>
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
							<xsl:if test="notification_data/request/note != ''">
								<tr>
									<td>
										<strong>@@request_note@@:</strong>
										<xsl:value-of select="notification_data/request/note"/>
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
											<strong>
												<xsl:call-template name="SLSP-multilingual">
													<xsl:with-param name="en" select="'Available items'"/>
													<xsl:with-param name="fr" select="'Exemplaires disponibles'"/>
													<xsl:with-param name="it" select="'Copie disponibili'"/>
													<xsl:with-param name="de" select="'Verfügbare Exemplare'"/>
												</xsl:call-template>
											</strong>
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