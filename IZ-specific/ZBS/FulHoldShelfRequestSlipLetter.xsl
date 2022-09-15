<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 05/2022
	05/2022 Added anonymization
	05/2022 Formatted as Resource Request Slip Letter
	07/2022 Added anonymizatio with barcodes-->
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
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
				<xsl:call-template name="head" /> <!-- header.xsl -->
			<div class="messageArea">
				<div class="messageBody">
					 <table cellspacing="0" cellpadding="5" border="0">
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
                            <tr>
                                <td><b>@@note_item_specified_request@@.</b></td>
                            </tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/manual_description != ''" >
                            <tr>
                                <td><b>@@please_note@@: </b>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description"/></td>
                            </tr>
						</xsl:if>
						<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
                            <tr>
                                <td><b>@@item_barcode@@: </b><img src="cid:item_id_barcode.png" alt="Item Barcode"/></td>
                            </tr>
						</xsl:if>
						<xsl:if  test="notification_data/external_id != ''" >
							<tr>
								<td><b>@@external_id@@: </b><xsl:value-of select="notification_data/external_id"/></td>
							</tr>
						</xsl:if>
                        <tr>
							<td><b>@@move_to_library@@: </b><xsl:value-of select="notification_data/destination"/></td>
						</tr>
						<tr>
							<td><b>@@request_type@@: </b><xsl:value-of select="notification_data/request_type"/></td>
						</tr>

						<xsl:if test="notification_data/request/system_notes != ''">
							<tr>
                                <td><b>@@system_notes@@:</b><xsl:value-of select="notification_data/request/system_notes"/></td>
                            </tr>
						</xsl:if>

						<xsl:if test="notification_data/request/note != ''">
							<tr>
                                <td><b>@@request_note@@:</b> <xsl:value-of select="notification_data/request/note"/></td>
                            </tr>
						</xsl:if>
						<tr>
							<td><xsl:call-template name="recordTitle" /></td>
						</tr>
						<tr>
							<td>
								<b>@@location@@: </b><xsl:value-of select="notification_data/phys_item_display/location_name"/><br />
								<xsl:if test="notification_data/phys_item_display/call_number != ''">
									<b>@@call_number@@: </b><xsl:value-of select="notification_data/phys_item_display/call_number"/><br />
								</xsl:if>
								<xsl:if test="notification_data/phys_item_display/accession_number != ''">
									<b>@@accession_number@@: </b><xsl:value-of select="notification_data/phys_item_display/accession_number"/><br />
								</xsl:if>
							</td>
						</tr>
						<xsl:if  test="notification_data/phys_item_display/shelving_location/string" >
							<xsl:if  test="notification_data/request/selected_inventory_type='ITEM'" >
							<tr>
								<td><b>@@shelving_location_for_item@@: </b>
								 <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								 &#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
							<tr>
								<td><b>@@shelving_locations_for_holding@@: </b>
								<xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
									<xsl:value-of select="."/>
								&#160;
								 </xsl:for-each>
								</td>
							</tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
							<tr>
								<td><b>@@shelving_locations_for_holding@@: </b>
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
                                    <td><b>@@alt_call_number@@: </b>
                                    <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                        <xsl:value-of select="."/>
                                    &#160;
                                    </xsl:for-each>
                                    </td>
                                </tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='HOLDING'" >
                                <tr>
                                    <td><b>@@alt_call_number@@: </b>
                                    <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                        <xsl:value-of select="."/>
                                    &#160;
                                    </xsl:for-each>
                                    </td>
                                </tr>
							</xsl:if>
							<xsl:if  test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'" >
                                <tr>
                                    <td><b>@@alt_call_number@@: </b>
                                    <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                        <xsl:value-of select="."/>
                                    &#160;
                                    </xsl:for-each>
                                    </td>
                                </tr>
							</xsl:if>
						</xsl:if>
                        <tr>
							<td>
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
					</table>
				</div>
			</div>
	<!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->

</body>
</html>
</xsl:template>
</xsl:stylesheet>