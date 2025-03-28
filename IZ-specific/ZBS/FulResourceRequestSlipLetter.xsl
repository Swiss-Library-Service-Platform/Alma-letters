<?xml version="1.0" encoding="utf-8"?>
<!-- IZ specific: anonymization
	
	SLSP Customized 05/2022
        05/2022 Deleted duplicit fields ISSN, ISBN, Imprint
		05/2022 Added rapido request note, rapido volume, rapido pages 
		08/2022 Added anonymization to print existing Hold Shelf slips
		10/2022 added personal delivery field extraction
		11/2022 add extraction for destination of Rapido requests
		03/2025 added chapter title, author and pages for GetIt digitization requests
    Dependancy:
        recordTitle - recordTitle, SLSP-Rapido-request-note, SLSP-Rapido-extract-volume, SLSP-Rapido-extract-pages
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
			<!-- <h1>
				<strong>@@requested_for@@ :
							<xsl:value-of select="notification_data/user_for_printing/name"/>
				</strong>
			</h1> -->


				<xsl:call-template name="head" /> <!-- header.xsl -->



			<div class="messageArea">
				<div class="messageBody">
					 <table role='presentation'  cellspacing="0" cellpadding="5" border="0">
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><strong>@@note_item_specified_request@@.</strong></td>
						</tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/manual_description != ''" >
						<tr>
							<td><strong>@@please_note@@: </strong>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
						</tr>
						</xsl:if>
						<tr>
							<td><strong>@@request_id@@: </strong><img src="cid:request_id_barcode.png" alt="Request Barcode"/></td>
						</tr>
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
						<tr>
							<td><strong>@@item_barcode@@: </strong><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
						</tr>
						</xsl:if>
						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><strong>@@external_id@@: </strong><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>

						<!-- <xsl:if test="notification_data/user_for_printing/name">

						<tr>
							<td>
						<strong>@@requested_for@@: </strong>
							<xsl:value-of select="notification_data/user_for_printing/name"/></td>
						</tr>

						</xsl:if> -->
						
						<xsl:if test="notification_data/proxy_requester/name">
							<tr>
								<td><strong>@@proxy_requester@@: </strong><xsl:value-of select="notification_data/proxy_requester/name"/></td>
							</tr>
						</xsl:if>

						<tr>
							<td><xsl:call-template name="recordTitle" />
							</td>
						</tr>
						<xsl:if test="notification_data/phys_item_display/edition != ''">
							<tr>
							<td>@@edition@@: <xsl:value-of select="notification_data/phys_item_display/edition"/></td>
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
						<tr>
							<td><h2><strong>@@location@@: </strong><xsl:value-of select="notification_data/phys_item_display/location_name"/></h2></td>
							<xsl:if test="notification_data/phys_item_display/call_number != ''">
								<td><h2><strong>@@call_number@@: </strong><xsl:value-of select="notification_data/phys_item_display/call_number"/></h2></td>
							</xsl:if>
							<xsl:if test="notification_data/phys_item_display/accession_number != ''">
								<td><h2><strong>@@accession_number@@: </strong><xsl:value-of select="notification_data/phys_item_display/accession_number"/></h2></td>
							</xsl:if>
						</tr>
						<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><strong>@@shelving_location_for_item@@: </strong>
								 <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td><strong>@@shelving_locations_for_holding@@: </strong>
								<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td><strong>@@shelving_locations_for_holding@@: </strong>
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
								<td><strong>@@alt_call_number@@: </strong>
								 <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td><strong>@@alt_call_number@@: </strong>
								<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td><strong>@@alt_call_number@@: </strong>
								<xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
						</xsl:if>
						<!-- SLSP: extract destination for Rapido requests -->
						<xsl:variable name="destination">
							<xsl:call-template name="SLSP-Rapido-destination" />
						</xsl:variable>
						<tr>
							<td><strong>@@move_to_library@@: </strong><xsl:value-of select="$destination"/></td>
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
							<td><strong>@@system_notes@@:</strong><xsl:value-of select="notification_data/request/system_notes"/></td>
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
						<xsl:if test="notification_data/user_for_printing/name">
							<tr>
								<td colspan="3">
									<br />
									<h1>@@requested_for@@: 
										<!-- SLSP: Anonymization based on last 3 digits of Barcode NZ or Barcode IZ -->
										<!-- set the Barcode NZ, if there are more then only first one is returned -->
										<xsl:variable name="NZ_barcode">
											<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='02']/value"/>
										</xsl:variable>
										<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
										<xsl:variable name="edu-id_barcode">
											<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='01']/value"/>
										</xsl:variable>
										<!-- set the Barcode edu-ID, if there are more then only first one is returned -->
										<xsl:variable name="IZ_barcode">
											<xsl:value-of select="notification_data/user_for_printing/identifiers/code_value[code='03']/value"/>
										</xsl:variable>
										<xsl:choose>
											<xsl:when test="$NZ_barcode != ''">
												<xsl:value-of select="$NZ_barcode"/>
											</xsl:when>
											<xsl:when test="$IZ_barcode != ''">
												<xsl:value-of select="$IZ_barcode"/>
											</xsl:when>
											<xsl:when test="$edu-id_barcode != ''">
												<xsl:value-of select="$edu-id_barcode"/>
											</xsl:when>
										</xsl:choose>
									</h1>
								</td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div>
	<!-- <xsl:call-template name="lastFooter" />  --><!-- footer.xsl -->
</body>
</html>


	</xsl:template>
</xsl:stylesheet>