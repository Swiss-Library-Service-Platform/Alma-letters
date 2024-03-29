<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized, 09/2021 -->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="toWhomIsConcerned">
<table cellspacing="0" cellpadding="5" border="0">
	<tr>
		<td>
			<xsl:for-each select="notification_data">
				<p>
				    <xsl:attribute name="style">
				        display:block; font-size:1.17em; margin-left:0; margin-right:0; font-weight:bold;
				    </xsl:attribute>
				    @@dear@@ &#160;
				    <xsl:value-of select="receivers/receiver/user/last_name"/>
				</p>
			</xsl:for-each>
		</td>
	</tr>
</table>
</xsl:template>

<!-- New template with only dear label -->
<xsl:template name="dear">
@@dear@@ &#160;
</xsl:template>

</xsl:stylesheet>