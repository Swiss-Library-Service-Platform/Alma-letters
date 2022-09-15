<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP-customized 12/2021 - added onerror attribute to logo so it displays in user attachment preview
			03/2022 - letters in Print Queue use subject in header
			03/2022 - limited height of title and logo to fix sizing for envelopes with window -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
    insert logo & header
-->
<xsl:template name="head">
<table cellspacing="0" cellpadding="5" border="0">
	<!-- SLSP: overwriting style component height -->
	<xsl:attribute name="style">
		<xsl:call-template name="headerTableStyleCss" />; height: 35mm;
	</xsl:attribute>
	<!-- LOGO INSERT -->
	<tr>
	<xsl:attribute name="style">
		<xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
	</xsl:attribute>
		<td colspan="2">
		<div id="mailHeader">
              <div id="logoContainer" class="alignLeft">
					<!-- SLSP: fixing the size of logo so it doesn't affect the sizing for envelopes -->
                    <img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm;"/>
               </div>
		</div>
		</td>
	</tr>
<!-- END OF LOGO INSERT -->
	<tr>

  <xsl:for-each select="notification_data/general_data">
	 <td>
	 	<!-- SLSP: Print Queue letters are using subject label in header;
			the letter_name label variants are unified to English
			so the name in Print Queue is the same no matter the letter language-->
	 	<xsl:choose>
		 	<xsl:when test="letter_type='FulLoanReceiptLetter'">
			 	<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulReturnReceiptLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulHoldShelfRequestSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulReasourceRequestSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FineFeePaymentReceiptLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulTransitSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulOverdueAndLostLoanNotificationLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='FulIncomingSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='InterestedUsersInLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='ResourceSharingReceiveSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='ResourceSharingReturnSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:when test="letter_type='ResourceSharingShippingSlipLetter'">
				<h1><xsl:value-of select="subject"/></h1>
			</xsl:when>
			<xsl:otherwise>
				<h1><xsl:value-of select="letter_name"/></h1>
			</xsl:otherwise>
		</xsl:choose>
	</td>
	<td align="right">
		<xsl:value-of select="current_date"/>
	</td>
  </xsl:for-each>

</tr>
</table>
</xsl:template>

</xsl:stylesheet>