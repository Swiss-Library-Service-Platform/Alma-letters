<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- IZ specific: receipt printer format
    SLSP Customized
        05/2024 changed format to fit receipt printer (SUPPORT-29017)-->
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
            <head>
                <xsl:call-template name="generalStyle" />
            </head>

            <body>
                <h2>
                    <strong>@@requested_for@@ : <xsl:value-of select="notification_data/user_for_printing/name" />
                    </strong>
                </h2>
                
                <xsl:call-template name="head-letterName-print-date" />

                <div class="messageArea">
                    <div class="messageBody">
                        <xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
                            <p>
                                <strong>@@note_item_specified_request@@.</strong>
                            </p>
                        </xsl:if>
                        <xsl:if test="notification_data/request/manual_description != ''">
                            <p>
                                <strong>@@please_note@@: </strong>@@manual_description_note@@ - <xsl:value-of select="notification_data/request/manual_description" />
                            </p>
                        </xsl:if>
                        <p>
                            <strong>@@request_id@@:</strong>
                            <br />
                            <img src="cid:request_id_barcode.png" alt="Request Barcode" />
                        </p>
                        <p>
                            <strong>@@item_barcode@@: </strong>
                            <br/>
                            <img src="cid:item_id_barcode.png" alt="Item Barcode" />
                        </p>

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
                            </p>
                        </xsl:if>

                        <xsl:if test="notification_data/proxy_requester/name">
                            <p>
                                <strong>@@proxy_requester@@: </strong>
                                <xsl:value-of select="notification_data/proxy_requester/name" />
                            </p>
                        </xsl:if>

                        <p>
                            <xsl:call-template name="recordTitle" />
                        </p>

                        <xsl:if test="notification_data/phys_item_display/edition != ''">
                            <p>
                                <strong>@@edition@@: </strong><xsl:value-of select="notification_data/phys_item_display/edition" />
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
                                            <xsl:value-of select="." /> &#160;
                                        </xsl:for-each>
                                    </p>
                            </xsl:if>
                            <xsl:if test="notification_data/request/selected_inventory_type='HOLDING'">
                                <p>
                                    <strong>@@shelving_locations_for_holding@@: </strong>
                                    <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                        <xsl:value-of select="." /> &#160;
                                    </xsl:for-each>
                                </p>
                            </xsl:if>
                            <xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'">
                                <p>
                                    <strong>@@shelving_locations_for_holding@@: </strong>
                                    <xsl:for-each select="notification_data/phys_item_display/shelving_location/string">
                                        <xsl:value-of select="." /> &#160;
                                    </xsl:for-each>
                                </p>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="notification_data/phys_item_display/display_alt_call_numbers/string">
                            <xsl:if test="notification_data/request/selected_inventory_type='ITEM'">
                                    <p>
                                        <strong>@@alt_call_number@@: </strong>
                                        <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                            <xsl:value-of select="." /> &#160;
                                        </xsl:for-each>
                                    </p>
                            </xsl:if>
                            <xsl:if test="notification_data/request/selected_inventory_type='HOLDING'">
                                <p>
                                    <strong>@@alt_call_number@@: </strong>
                                    <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                        <xsl:value-of select="." /> &#160;
                                    </xsl:for-each>
                                </p>
                            </xsl:if>
                            <xsl:if test="notification_data/request/selected_inventory_type='VIRTUAL_HOLDING'">
                                <p>
                                    <strong>@@alt_call_number@@: </strong>
                                    <xsl:for-each select="notification_data/phys_item_display/display_alt_call_numbers/string">
                                        <xsl:value-of select="." /> &#160;
                                    </xsl:for-each>
                                </p>
                            </xsl:if>
                        </xsl:if>

                        <p>
                            <strong>@@move_to_library@@: </strong>
                            <xsl:value-of select="notification_data/destination" />
                        </p>
                        <p>
                            <strong>@@request_type@@: </strong>
                            <xsl:value-of select="notification_data/request_type" />
                        </p>

                        <xsl:if test="notification_data/request/system_notes != ''">
                            <p>
                                <strong>@@system_notes@@: </strong>
                                <xsl:value-of select="notification_data/request/system_notes" />
                            </p>
                        </xsl:if>

                        <xsl:if test="notification_data/request/note != ''">
                            <p>
                                <strong>@@request_note@@: </strong>
                                <xsl:value-of select="notification_data/request/note" />
                            </p>
                        </xsl:if>
                    </div>
                </div>
            <!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>