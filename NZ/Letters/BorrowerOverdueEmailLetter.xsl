<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200930, SLSP -->
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
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss" />
					<!-- style.xsl -->
				</xsl:attribute>
				<xsl:call-template name="head" />
				<!-- header.xsl -->

				<div class="messageArea">
					<div class="messageBody">
						<table cellspacing="0" cellpadding="5" border="0">

							<tr>
								<td>
									@@overdue_message@@
									@@orignal_due_date@@: <xsl:value-of select="notification_data/request/due_date"/>.
									<br/>
									@@return_message@@
								</td>

							</tr>

						</table>
						<table cellspacing="0" cellpadding="5" border="0">

							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" />
							</xsl:attribute>

							<tr>
								<td>
									<b>@@request_info@@:</b>
								</td>
							</tr>

							<tr>
								<td>
									<b>@@request_id@@: </b>
									<xsl:value-of select="notification_data/request/external_request_id" />
								</td>
							</tr>

							<tr>
								<td>
									<b>@@title@@: </b>
									<xsl:value-of select="notification_data/request/display/title" />
								</td>
							</tr>
							<tr>
								<td>
									<b> @@author@@: </b>
									<xsl:value-of select="notification_data/request/display/author" />
								</td>
							</tr>
							<tr>
								<td>
									<b> @@request_date@@: </b>
									<xsl:value-of select="notification_data/request/create_date" />
								</td>
							</tr>
							<tr>
								<td>
									<b> @@needed_by_date@@: </b>
									<xsl:value-of select="notification_data/request/needed_by" />
								</td>
							</tr>
							<tr>
								<td>
									<b> @@supplied_date@@: </b>
									<xsl:value-of select="notification_data/request/item_sent_date" />
								</td>
							</tr>

						</table>
						<br />
						<table>

							<tr>
								<td>@@signature@@</td>
							</tr>
                                                                <xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1 =''">

							<xsl:if test="notification_data/library/address/line1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line4" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/line5 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/line5" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/library/address/city !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/library/address/postal_code" />&#160;<xsl:value-of select="notification_data/library/address/city" />
									</td>
								</tr>
							</xsl:if>


							</xsl:if>

                                 <xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1 !=''">

							<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address2 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address2" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address3 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address3" />
									</td>
								</tr>
							</xsl:if>
							<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address4 !=''">
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address4" />
									</td>
								</tr>
							
                                                        </xsl:if>

							</xsl:if>
                                                                                               <tr>
                                               <td><br/><i>powered by SLSP</i></td>
                                                </tr>

				
						</table>
					</div>
				</div>

			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
