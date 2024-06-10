<?xml version="1.0" encoding="utf-8"?>
<!-- SLSP customized 05/2024
		05/2024 format for receipt printer-->
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="header.xsl" />
<xsl:include href="senderReceiver.xsl" />
<xsl:include href="mailReason.xsl" />
<xsl:include href="footer.xsl" />
<xsl:include href="style.xsl" />
<xsl:include href="recordTitle.xsl" />

<!-- insert transit header without logo-->
<xsl:template name="head-letterName-print-date">
	<table cellspacing="0" cellpadding="5" border="0">
		<xsl:attribute name="style">
			<xsl:call-template name="headerTableStyleCss" />; height: 15mm;
		</xsl:attribute>
		<tr>
			<xsl:for-each select="notification_data/general_data">
				<td>
					<h1><xsl:value-of select="subject"/></h1>
				</td>
				<td align="right">
					<xsl:value-of select="current_date"/>
				</td>
			</xsl:for-each>
		</tr>
	</table>
</xsl:template>

<xsl:template match="/">
<html>
	<head>
	<xsl:call-template name="generalStyle" />
	</head>

	<body style="font-size: 100%; font-family: arial; color:#333;">
		<xsl:call-template name="head-letterName-print-date" />
		<p>
			<strong>@@orderNumber@@: </strong><xsl:value-of  select="notification_data/line_number"/>
		</p>
		<p>
			<strong>@@title@@: </strong><xsl:value-of  select="notification_data/title"/>
		</p>
		<p>
			<strong>@@interestedUsersList@@</strong>
			
			<xsl:for-each select="notification_data/stake_holders_list/poline_stake_holders">
				<br/>
				<xsl:value-of  select="user_display_name"/> (<xsl:value-of  select="email"/>)
			</xsl:for-each>
		</p>
		<p>
			@@sincerely@@
		</p>
		<p>
			<xsl:value-of select="notification_data/organization_unit/name" />
			<br/><br/>
			<i>powered by SLSP</i>
		</p>
	</body>
</html>
</xsl:template>

</xsl:stylesheet>