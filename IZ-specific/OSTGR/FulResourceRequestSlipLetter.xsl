<?xml version="1.0" encoding="utf-8"?>
<!--SLSP Customized 11/2021
	11/2021 - hidden second imprint
	11/2021 - adjusted series output so all 830 fields get printed
	05/2022 - Added rapido request note, rapido volume, rapido pages
	06/2022 added personal delivery field extraction
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
							<!-- <xsl:if test="notification_data/phys_item_display/imprint != ''">
								<tr>
								<td>@@imprint@@: <xsl:value-of select="notification_data/phys_item_display/imprint"/></td>
								</tr>
							</xsl:if> -->
							<!-- DBL (4. 6. 2021): Added Series field to better localize norms 
								Reused Bcc for Series label -->
							<xsl:if test="notification_data/request/record_display_section/series_small != ''">
								<tr>
									<td>
										@@Bcc@@:
										<xsl:for-each select="notification_data/request/record_display_section/series_small_list/string">
											<xsl:value-of select="."/>;
										</xsl:for-each>
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
												<xsl:value-of select="."/>&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
								<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
									<tr>
										<td>
											<strong>@@alt_call_number@@: </strong>
											<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
												<xsl:value-of select="."/>&#160;
											</xsl:for-each>
										</td>
									</tr>
								</xsl:if>
							</xsl:if>
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