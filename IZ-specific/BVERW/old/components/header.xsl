<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:ext="http://exslt.org/common"
  extension-element-prefixes="date ext">

<xsl:template name="head">
<table cellspacing="0" cellpadding="5" border="0">
	<xsl:attribute name="style">
		<xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
	</xsl:attribute>
	<!-- LOGO INSERT Uncommented by kas 240114-->
	<!--<tr>
	<xsl:attribute name="style">
		<xsl:call-template name="headerLogoStyleCss" /> 
	</xsl:attribute>
		<td colspan="2">
		<div id="mailHeader">
              <div id="logoContainer" class="alignLeft">
                    <img src="cid:logo.jpg" alt="logo"/>
               </div>
		</div>
		</td>
	</tr>-->
<!-- END OF LOGO INSERT -->
	<tr>

  <xsl:for-each select="notification_data/general_data">
	 <td>
		<h4><xsl:value-of select="letter_name"/></h4> <!--changed from h1 to h3 kas 24012014-->
	</td>
	<td align="right">
		<xsl:value-of select="current_date"/>
	</td>
  </xsl:for-each>

</tr>
</table>


</xsl:template>

</xsl:stylesheet>