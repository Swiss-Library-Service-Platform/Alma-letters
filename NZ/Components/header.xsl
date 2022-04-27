<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized
	12/2021 - added onerror attribute to logo so it displays in user attachment preview
	05/2022 - added height parameters to control sizing for Post envelopes -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
    header with fixed sizing to fit in windowed envelope
-->
<xsl:template name="head">
	<table cellspacing="0" cellpadding="5" border="0">
        <!-- overloading the height parameter to overwrite the style -->
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
					<img onerror="this.src='/infra/branding/logo/logo-email.png'" src="cid:logo.jpg" alt="logo" style="height:20mm"/>
				</div>
			</div>
			</td>
		</tr>
	<!-- END OF LOGO INSERT -->
		<tr>
			<xsl:for-each select="notification_data/general_data">
				<td>
					<h1><xsl:value-of select="letter_name"/></h1>
				</td>
				<td align="right">
					<xsl:value-of select="current_date"/>
				</td>
			</xsl:for-each>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>