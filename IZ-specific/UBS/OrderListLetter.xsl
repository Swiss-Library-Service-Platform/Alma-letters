<?xml version="1.0" encoding="utf-8"?>
<!-- Order List Letter, 2021011, UBS -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="header.xsl"/>
	<xsl:include href="senderReceiver.xsl"/>
	<xsl:include href="mailReason.xsl"/>
	<xsl:include href="footer.xsl"/>
	<xsl:include href="style.xsl"/>
	<xsl:template match="/">
		<html>
			<head>
				<xsl:call-template name="generalStyle"/>
			</head>
			<body>
				<xsl:attribute name="style">
					<xsl:call-template name="bodyStyleCss"/>
					<!-- style.xsl -->
				</xsl:attribute>
				<table width="100%">
					<tr>
						<td>
							<b>
								@@letterName@@
							</b>
						</td>
						<td align="right">
							<xsl:value-of select="notification_data/general_data/current_date"/>
						</td>
					</tr>
					<tr>
						<td>
							<i>
								<xsl:value-of select="/notification_data/receivers/receiver/vendor_account/code"/>
								<xsl:if test="string-length(/notification_data/po/vendor_account/description)!=0">
								&#160;/&#160;<xsl:value-of select="/notification_data/po/vendor_account/description"/>
								</xsl:if>
							</i>
						</td>
					</tr>
				</table>
				<br/>
				<br/>
				<xsl:for-each select="notification_data/letter_texts">
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>@@place_order_introduction@@</td>
						</tr>
						<tr>
							<td>@@sincerely@@</td>
						</tr>
						<tr>
							<td>@@department@@<br/>
								<xsl:value-of select="/notification_data/organization_unit/name"/>
							</td>
						</tr>
					</table>
				</xsl:for-each>
				<xsl:for-each select="notification_data">
				<br/>
				<br/>
					<table cellspacing="0" cellpadding="5" border="0" width="100%">
						<tr>
							<td>
								<i>@@shipping_address@@</i>
							</td>
							<td>
								<i>@@billing_address@@</i>
							</td>
						</tr>
						<tr>
							<td>
								<xsl:value-of select="/notification_data/po/ship_to_address/line1"/>
								<br/>
								<xsl:value-of select="/notification_data/po/ship_to_address/line2"/>
								<br/>
								<xsl:if test="string-length(/notification_data/po/ship_to_address/line3)!=0">
									<xsl:value-of select="/notification_data/po/ship_to_address/line3"/>
									<br/>
								</xsl:if>
								<xsl:if test="string-length(/notification_data/po/ship_to_address/line4)!=0">
									<xsl:value-of select="/notification_data/po/ship_to_address/line4"/>
									<br/>
								</xsl:if>
								<xsl:if test="string-length(/notification_data/po/ship_to_address/line5)!=0">
									<xsl:value-of select="/notification_data/po/ship_to_address/line5"/>
									<br/>
								</xsl:if>
								<xsl:value-of select="/notification_data/po/ship_to_address/postal_code"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/city"/>
								<br/>
								<xsl:value-of select="/notification_data/po/ship_to_address/country_display"/>
								<!-- ship_to_address -> kein XML für email oder Telephon?-->
							</td>
							<td>
								<xsl:value-of select="/notification_data/po/bill_to_address/line1"/>
								<br/>
								<xsl:value-of select="/notification_data/po/bill_to_address/line2"/>
								<br/>
								<xsl:if test="string-length(/notification_data/po/bill_to_address/line3)!=0">
									<xsl:value-of select="/notification_data/po/bill_to_address/line3"/>
									<br/>
								</xsl:if>
								<xsl:if test="string-length(/notification_data/po/bill_to_address/line4)!=0">
									<xsl:value-of select="/notification_data/po/bill_to_address/line4"/>
									<br/>
								</xsl:if>
								<xsl:if test="string-length(/notification_data/po/bill_to_address/line5)!=0">
									<xsl:value-of select="/notification_data/po/bill_to_address/line5"/>
									<br/>
								</xsl:if>
								<xsl:value-of select="/notification_data/po/bill_to_address/postal_code"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/city"/>
								<br/>
								<xsl:value-of select="/notification_data/po/bill_to_address/country_display"/>
								<!-- bill_to_address -> kein XML für email oder Telephon? -->
							</td>
						</tr>
					</table>
				</xsl:for-each>
				<br/>
				<br/>
				<br/>
				<table cellpadding="5" class="listing">
					<xsl:attribute name="style">
						<xsl:call-template name="mainTableStyleCss"/>
						<!-- style.xsl -->
					</xsl:attribute>
					<tr>
						<!--					<th>@@po_line_number@@</th>-->
						<th align="left">@@po_line_number@@</th>
						<!-- 						<th>@@date@@</th> -> siehe letter_date, create date ist intern relevant. -->
						<!-- 						<th>@@issn_isbn@@</th> -->
						<!-- 						<th>@@title@@</th> -->
						<!-- 						<th>@@quantity@@</th> -->
						<!-- 						<th align="right">@@price@@</th> -->
						<!--						<th>@@note@@</th> -->
						<th>@@quantity@@</th>
						<th align="left">@@title@@</th>
						<th align="left">@@price@@</th>
					</tr>
					<xsl:for-each select="notification_data/po/po_line_list/po_line">
						<tr valign="top">
							<td>
								<b>
									<xsl:value-of select="line_reference"/>
								</b>
								<br/>
								<xsl:value-of select="funds_transaction_items/funds_transaction_item/fund/name"/>
								<br/>
								<i>
									<xsl:value-of select="substring-after(secondary_reporting_code,'RC2-')"/>
								</i>
								<br/>
							</td>
							<td align="center">
								<xsl:value-of select="total_quantity"/>
							</td>
							<td>
								<xsl:value-of select="meta_data_values/title"/>
								<br/>
								<xsl:value-of select="meta_data_values/acqterms_place"/>:&#160;<xsl:value-of select="meta_data_values/publisher"/>,&#160;<xsl:value-of select="meta_data_values/date"/>
								<br/>
								<xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/>
								<xsl:choose>
									<xsl:when test="rush='true'">
										<br/>
										<br/>
										<b>rush order / Eilbestellung / commande urgente / ordine urgente</b>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="string-length(vendor_note)!=0">
										<br/>
										<br/>
										<b>@@note@@<xsl:text>: </xsl:text>
										</b>
										<xsl:value-of select="vendor_note"/>
									</xsl:when>
									<xsl:otherwise/>
								</xsl:choose>
							</td>
							<td align="right">
								<xsl:value-of select="total_price_compose_with_normalized_sum/normalized_sum"/>&#160;<xsl:value-of select="total_price_compose/currency"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<br/>
				<br/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>