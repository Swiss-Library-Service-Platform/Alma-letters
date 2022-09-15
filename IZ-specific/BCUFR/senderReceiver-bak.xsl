<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="senderReceiver">
<table cellspacing="0" cellpadding="5" border="0" width="100%">
	<tr>
		<td width="50%">

<xsl:choose>
		<xsl:when test="notification_data/user_for_printing">
			<table cellspacing="0" cellpadding="5" border="0">
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>

			<tr>
<td>
<xsl:value-of select="notification_data/user_for_printing/postal_code"/>
&#160;
<xsl:value-of select="notification_data/user_for_printing/city"/>

</td>
</tr>

			<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country_display"/></td></tr>

		</table>
		</xsl:when>
		<xsl:when test="notification_data/receivers/receiver/user">
			<xsl:for-each select="notification_data/receivers/receiver/user">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>

			<tr><td><b><xsl:value-of select="last_name"/></b></td></tr>

			<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
			

<tr>
<td>
<xsl:value-of select="user_address_list/user_address/postal_code"/>
&#160;
<xsl:value-of select="user_address_list/user_address/city"/>
</td>
</tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country_display"/></td></tr>
		</table>
	</xsl:for-each>

		</xsl:when>
		<xsl:otherwise>

		</xsl:otherwise>
	</xsl:choose>

		</td>
		<td width="50%" align="right">
			<xsl:for-each select="notification_data/organization_unit">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<tr><td><xsl:value-of select="name"/></td></tr>
			<tr><td><xsl:value-of select="address/line1"/></td></tr>
			<tr><td><xsl:value-of select="address/line2"/></td></tr>
<tr><td><xsl:value-of select="address/line3"/></td></tr>
<tr><td><xsl:value-of select="address/line4"/></td></tr>
<tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
			
			<tr><td><xsl:value-of select="address/country_display"/></td></tr>
		</table>
	</xsl:for-each>
		</td>
	</tr>
</table>
</xsl:template>




<xsl:template name="senderReceiverACQ">
<table cellspacing="0" cellpadding="5" border="0" width="100%">
	<tr>
		<td width="50%">

<xsl:choose>
		<xsl:when test="notification_data/user_for_printing">
			<table cellspacing="0" cellpadding="5" border="0">
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>
			<tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
			<tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>

			<tr>
<td>
<xsl:value-of select="notification_data/user_for_printing/postal_code"/>
&#160;
<xsl:value-of select="notification_data/user_for_printing/city"/>

</td>
</tr>

			<tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country_display"/></td></tr>

		</table>
		</xsl:when>
		<xsl:when test="notification_data/receivers/receiver/user">
			<xsl:for-each select="notification_data/receivers/receiver/user">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>

			<tr><td><b><xsl:value-of select="first_name"/></b></td></tr>

			<tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line3"/></td></tr>
<tr><td><xsl:value-of select="user_address_list/user_address/line4"/></td></tr>
			

<tr>
<td>
<xsl:value-of select="user_address_list/user_address/postal_code"/>
&#160;
<xsl:value-of select="user_address_list/user_address/city"/>
</td>
</tr>
			<tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country_display"/></td></tr>
		</table>
	</xsl:for-each>

		</xsl:when>
		<xsl:otherwise>

		</xsl:otherwise>
	</xsl:choose>

		</td>
		<td width="50%" align="right">
			<xsl:for-each select="notification_data">
		<table>
		<xsl:attribute name="style">
			<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
		</xsl:attribute>


			<!--<tr><td><xsl:value-of select="organization_unit/name"/></td></tr>-->

		<xsl:choose>
			<xsl:when test="po">
				<tr><td><xsl:value-of select="po/ship_to_address/line1"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line2"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line3"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/line4"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/postal_code"/>&#160;<xsl:value-of select="po/ship_to_address/city"/></td></tr>
				<tr><td><xsl:value-of select="po/ship_to_address/country_display"/></td></tr>
			</xsl:when>
			<xsl:otherwise>
				<tr><td><xsl:value-of select="organization_unit/address/line1"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line2"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line3"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/line4"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/postal_code"/>&#160;<xsl:value-of select="organization_unit/address/city"/></td></tr>
				<tr><td><xsl:value-of select="organization_unit/address/country_display"/></td></tr>
			</xsl:otherwise>
		</xsl:choose>
		
		</table>
	</xsl:for-each>
		</td>
	</tr>
</table>
</xsl:template>


</xsl:stylesheet>