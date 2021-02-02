<?xml version="1.0" encoding="utf-8"?>
<!-- sytle.xsl - 20200929, SLSP -->
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
		<head>
		<xsl:call-template name="generalStyle" />
		</head>
			<body>
			<xsl:attribute name="style">
				<xsl:call-template name="bodyStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
				<xsl:call-template name="head" /> <!-- header.xsl -->
					<div class="messageArea">
				<div class="messageBody">
					<table cellspacing="0" cellpadding="5" border="0">
						<tr>
							<td>@@following_item_requested_on@@ <xsl:value-of select="notification_data/request/create_date"/>, @@can_picked_at@@ </td>
						</tr>
						<tr>
							<td>
								<b>@@call_number@@</b>
								<br />
								<xsl:call-template name="recordTitle" /> <!-- recordTitle.xsl -->
								Barcode: <xsl:value-of select="notification_data/phys_item_display/barcode"/>
								<br/>
								Call number: <xsl:value-of select="notification_data/phys_item_display/call_number" />
								<br/><br/>
								<b> @@circulation_desk@@</b><br/>
								<xsl:value-of select="notification_data/request/delivery_address"/><br/>
							</td>
						</tr>

						<xsl:if test="notification_data/request/work_flow_entity/expiration_date">
							<tr>
								<td>
								@@note_item_held_until@@ <xsl:value-of select="notification_data/request/work_flow_entity/expiration_date"/>.
								</td>
							</tr>
						</xsl:if>
					</table>
				</div>
			</div>
				<br />
				<table>
						<tr><td>@@sincerely@@</td></tr>
						<tr><td><xsl:value-of select="notification_data/request/delivery_address" /></td></tr>
						<tr>
							<td><br/><i>powered by SLSP</i></td>
						</tr>
				</table>
			</body>
	</html>
	</xsl:template>
</xsl:stylesheet>