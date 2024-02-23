<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 11/2021
    02/2024 - removed the organization name from billing and shipping address as per request: SUPPORT-26777
    Dependance:
        recordTitle - SLSP-multilingual
        style - bodyStyleCss, generalStyle, mainTableStyleCss
        header - head
        senderReceiver - senderReceiver
         -->
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
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" /> <!-- header.xsl -->
				<xsl:call-template name="senderReceiver" /> <!-- SenderReceiver.xsl -->

				<!-- <xsl:call-template name="toWhomIsConcerned" /> --> <!-- mailReason.xsl -->

				<xsl:for-each select="notification_data">
				<table>
					<tr>
						<td><b>@@order_date@@: </b> <xsl:value-of select="po/create_date"/></td>
					</tr>
					<tr>
						<td><b>@@vendor_account@@: </b><xsl:value-of select="po/vendor_account/description"/></td>
					</tr>
                    <tr>
                        <td>
                            <strong><xsl:call-template name="SLSP-multilingual">
                                <xsl:with-param name="en" select="'PO number'"/>
                                <xsl:with-param name="fr" select="'Numéro de commande'"/>
                                <xsl:with-param name="it" select="'Numero PO'"/>
                                <xsl:with-param name="de" select="'Bestellnummer'"/>
                            </xsl:call-template>: </strong><xsl:value-of select="po/number"/>
                        </td>
                    </tr>
                    <!-- <tr>
                        <td><b>@@shipping_method@@: </b><xsl:value-of select="/notification_data/po/shipping_method"/></td>
                    </tr> -->
					<xsl:if test="po/erp_number != ''">
						<tr>
							<td><b>@@erp_number@@: </b><xsl:value-of select="po/erp_number"/></td>
						</tr>
					</xsl:if>
				</table>
                
                <table width="100%">
                    <tr>
                        <td width="50%">
                            <b>@@shipping_address@@: </b><br />
                            <!-- removed the organization name as per request: SUPPORT-26777 -->
                            <xsl:if test="po/ship_to_address/line1 != ''">
                                <xsl:value-of select="po/ship_to_address/line1"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/line2 != ''">
                                <xsl:value-of select="po/ship_to_address/line2"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/line3 != ''">
                                <xsl:value-of select="po/ship_to_address/line3"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/line4 != ''">
                                <xsl:value-of select="po/ship_to_address/line4"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/line5 != ''">
                                <xsl:value-of select="po/ship_to_address/line5"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/city != ''">
                                <xsl:value-of select="po/bill_to_address/postal_code"/>&#160;<xsl:value-of select="po/ship_to_address/city"/><br />
                            </xsl:if>
                            <xsl:if test="po/ship_to_address/country != ''">
                                <xsl:value-of select="po/ship_to_address/country"/>
                            </xsl:if>
                        </td>
                        <td width="50%">
                            <b>@@billing_address@@: </b><br />
                            <!-- removed the organization name as per request: SUPPORT-26777 -->
                            <xsl:if test="po/bill_to_address/line1 != ''">
                                <xsl:value-of select="po/bill_to_address/line1"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/line2 != ''">
                                <xsl:value-of select="po/bill_to_address/line2"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/line3 != ''">
                                <xsl:value-of select="po/bill_to_address/line3"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/line4 != ''">
                                <xsl:value-of select="po/bill_to_address/line4"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/line5 != ''">
                                <xsl:value-of select="po/bill_to_address/line5"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/city != ''">
                                <xsl:value-of select="po/bill_to_address/postal_code"/>&#160;<xsl:value-of select="po/bill_to_address/city"/><br />
                            </xsl:if>
                            <xsl:if test="po/bill_to_address/country != ''">
                                <xsl:value-of select="po/bill_to_address/country"/>
                            </xsl:if>
                        </td>                                    
                    </tr>
                </table>

				</xsl:for-each>
				<br />
                <br />

                <xsl:for-each select="notification_data/letter_texts">
                    <table cellspacing="0" cellpadding="5" border="0">
                        <tr>
                            <td>@@place_order_introduction@@:</td>
                        </tr>
                    </table>
                    <br />

                </xsl:for-each>

				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
					<tr>
						<th>
                            @@po_line_number@@
                            /
                            <xsl:call-template name="SLSP-multilingual">
                                <xsl:with-param name="en" select="'Fund'"/>
                                <xsl:with-param name="fr" select="'Fonds'"/>
                                <xsl:with-param name="it" select="'Fondo'"/>
                                <xsl:with-param name="de" select="'Fonds'"/>
                            </xsl:call-template>
                        </th>
                        
						<!-- <th>@@date@@</th> -->
						<!-- <th>@@issn_isbn@@</th> -->
						<th>@@title@@</th>
						
						<!-- <th>@@note@@</th> -->
                        <th>@@quantity@@</th>
                        <th>@@price@@</th>
					</tr>
					<xsl:for-each select="notification_data/po/po_line_list/po_line">
					<tr>
						<td>
                            <xsl:value-of select="line_reference"/>
                            / <br />
                            <xsl:value-of select="funds_transaction_items/funds_transaction_item/fund/name"/>
                        </td>
						<!-- <td><xsl:value-of select="create_date"/></td> -->
                        
						<td>
                            <xsl:value-of select="meta_data_values/title"/><br />
                            <xsl:value-of select="meta_data_values/acqterms_place"/>:
                            <xsl:value-of select="meta_data_values/publisher"/>,
                            <xsl:value-of select="meta_data_values/date"/><br />
                            <xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/><br />
                            <xsl:if test="vendor_note !=''">
                                <strong>@@note@@:&#160;<xsl:value-of select="vendor_note"/></strong>
                            </xsl:if>
                        </td>
						
                        <td align="center">
                            <xsl:value-of select="total_quantity"/><br />
                            <xsl:if test="rush = 'true'">
                                <strong><xsl:call-template name="SLSP-multilingual">
                                    <xsl:with-param name="en" select="'Rush order'"/>
                                    <xsl:with-param name="fr" select="'Commande urgente'"/>
                                    <xsl:with-param name="it" select="'Ordine urgente'"/>
                                    <xsl:with-param name="de" select="'Eilbestellung'"/>
                                </xsl:call-template></strong>
                            </xsl:if>
                        </td>
						
                        <td align="right">
                            <xsl:value-of select="total_price_compose/currency"/>&#160;<xsl:value-of select="total_price_compose_with_normalized_sum/normalized_sum"/>
                        </td>
					</tr>
					</xsl:for-each>
				</table>
				<br />
				<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td><xsl:value-of select="/notification_data/organization_unit/name"/></td></tr>
                        <tr>
                            <td>
                                <br/><i>powered by SLSP</i>
                            </td>
                        </tr>
				</table>
				<!-- <xsl:call-template name="lastFooter" /> --> <!-- footer.xsl -->
			</body>
	</html>
</xsl:template>

</xsl:stylesheet>