<?xml version="1.0" encoding="utf-8"?>
<!-- IZ Customization: removed last name from the greeting

	12/2020 - removed last name
-->
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
				    
				</p>
			</xsl:for-each>
		</td>
	</tr>
</table>


</xsl:template>

</xsl:stylesheet>