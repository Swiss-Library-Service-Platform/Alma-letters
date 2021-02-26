<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />

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
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" />
				<xsl:call-template name="senderReceiver" />

				<br />
				<xsl:call-template name="toWhomIsConcerned" /> <!-- mailReason.xsl -->

				<xsl:if  test="notification_data/transaction_id != ''" >
					<h3>@@transaction_id@@: <xsl:value-of select="notification_data/transaction_id"/></h3>
				</xsl:if>

				<xsl:for-each select="notification_data/labels_list">
                    <p>
                        <xsl:value-of select="notification_data/letter.fineFeePaymentReceiptLetter.message"/>
                    </p>
                </xsl:for-each>

				<br />

				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
					<tr>
						<th align="left">@@fee_type@@</th>
                        <th align="left">
							Title
                        </th>
                        <th align="left">@@payment_date@@</th>
                        <th align="right">@@paid_amount@@</th>
					</tr>
					<xsl:for-each select="notification_data/user_fines_fees_list/user_fines_fees">
					<tr>
                        <td valign="top">
                            <xsl:value-of select="fine_fee_type_display"/>
                            <xsl:if test="fines_fee_transactions/fines_fee_transaction/transaction_note != ''">
                                <br />(<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_note"/>)
                            </xsl:if>
                        </td>
                        <td valign="top">
							<xsl:choose>
								<xsl:when test="item_title != ''">
									<xsl:value-of select="item_title"/>
									<xsl:if test="item_barcode != ''">
										<tt>&#32;(<xsl:value-of select="item_barcode"/>)</tt>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									-
								</xsl:otherwise>
							</xsl:choose>
                        </td>
                        <td valign="top" style="white-space: nowrap;">
                            <xsl:value-of select="create_date"/>
                        </td>
                        <td align="right" valign="top">
                            <xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/>&#160;<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/>
                        </td>
                    </tr>
					</xsl:for-each>

					<tr>
						<td> </td>
                        <td> </td>
						<td align="right"><strong>@@total@@:</strong></td>
						<td align="right"><xsl:value-of select="notification_data/total_amount_paid"/>&#160;<xsl:value-of select="notification_data/currency"/></td>
					</tr>

				</table>
				<br />
				<table>
					<tr>
						<td>@@sincerely@@</td>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="notification_data/organization_unit/name"/>
						</td>
					</tr>
					<tr>
						<td>
							<br/>
							<i>powered by SLSP</i>
						</td>
					</tr>
				</table>

			</body>
	</html>
</xsl:template>

</xsl:stylesheet>