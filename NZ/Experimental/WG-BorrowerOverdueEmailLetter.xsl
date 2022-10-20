<?xml version="1.0" encoding="utf-8"?>
<!-- WG: Letters 10/2022
	Dependancy:
		header - head
		style - generalStyle, bodyStyleCss, listStyleCss
		recordTitle - SLSP-multilingual, SLSP-greeting-ILL
		10/2022 -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl" />
	<xsl:include href="senderReceiver.xsl" />
	<xsl:include href="mailReason.xsl" />
	<xsl:include href="footer.xsl" />
	<xsl:include href="style.xsl" />
	<xsl:include href="recordTitle.xsl" />

	<xsl:template name="senderReceiver-ILL">
		<!-- Adapted by SLSP - delivery address on right
		- Fixed padding for envelopes with window
		- Delivery address bold
		- Sender address smaller font -->
		<table cellspacing="0" cellpadding="5" border="0" width="100%">
			<tr>
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 10mm;">
					<xsl:choose>
						<xsl:when test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1">
							<table>
								<xsl:attribute name="style">
									font-size: 80%;
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address1" />
									</td>
								</tr>
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
								<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address5 !=''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/address5" />
										</td>
									</tr>
								</xsl:if>
								<tr>
									<td>
										<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/postal_code"/>&#160;<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/city"/>
									</td>
								</tr>
								<xsl:if test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/country != ''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/country"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="string-length(notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/phone)!=0">
									<tr><td><xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/phone"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/email)!=0">
									<tr><td><xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/email"/></td></tr>
								</xsl:if>
							</table>
						</xsl:when>
						<xsl:otherwise>
							<table>
								<xsl:attribute name="style">
									font-size: 80%;
									<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
								</xsl:attribute>
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
								<xsl:if test="notification_data/library/address/country_display != ''">
									<tr>
										<td>
											<xsl:value-of select="notification_data/library/address/country_display"/>
										</td>
									</tr>
								</xsl:if>
								<xsl:if test="string-length(notification_data/library/phone/phone)!=0">
									<tr><td><xsl:value-of select="notification_data/library/phone/phone"/></td></tr>
								</xsl:if>
								<xsl:if test="string-length(notification_data/library/email/email)!=0">
									<tr><td><xsl:value-of select="notification_data/library/email/email"/></td></tr>
								</xsl:if>
							</table>
						</xsl:otherwise>
					</xsl:choose>
				</td>
				<td width="50%" align="left" style="padding: 10mm 10mm 10mm 15mm; vertical-align: top;">
					<table cellspacing="0" cellpadding="0" border="0">
						<xsl:attribute name="style">
							font-weight: 600;
							<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
						</xsl:attribute>
						<xsl:if test="string-length(notification_data/partner_address/line1)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line1"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line2)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line2"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line3)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line3"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line4)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line4"/></td></tr>
						</xsl:if>
						<xsl:if test="string-length(notification_data/partner_address/line5)!=0">
							<tr><td><xsl:value-of select="notification_data/partner_address/line5"/></td></tr>
						</xsl:if>
						<tr><td><xsl:value-of select="notification_data/partner_address/postal_code"/>&#160;<xsl:value-of select="notification_data/partner_address/city"/></td></tr>
						<tr><td>
							<xsl:value-of select="notification_data/partner_address/country_display"/>
						</td></tr>
					</table>
				</td>
			</tr>
		</table>
		<br/>
	</xsl:template>

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
				<xsl:call-template name="senderReceiver-ILL" />
				<div class="messageArea">
					<div class="messageBody">
						<table cellspacing="0" cellpadding="5" border="0">
							<xsl:attribute name="style">
								<xsl:call-template name="listStyleCss" />
							</xsl:attribute>
							<tr>
								<td>
									<xsl:call-template name="SLSP-multilingual">
										<xsl:with-param name="en" select="'Dear Colleagues,'"/>
										<xsl:with-param name="fr" select="'Cher(e)s collègues,'"/>
										<xsl:with-param name="it" select="'Care colleghe e cari colleghi,'"/>
										<xsl:with-param name="de" select="'Liebe Kolleginen und Kollegen'"/>
									</xsl:call-template>
								</td>
							</tr>
							<tr>
								<td>
									@@overdue_message@@
								</td>
							</tr>
							<tr>
								<td>
									<br/>
									<strong><xsl:value-of select="notification_data/request/display/title" /></strong>
									<xsl:if test="notification_data/request/display/author">
										<br/>
										<xsl:value-of select="notification_data/request/display/author" />
									</xsl:if>
									<!--SLSL added imprint-->
									<xsl:if test="notification_data/phys_item_display/publication_place">
										<br/>
										<xsl:value-of select="notification_data/phys_item_display/publication_place"/>:&#160;
										<xsl:value-of select="notification_data/phys_item_display/publisher"/>,&#160;
										<xsl:value-of select="notification_data/phys_item_display/publication_date"/>
									</xsl:if>
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
									<b> @@request_date@@: </b>
									<xsl:value-of select="notification_data/request/create_date" />
								</td>
							</tr>
							<tr>
								<td>
									<b>@@orignal_due_date@@: </b>
									<xsl:value-of select="notification_data/request/due_date"/>
								</td>
							</tr>
							<tr>
								<td>
									<br/>
									@@signature@@
								</td>
							</tr>
							<tr>
								<td>
									<xsl:choose>
										<xsl:when test="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/name">
											<xsl:value-of select="notification_data/phys_items_display/physical_item_display_for_printing/owning_library_details/name" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="notification_data/library/name" />
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td>
									<br/>
									<i>powered by SLSP</i>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>