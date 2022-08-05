<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 02/2021
		02/2022 - Added SLSP greeting; vertical fee info
		07/2022 - added fee comment and owning library
		08/2022 - on column fee info layout -->
<!-- Dependance: 
		recordTitle - SLSP-multilingual
		style - bodyStyleCss, generalStyle, mainTableStyleCss
		senderReceiver - senderReceiver
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
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>

				<xsl:call-template name="head" />
				<!-- <xsl:call-template name="senderReceiver" /> -->

				<br />

				<!-- <xsl:call-template name="toWhomIsConcerned" />  --><!-- mailReason.xsl -->
				<table cellspacing="0" cellpadding="5" border="0">
					<tr>
						<td>
					<xsl:call-template name="SLSP-multilingual">
						<xsl:with-param name="en" select="'Hello'"/>
						<xsl:with-param name="fr" select="'Bonjour'"/>
						<xsl:with-param name="it" select="'Buongiorno,'"/>
						<xsl:with-param name="de" select="'Guten Tag'"/>
					</xsl:call-template>
						</td>
					</tr>
					<xsl:if  test="notification_data/transaction_id != ''" >
						<tr>
							<td>
								<span>@@transaction_id@@: <xsl:value-of select="notification_data/transaction_id"/></span>
							</td>
						</tr>
					</xsl:if>
					<xsl:for-each select="notification_data/labels_list">
						<tr>
							<td>
								<xsl:value-of select="notification_data/letter.fineFeePaymentReceiptLetter.message"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				<br />

				<table cellpadding="5" class="listing">
				<xsl:attribute name="style">
					<xsl:call-template name="mainTableStyleCss" /> <!-- style.xsl -->
				</xsl:attribute>
					<xsl:for-each select="notification_data/user_fines_fees_list/user_fines_fees">
					<tr>
						<td valign="top">
							<xsl:value-of select="fine_fee_type_display"/>
							<xsl:if test="item_title != ''">
								<br/>
								<strong><xsl:value-of select="substring(item_title, 0, 100)" disable-output-escaping="yes"/></strong>
								<xsl:if test="string-length(item_title) > 100">...</xsl:if>
							</xsl:if>
							<br />
							@@department@@: <xsl:value-of select="fine_owner/name"/>
							<xsl:if test="fine_comment != ''">
								<br />
								@@note@@:
								<xsl:value-of select="fine_comment"/>
							</xsl:if>
							<br />
							@@payment_date@@: <xsl:value-of select="create_date"/>
							<br />
							@@paid_amount@@: <xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_amount_display"/>&#160;<xsl:value-of select="fines_fee_transactions/fines_fee_transaction/transaction_ammount/currency"/>
						</td>
					</tr>
					</xsl:for-each>

					<tr>
						<td align="right" colspan="2"><strong>@@total@@: </strong><xsl:value-of select="notification_data/total_amount_paid"/>&#160;<xsl:value-of select="notification_data/currency"/></td>
					</tr>

				</table>
				<br />
				<table cellspacing="0" cellpadding="5" border="0">
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