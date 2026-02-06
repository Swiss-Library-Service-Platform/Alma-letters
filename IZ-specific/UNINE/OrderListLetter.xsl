<?xml version="1.0" encoding="utf-8"?>
<!-- IZ Customization: adapted formatting and added more metadata
	
    08/2025 - moved shipping and billing address to the bottom
    08/2025 - changed format of displayed metadata for order lines, added more metadata fields (publication place, publisher, publication date, edition, series uniform title, note)
-->	
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<xsl:template match="/">
	<html>
		<head>
		<xsl:call-template name="generalStyle" />
		</head>

			<body>
			<xsl:attribute name="style">
			<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<br />
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

				<xsl:for-each select="notification_data/letter_texts">
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>@@place_order_introduction@@:</td>
					</tr>
				</table>

				<br />

				</xsl:for-each>

				<br />
				<xsl:for-each select="notification_data">
				<table>
					<tr>
						<td><b>@@order_date@@: </b> <xsl:value-of select="/notification_data/po/create_date"/></td>
					</tr>
					<tr>
						<td><b>@@vendor_account@@: </b><xsl:value-of select="/notification_data/po/vendor_account/description"/></td>
					</tr>
<xsl:if test="/notification_data/po/number != ''">
						<tr>
							<td><b>@@erp_number@@: </b><xsl:value-of select="/notification_data/po/number"/></td>
						</tr>
					</xsl:if>
										
				</table>
				</xsl:for-each>
				<br />
				

				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>

				<xsl:for-each select="notification_data/po/po_line_list/po_line">
					<tr><td colspan="2"><hr></hr></td></tr>
					<tr>	<td><b>@@po_line_number@@</b></td> <td><xsl:value-of select="line_reference"/></td></tr>
					
					<tr>	<td><b>@@date@@</b></td> <td><xsl:value-of select="create_date"/></td></tr>
					<tr>	<td><b>@@issn_isbn@@</b></td> <td><xsl:value-of select="identifier"/></td></tr>
					<xsl:if test="creator != ''">
					<tr>	<td><b>@@alternate_creator@@</b></td> <td><xsl:value-of select="creator"/></td></tr>
					</xsl:if>
					<tr>	<td valign="top"><b>@@title@@</b></td> <td><xsl:value-of select="title"/></td></tr>
					<tr>	<td><b>Publ.</b></td> <td><xsl:value-of select="publication_place"/> : <xsl:value-of select="publisher"/>, <xsl:value-of select="publication_date"/></td></tr>
					<xsl:if test="meta_data_values/acqterms_edition != ''">
					<tr>	<td><b>@@alternate_complete_edition@@</b></td> <td><xsl:value-of select="meta_data_values/acqterms_edition"/></td></tr>	
					</xsl:if>
					<xsl:if test="series_uniform_title != ''">
					<tr>	<td valign="top"><b>@@830_series_uniform_title@@</b></td> <td valign="top"><xsl:value-of select="series_uniform_title"/></td></tr>
					</xsl:if>
					<xsl:if test="vendor_note != ''">
					<tr>	<td><b>@@note@@</b></td> <td><xsl:value-of select="vendor_note"/></td></tr>
					</xsl:if>
					<tr>	<td><b>@@quantity@@</b></td> <td><xsl:value-of select="total_quantity"/></td> </tr>
					</xsl:for-each>	
					<tr><td colspan="2"><hr></hr></td></tr>
					</table>
				<br />

				<table>
<tr>
						<td><b>@@shipping_address@@: </b><xsl:value-of select="/notification_data/po/ship_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/ship_to_address/country"/></td>
					</tr>
					<tr>
						<td><b>@@billing_address@@: </b><xsl:value-of select="/notification_data/po/bill_to_address/line1"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/line2"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/city"/>&#160;<xsl:value-of select="/notification_data/po/bill_to_address/country"/></td>
					</tr></table>
<br />
<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td>@@department@@</td></tr>

				</table>
				
				<xsl:call-template name="lastFooter" /> <!-- footer.xsl -->			
				
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>