<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

<!-- Source code from https://github.com/uio-library/alma-letters-ubo -->
	<!--
	Template to make it easier to insert multilingual text.
	Depends on: (none)
	USAGE:
		<xsl:call-template name="multilingual">
			<xsl:with-param name="en" select="'Testing multilingual text.'"/>
			<xsl:with-param name="fr" select="'Test de texte multilingue.'"/>
			<xsl:with-param name="it" select="'Test di testi multilingue.'"/>
			<xsl:with-param name="de" select="'Testen von mehrsprachigem Text.'"/>
		</xsl:call-template>
	-->
	<xsl:template name="multilingual">
	<xsl:param name="en" />
	<xsl:param name="fr" />
	<xsl:param name="de" />
	<xsl:param name="it" />
	<xsl:choose>
		<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'fr'"><xsl:value-of select="$fr"/></xsl:when>
		<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'en'"><xsl:value-of select="$en"/></xsl:when>
		<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'it'"><xsl:value-of select="$it"/></xsl:when>
		<xsl:when test="/notification_data/receivers/receiver/preferred_language = 'de'"><xsl:value-of select="$de"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="$en"/></xsl:otherwise>
	</xsl:choose>
	</xsl:template>

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
                            <strong><xsl:call-template name="multilingual">
                                <xsl:with-param name="en" select="'PO number'"/>
                                <xsl:with-param name="fr" select="'Nombre de commande'"/>
                                <xsl:with-param name="it" select="'Numero PO'"/>
                                <xsl:with-param name="de" select="'Bestellnummer'"/>
                            </xsl:call-template></strong>
                            :
                            <xsl:value-of select="po/number"/>
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
                            <xsl:if test="/notification_data/organization_unit/name != ''">
                                <xsl:value-of select="/notification_data/organization_unit/name"/><br />
                            </xsl:if>
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
                            <xsl:if test="/notification_data/organization_unit/name != ''">
                                <xsl:value-of select="/notification_data/organization_unit/name"/><br />
                            </xsl:if>
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
						<th width="25%">
                            @@po_line_number@@
                            / <br />
                            <xsl:call-template name="multilingual">
                                <xsl:with-param name="en" select="'Fund'"/>
                                <xsl:with-param name="fr" select="'Fonds'"/>
                                <xsl:with-param name="it" select="'Fondo'"/>
                                <xsl:with-param name="de" select="'Fonds'"/>
                            </xsl:call-template>
                            / <br />
                            <xsl:call-template name="multilingual">
                                <xsl:with-param name="en" select="'PO Line Owner'"/>
                                <xsl:with-param name="fr" select="'Propriétaire de la ligne PO'"/>
                                <xsl:with-param name="it" select="'Ordine di acquisto linea proprietario'"/>
                                <xsl:with-param name="de" select="'Bestellposten-Besitzer'"/>
                            </xsl:call-template>
                        </th>
						<!-- <th>@@date@@</th> -->
						<!-- <th>@@issn_isbn@@</th> -->
						<th align="center">@@title@@</th>
                        <th width="5%" align="center">@@quantity@@</th>
						<!-- <th>@@price@@</th> -->
						<!-- <th>@@note@@</th> -->
					</tr>
					<xsl:for-each select="notification_data/po/po_line_list/po_line">
					<tr>
						<td>
                            <xsl:value-of select="line_reference"/>
                            / <br />
                            <xsl:for-each select="funds_transaction_items/funds_transaction_item">
                                <xsl:value-of select="fund/name"/>&#160;
                            </xsl:for-each>
                            / <br />
                            <xsl:value-of select="ordering_for"/>
                        </td>
						<!-- <td><xsl:value-of select="create_date"/></td> --> 
						<td>
                            <xsl:value-of select="meta_data_values/title"/><br />
                            <xsl:value-of select="meta_data_values/acqterms_place"/>:
                            <xsl:value-of select="meta_data_values/publisher"/>,
                            <xsl:value-of select="meta_data_values/date"/><br />
                            <xsl:if test="identifier != ''">
                                <xsl:value-of select="identifier_type"/>&#160;<xsl:value-of select="identifier"/><br />
                            </xsl:if>
                            <xsl:if test="vendor_note !=''">
                                <strong>@@note@@:&#160;<xsl:value-of select="vendor_note"/></strong>
                            </xsl:if>
                        </td>
                        <td align="center">
                            <xsl:value-of select="total_quantity"/><br />
                            <xsl:if test="rush = 'true'">
                                <strong><xsl:call-template name="multilingual">
                                    <xsl:with-param name="en" select="'Rush order'"/>
                                    <xsl:with-param name="fr" select="'Commande urgente'"/>
                                    <xsl:with-param name="it" select="'Ordine urgente'"/>
                                    <xsl:with-param name="de" select="'Eilbestellung'"/>
                                </xsl:call-template></strong>
                            </xsl:if>
                        </td>
						<!-- <td align="right">
                            <xsl:value-of select="total_price_compose/currency"/>&#160;<xsl:value-of select="total_price_compose_with_normalized_sum/normalized_sum"/>
                        </td> -->
						
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